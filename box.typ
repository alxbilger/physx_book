#import "color.typ":maincolor, green, purple
#import "@preview/showybox:2.0.4": showybox

#let mybox(body, title: none, color: maincolor) = {
  showybox(
    title-style: (
      weight: 900,
      color: color.darken(20%),
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: color.lighten(70%),
      border-color: color.darken(20%),
      footer-color: color.lighten(80%),
      body-inset: (left: 1em, right: 0em, y:1em),
      thickness: (left: 2pt),
      radius: 0pt,
    ),
    title: ( title ),
    spacing: 1em,
    breakable: false,
  )[#body]
}

#let prefixedbox(body, title: none, prefix: none, color: maincolor) = {
  if title != none {
    mybox(body, title: prefix + ": " + title, color: color)
  }
  else if prefix != none {
    mybox(body, title: prefix, color: color)
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