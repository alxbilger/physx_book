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


#show heading.where(level:1): it => {
  // reset counter at each chapter
  counter(math.equation).update(0)

  block(
    below: 2.5em,
    breakable: false,
    {
      v(-1em)
      line(length: 100%, stroke: maincolor)
      if counter(heading).get().first() > 0 {
        v(30pt)
        text("Chapter " + str(counter(heading).get().at(0)), size: 2em)
      }
      v(30pt - 1em)
      text(upper(it.body), size:1.2em)
      v(30pt - 1em)
      line(length: 100%, stroke: maincolor)
    })
}

#set math.equation(numbering: n => {
  strong(text(fill:maincolor, numbering("(1.1)",
    counter(heading).get().first(), 
    n)))})
#set math.mat(delim:"[")

#show outline.entry.where(
  level: 1
): it => {
  v(2em, weak: true)
  block(
    below: 2.5em,
    breakable: false,
    {
      grid(columns:(50%, 50%), align: (left, right), 
        text("Chapter " + it.prefix(), fill: maincolor), 
        text(upper(it.body()), fill: maincolor)
      )
      line(length: 100%, stroke: maincolor)
    })
}

#align(center, text(65pt)[
  #text(fill:maincolor, hyphenate: false, smallcaps(title))
])

#align(center)[

  #author

  DEFROST/SED #image("img/inr_logo_rouge.svg", height: 1.5em)

]

#pagebreak()
#include "000_intro.typ"

The sources of this book are available at https://github.com/alxbilger/physx_book

#include "details.typ"

#pagebreak()

#outline(indent: auto)

#show heading.where(depth: 1): body => {    
  pagebreak(weak: true)
  body
}

#import "variables.typ": * 

#include "summaries/000_summaries.typ"
#include "010_lagrangianmechanics.typ"
#include "NewtonSecondLaw/newtonsecondlaw.typ"
#include "030_static.typ"
#include "heat.typ"
#include "050_spring.typ"
#include "060_numericalintegration.typ"
#include "070_linear_solvers.typ"
#include "ExplicitTimeIntegration/explicitTimeIntegration.typ"
#include "090_implicittimeintegration.typ"
#include "100_constraints.typ"
#include "110_mapping.typ"
#include "120_differentiable_simu.typ"
#include "130_continuum_mechanics.typ"
#include "constitutive_equations.typ"
#include "150_fem.typ"
#include "maths.typ"

= Other Resources

@li2024physics


#bibliography("refs.bib")