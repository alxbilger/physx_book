#import "@preview/arkheion:0.1.0": arkheion, arkheion-appendices
#import "@preview/dashy-todo:0.0.2": todo

#show: arkheion.with(
  title: "Physics Simulation Cookbook",
  authors: (
  (
      name: "Alexandre Bilger", 
      email: "alexandre.bilger@inria.fr", 
      affiliation: "DEFROST/SED"),
  ),
  abstract: [This cookbook provides a curated collection of fundamental equations essential for simulating solid bodies.],
  keywords: ("Physics simulation",),
  date: datetime.today().display("[day] [month repr:long] [year]"),
)

#include "details.typ"

#set math.equation(numbering: "(1)")

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

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
#include "dynamic.typ"
#include "spring.typ"
#include "numericalintegration.typ"
#include "implicittimeintegration.typ"
#include "constraints.typ"
#include "mapping.typ"
#include "maths.typ"

= Other Resources

@li2024physics


#bibliography("refs.bib")