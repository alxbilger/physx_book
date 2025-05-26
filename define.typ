#let myblock(body, title) = block(
  above: 2em, stroke: 0.5pt,
  width: 100%, inset: 14pt
)[
  #place(
    top + left,
    dy: -6pt - 14pt, // Account for inset of block
    dx: 6pt - 14pt,
    block(fill: white, inset: 2pt, title)
  )
  #body
]

#let result(body) = myblock(body, text("RESULT", weight: "bold"))

#let definition(body) = myblock(body, text("DEFINITION", weight: "bold"))