// =============================================================================
// SYMBOL LIBRARY — variables_index.typ
// =============================================================================
//
// OVERVIEW
// --------
// This library provides a lightweight, state-driven system for defining,
// using, and cataloguing mathematical or domain-specific symbols in a Typst
// document.  It is designed for technical reports, theses, and textbooks
// that need a self-updating "List of Symbols" (similar to a List of Figures).
//
// ARCHITECTURE
// ------------
// The library relies on three cooperating mechanisms:
//
//   1. STATE  — `_symbol_definitions` is a document-wide dictionary (managed
//      by Typst's `state`) that maps a short string key to a record
//      containing the rendered symbol content and a human-readable
//      description.  State is write-once-per-location: entries are inserted
//      via `def-sym` and never mutated afterwards.
//
//   2. LABELS & METADATA — Every call to `use-sym` silently appends a
//      `<symbol-usage>` labelled `metadata` node whose value is the symbol
//      key.  During the second Typst compilation pass, `query(<symbol-usage>)`
//      returns every such node in document order, making it possible to
//      collect page references without any external counter.
//
//   3. CONTEXT BLOCKS — Both `use-sym` and `symbol-list` are wrapped in
//      `context { … }` so that Typst evaluates them at layout time (when
//      state and query results are available) rather than at parse time.
//
// PUBLIC API
// ----------
//   def-sym(key, symbol, desc)
//       Register a symbol.  Call this in your preamble or at first use.
//         key    — unique string identifier, e.g. "Re"
//         symbol — Typst content to display, e.g. $bold(R)$ or $RR$
//         desc   — plain-English description shown in the symbol list
//
//   use-sym(key)
//       Inline a previously defined symbol and record this location for
//       back-references.  Returns the symbol content; renders a red error
//       box for unknown keys.
//
//   symbol-list()
//       Render a formatted table of all defined symbols, their descriptions,
//       and page references grouped by chapter (level-1 heading).  Symbols
//       that appear before any level-1 heading are grouped under "Front Matter".
//       Place this call wherever the list should appear (e.g. after the ToC).
//
// KNOWN LIMITATIONS
// -----------------
//   • Like all Typst cross-reference features, this requires at least TWO
//     compilation passes (`typst compile --root . file.typ` twice, or use the
//     `typst watch` mode which reruns automatically).
//   • Symbol keys are case-sensitive strings.  Duplicate `def-sym` calls for
//     the same key silently overwrite the previous entry; to guard against
//     accidental overwriting, enable the duplicate-key warning by setting
//     `_WARN_DUPLICATE_KEYS` to `true` below.
//   • The `<symbol-usage>` label is a single shared anchor; it must remain
//     unique to this library — do not use the same label elsewhere.
//
// USAGE EXAMPLE
// -------------
//   #import "symbol-lib.typ": def-sym, use-sym, symbol-list
//
//   #def-sym("Re",  $bold(R)$,  "Set of real numbers")
//   #def-sym("eps", $epsilon$,  "Arbitrarily small positive quantity")
//
//   Let #use-sym("eps") $> 0$ be given.  For all $x in$ #use-sym("Re") …
//
//   = Appendix
//   #symbol-list()
//
// =============================================================================


// -----------------------------------------------------------------------------
// Configuration
// -----------------------------------------------------------------------------

// Set to `true` to print a compiler warning whenever `def-sym` is called with
// a key that has already been registered.  Useful during development; safe to
// leave `false` in production.
#let _WARN_DUPLICATE_KEYS = false


// -----------------------------------------------------------------------------
// Internal state
// -----------------------------------------------------------------------------

// `_symbol_definitions` holds the entire symbol registry for the document.
// It is a dictionary of the form:
//   (
//     "key1": (symbol: <content>, desc: <content-or-string>),
//     "key2": (symbol: <content>, desc: <content-or-string>),
//     …
//   )
// Using `state` (rather than a plain `let`) is necessary because definitions
// may be scattered throughout the document and state updates are order-aware.
#let _symbol_definitions = state("symbol_defs", (:))


// =============================================================================
// def-sym — register a symbol
// =============================================================================
//
// Parameters
//   key    : str     — unique lookup key (e.g. "lambda", "Re", "mu_0")
//   symbol : content — the rendered symbol, typically a math expression
//   desc   : content — short description for the symbol-list table
//
// Notes
//   • `def-sym` is NOT wrapped in `context` because state updates must happen
//     at build time, not layout time.  This is the correct Typst pattern.
//   • Calling `def-sym` multiple times with the same key overwrites the entry.
//     If `_WARN_DUPLICATE_KEYS` is true, a warning message is shown inline.
//
#let def-sym(key, symbol, desc) = {
  // Optionally emit a visible warning for duplicate registrations.
  // The warning is rendered as a small orange footnote-sized notice so it
  // does not break layout but is easy to spot during draft compilation.
  if _WARN_DUPLICATE_KEYS {
    context {
      let current = _symbol_definitions.get()
      if key in current {
        text(size: 7pt, fill: orange)[⚠ def-sym: key "#key" already defined]
      }
    }
  }

  // Update the shared state dictionary with the new entry.
  // `update` receives the *current* dictionary and must return the *new* one.
  _symbol_definitions.update(defs => {
    defs.insert(key, (symbol: symbol, desc: desc))
    defs
  })
}


// =============================================================================
// use-sym — inline a symbol and record its location
// =============================================================================
//
// Parameters
//   key : str — key that was previously passed to `def-sym`
//
// Returns
//   Content: the symbol followed by a hidden metadata+label node.
//   If the key is unknown, returns a red "[Missing: key]" error block.
//
// How location tracking works
//   Each call appends `#metadata(key)#label("symbol-usage")` to the output.
//   Because this is real content, Typst assigns it a unique location in the
//   layout tree.  `query(<symbol-usage>)` in `symbol-list` then retrieves
//   every such node in order, together with its page location.
//
//   The metadata and label are wrapped in `[]` (content brackets) so that
//   the `+` operator joins the symbol content and the invisible marker without
//   any whitespace being inserted between them.
//
#let use-sym(key) = context {
  let defs = _symbol_definitions.get()

  if key in defs {
    // Retrieve the stored symbol content.
    let sym = defs.at(key).symbol

    // Append the invisible tracking marker.
    // `metadata(key)` stores the key string as queryable data.
    // `label("symbol-usage")` makes the node findable via `query`.
    sym + [#metadata(key)#label("symbol-usage")]

  } else {
    // Unknown key: render a conspicuous red error so the author notices
    // immediately during compilation.  A `panic` would abort compilation
    // entirely, which is often unwanted during drafting.
    text(fill: red, weight: "bold")[\[Missing symbol: "#key"\]]
  }
}


// =============================================================================
// symbol-list — render the full symbol catalogue
// =============================================================================
//
// Produces a three-column table:
//   Symbol | Description | References by Chapter
//
// The "References by Chapter" column lists, for each chapter (level-1 heading)
// in which the symbol appears, the chapter title followed by the page numbers
// on which it appears.  Page numbers are clickable hyperlinks (via `link`).
// Duplicate pages within the same chapter are suppressed.
//
// Symbols are listed in definition order (i.e. the order in which `def-sym`
// was called), which typically matches the order of first introduction.
//
// Placement
//   Call `#symbol-list()` wherever the list should appear in the document.
//   The table is self-contained and requires no arguments.
//
#let symbol-list() = context {
  // Retrieve the complete symbol registry at this point in the document.
  let defs = _symbol_definitions.get()

  // Retrieve every symbol-usage marker placed by `use-sym` throughout the
  // entire document (query always searches the full document regardless of
  // the call site).
  let all-uses = query(<symbol-usage>)

  // ------------------------------------------------------------------
  // Build the table rows — one row per defined symbol.
  // `..for … { (cell, cell, cell) }` spreads the row cells as positional
  // arguments into `table(…)`, which is the standard Typst pattern for
  // programmatically generated table rows.
  // ------------------------------------------------------------------
  table(
    // Column widths: symbol (auto), description (flexible), references (wider flexible)
    columns: (auto, 1fr, 1.5fr),
    inset: 10pt,
    align: (center, left, left),

    // Header row
    table.header(
      [*Symbol*], [*Description*], [*References by Chapter*],
    ),

    // Data rows — one per key in the registry
    ..for (key, data) in defs {

      // Filter all usage markers to those belonging to this symbol key.
      let occurrences = all-uses.filter(it => it.value == key)

      // ----------------------------------------------------------------
      // Group occurrences by chapter.
      //
      // `groups`        : dict  ch-key → (title, pages, seen)
      //   title         : content — the chapter heading body (for display)
      //   pages         : array  — list of formatted, linked page references
      //   seen          : array  — raw integer page numbers already added
      //                            (used for deduplication)
      //
      // `chapter-order` : array — ch-keys in the order they were first seen,
      //                           so that chapter output is in reading order.
      // ----------------------------------------------------------------
      let groups = (:)
      let chapter-order = ()

      for occ in occurrences {
        let loc = occ.location()

        // Absolute (physical) page number — used for deduplication only.
        // Using the raw integer avoids false duplicates that could arise
        // from comparing formatted strings (e.g. "iv" vs "iv").
        let p-num = loc.page()

        // Find the nearest level-1 heading that precedes this occurrence.
        // If none exists, the symbol is in the front matter.
        let preceding-h1 = query(selector(heading.where(level: 1)).before(loc))
        let ch-title = if preceding-h1.len() > 0 {
          preceding-h1.last().body
        } else {
          [Front Matter]
        }

        // Use `repr` of the title content as a stable dictionary key.
        // Direct content values cannot be used as dict keys in Typst.
        let ch-key = repr(ch-title)

        // Create a new group entry the first time we encounter this chapter.
        if ch-key not in groups {
          groups.insert(ch-key, (title: ch-title, pages: (), seen: ()))
          chapter-order.push(ch-key)
        }

        // Deduplicate: only record a page reference once per chapter.
        if p-num not in groups.at(ch-key).seen {
          // `counter(page).at(loc)` returns the *displayed* page number
          // (respecting roman numerals, custom counters, etc.).
          // `.first()` extracts the primary counter value as an integer.
          let displayed-page = counter(page).at(loc).first()

          // Wrap the page number in a hyperlink back to the exact location.
          let p-link = link(loc, str(displayed-page))

          // Append the link and record the raw page to `seen`.
          groups.at(ch-key).pages.push(p-link)
          groups.at(ch-key).seen.push(p-num)
        }
      }

      // ----------------------------------------------------------------
      // Render the "References by Chapter" cell.
      //
      // Format: "Chapter Title: p1, p2; Next Chapter: p3"
      // Each chapter entry is on its own line (via `linebreak`) when there
      // are multiple chapters, keeping the cell readable.
      // If the symbol is never used, display an em-dash.
      // ----------------------------------------------------------------
      let formatted-refs = if chapter-order.len() == 0 {
        [—]
      } else {
        chapter-order.map(k => {
          let g = groups.at(k)
          [*#g.title*: #g.pages.join([, ])]
        }).join([; #linebreak()])
      }

      // Yield the three cells for this table row as a tuple.
      // The `..for` spread above turns these into flat positional arguments.
      (data.symbol, data.desc, formatted-refs)
    }
  )
}
