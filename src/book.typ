#import "@preview/shiroa:0.3.1": *
#show: book

#book-meta( // put metadata of your book like book.toml of mdbook
    title: "shiroa",
    description: "shiroa Documentation",
    repository: "https://github.com/Myriad-Dreamin/shiroa",
    authors: ("Myriad-Dreamin", "7mile"),
    language: "en",
    summary: [ // this field works like summary.md of mdbook
        = Introduction
        - #chapter("000_intro.typ")[Intro]
        - #chapter("010_lagrangianmechanics.typ")[Lagrangian mechanics]
    ]
)