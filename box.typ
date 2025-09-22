#import "color.typ":maincolor, green, purple
#import "mode.typ":*
#import "@preview/showybox:2.0.4": showybox

#let mybox(body, title: none, color: maincolor) = {
  showybox(
    title-style: (
      weight: 900,
      color: color.darken(20%),
      sep-thickness: 0pt,
    ),
    frame: (
      body-color: pagecolor,
      title-color: if darkmode == true {color.darken(65%)} else {color.lighten(80%)},
      border-color: color.darken(20%),
      footer-color: color.lighten(80%),
      body-inset: (left: 1em, right: 0em, y:0.8em),
      thickness: (left: 2pt),
      radius: 0pt,
    ),
    body-style: (
      color: textcolor
    ),
    title: ( title ),
    spacing: 0.8em,
    breakable: false,
  )[#body]
}

#let prefixedbox(body, title: none, prefix: none, color: maincolor) = {
  if title != none {
    mybox(body, title: smallcaps(prefix) + " | " + title, color: color)
  }
  else if prefix != none {
    mybox(body, title: smallcaps(prefix), color: color)
  }
  else {
    mybox(body, title: none, color: color)
  }

}

#let definition(body, title: none, color: green) = {
  prefixedbox(body, prefix: "Definition", title: title, color: color)
}

#let property(body, title: none, color: purple) = {
  prefixedbox(body, prefix: "Property", title: title, color: color)
}

#let result(body, title: none, color: red) = {
  prefixedbox(body, prefix: "Result", title: title, color: color)
}

#let proof(body, title: none, color: orange) = {
  prefixedbox(body, prefix: "Proof", title: title, color: color)
}

#let todo(body, title: none, color: green) = {
  prefixedbox(body, prefix: "TODO", title: title, color: color)
}

#let examplebox(body, title: none, color: gray) = {
  prefixedbox(body, prefix: "Example", title: title, color: color)
}