#import "mode.typ":*

#let target = dictionary(std).at("target", default: () => "paged")

#let page-export-template(doc) = context {
  if target() == "html" {
    return doc
  }

  show outline.entry.where(
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

  doc
}