#import "@preview/showybox:2.0.4": showybox

#let title = "Physics Simulation Cookbook"
#let author = "Alexandre Bilger"

#let red    = rgb(177, 109, 104)
#let green  = rgb(151, 194, 134)
#let blue   = rgb(90, 124, 166)
#let orange = rgb(220, 159, 80)
#let purple = rgb(160, 150, 221)
#let gray   = rgb(151, 163, 146)

#let maincolor = blue

#set page(
  paper: "a4",
  header: align(right + horizon)[
    #title
  ],
  numbering: "1"
)
#set heading(numbering: "1.")
#show heading: set text(maincolor)
#set document(
  title: [#title],
  date: auto,
  author: (author),
  keywords: ("Physics simulation", )
)

// reset counter at each chapter
// if you want to change the number of displayed 
// section numbers, change the level there
#show heading.where(level:1): it => {
  counter(math.equation).update(0)
  it
}
#set math.equation(numbering: n => {
  strong(text(fill:maincolor, numbering("(1.1)",
    counter(heading).get().first(), 
    n)))})
#set math.mat(delim:"[")

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

#align(center, text(45pt)[
  #text(fill:maincolor, title)
])

#align(center)[

  #author

  DEFROST/SED, Inria

  This cookbook provides a curated collection of fundamental equations essential for simulating solid bodies.
]
#include "details.typ"

#pagebreak()

#outline(indent: auto)

#show heading.where(depth: 1): body => {    
  pagebreak(weak: true)
  body
}

#import "variables.typ": * 

#include "lagrangianmechanics.typ"
#include "NewtonSecondLaw/newtonsecondlaw.typ"
#include "static.typ"
#include "spring.typ"
#include "numericalintegration.typ"
#include "implicittimeintegration.typ"
#include "constraints.typ"
#include "mapping.typ"
#include "maths.typ"

= Other Resources

@li2024physics


#bibliography("refs.bib")