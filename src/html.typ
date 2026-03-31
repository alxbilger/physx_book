
#let target = dictionary(std).at("target", default: () => "paged")

#let math-bot-label = label("_math_bot_")
#let math-ref-bot-label = label("_math_ref_bot_")

#let y-shifts = state("y-shifts", ())
#let inline-math-count = counter("inline-math-count")

#let shift-inline-math(body) = context {
  let formula-cnt = inline-math-count.get().first()
  inline-math-count.step()
  let begin-loc = here()
  // The wrapper ensures that the viewbox of rendered SVG math matches its bounding box.
  let wrapper = text.with(top-edge: "bounds", bottom-edge: "bounds")
  // For debugging: draw red box around the wrapper
  // let wrapper = it => box(wrapper(it), stroke: red)
  html.elem(
    "span",
    html.frame(wrapper(
      // Add invisible elements below the math body to measure its bottom position.
      math.attach(math.limits(body.body), b: pad([#none#math-bot-label], -1em))
        + sym.wj
        + math.attach(math.limits([#none]), b: pad([#none#math-ref-bot-label], -1em)),
    )),
    attrs: (
      // Rendered SVG defines its width & height in "em" units,
      // so we also convert y-shift relative to text size in "em" units.
      style: "vertical-align: -"
        + str(calc.round(y-shifts.final().at(formula-cnt, default: 0pt) / text.size, digits: 2))
        + "em;",
      class: "typst-inline-math",
    ),
  )
}

#let html-export-template(doc) = context {
  if target() != "html" {
    return doc
  }
  html.head(
    html.elem("link", attrs: (
      rel: "stylesheet",
      href: "style.css",
    ))
  )
  show math.equation.where(block: false): it => {
    // The target() function can be used to apply html.frame selectively only
    // when the export target is HTML.
    // When html.frame is applied to a figure, the target() for all the elements
    // inside will be set to "paged" instead.
    // https://github.com/typst/typst/issues/721#issuecomment-3064895139
    if target() == "html" {
      shift-inline-math(it)
    } else {
      it
    }
  }
  show math.equation.where(block: true): it => context {
    if it.numbering == none {
      html.elem("div", html.frame(it), attrs: (class: "typst-display-math"))
    } else {
      // let num = counter(math.equation).at(here())
      // let rendered-num = numbering(it.numbering, ..num)
      let id-attr = if it.has("label") { str(it.label) } else { "" }

      // Bump the counter in the HTML layout world
      counter(math.equation).step()

      html.elem(
        "div",
        {
          html.elem("span", html.frame(it), attrs: (class: "typst-display-math-body"))
          // html.elem("span", rendered-num, attrs: (class: "typst-eq-number"))
        },
        attrs: (class: "typst-display-math", id: id-attr),
      )
    }
  }
  show ref: it => context {
    // Guard: no element resolved
    if it.element == none {
      html.elem("span", [⚠ unknown ref: #raw(str(it.target))], attrs: (style: "color:red"))
      return
    }

    // Unwrap metadata if needed
    let el = if it.element.func() == metadata {
      it.element.value
    } else {
      it.element
    }

    // Guard: not an equation
    if el.func() != math.equation {
      return it
    }

    // Guard: no numbering
    if el.numbering == none {
      html.elem("span", [⚠ unnumbered eq: #raw(str(it.target))], attrs: (style: "color:red"))
      return
    }

    // Guard: no label
    if not el.has("label") {
      html.elem("span", [⚠ unlabelled eq: #raw(str(it.target))], attrs: (style: "color:red"))
      return
    }

    let num = counter(math.equation).at(el.location())
    let rendered = numbering(el.numbering, ..num)
    html.elem(
      "a",
      rendered,
      attrs: (href: "#" + str(it.target)),
    )
  }
  // Wrap code blocks in a div for styling
  show raw.where(block: true): it => {
    html.elem(
      "div",
      it,
      attrs: (class: "typst-code-block"),
    )
  }
  show heading.where(level: 1): it => context {
    // reset counter at each chapter
    counter(math.equation).update(0)
    let chapter-num = counter(heading).get().first()
    html.elem(
      "h1",
      {
        if chapter-num > 0 {
          html.elem("span", "Chapter " + str(chapter-num) + ": ", attrs: (class: "chapter-label"))
        }
        html.elem("span", it.body, attrs: (class: "chapter-title"))
      },
      attrs: (class: "chapter-heading"),
    )
  }
  show align: it => {
    let a = if it.alignment == center { "center" }
            else if it.alignment == right { "right" }
            else { "left" }
    html.elem("div", it.body, attrs: (style: "text-align: " + a))
  }
  doc
  // After the whole document, calculate the y-shift for every inline math.
  // This reduces the number of `query` calls, improving performance.
  context {
    let math-bots = query(math-bot-label)
    let math-ref-bots = query(math-ref-bot-label)
    if math-bots.len() == inline-math-count.get().first() {
      assert(math-bots.len() == math-ref-bots.len())
      let new-y-shifts = math-bots
        .zip(math-ref-bots, exact: true)
        .map(pair => {
          let (math-bot, math-ref-bot) = pair
          let y1 = math-bot.location().position().y
          let y2 = math-ref-bot.location().position().y
          y1 - y2
        })
      y-shifts.update(old => new-y-shifts)
    }
  }
}