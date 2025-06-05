#import "color.typ":*

#let darkmode = true

#let pagecolor = none
#let textcolor = luma(0%)


#if darkmode == true {
  pagecolor = rgb("1e1e1e")
  textcolor = rgb("fdfdfd")
  maincolor = orange
}