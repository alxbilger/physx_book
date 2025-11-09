#import "mode.typ":*

#set page(fill: pagecolor)
#set text(fill: textcolor)

#let title = "Physics Simulation Cookbook"
#let author = "Alexandre Bilger"

#set page(
  paper: "a4",
  header: align(right + horizon)[
    #title
  ],
  numbering: "1"
)
#set par(
  justify: true
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

#align(center, text(65pt)[
  #text(fill:maincolor, hyphenate: false, smallcaps(title))
])

#align(center)[

  #author

  DEFROST/SED #image("img/inr_logo_rouge.svg", height: 1.5em)
  

  This cookbook provides a curated collection of fundamental equations essential for simulating solid bodies.

  The sources of this book are available at https://github.com/alxbilger/physx_book
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
#include "heat.typ"
#include "spring.typ"
#include "numericalintegration.typ"
#include "linear_solvers.typ"
#include "ExplicitTimeIntegration/explicitTimeIntegration.typ"
#include "implicittimeintegration.typ"
#include "constraints.typ"
#include "mapping.typ"
#include "differentiable_simu.typ"
#include "continuum_mechanics.typ"
#include "constitutive_equations.typ"
#include "fem.typ"
#include "maths.typ"

= Other Resources

@li2024physics


#bibliography("refs.bib")