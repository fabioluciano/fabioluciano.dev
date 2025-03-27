#set page(
  margin: (x: 10pt, y: 10pt),
  flipped: true
)
#set text(
  font: "Open Sans",
  size: 8pt
)

#set par(justify: true)
#set list(spacing: 11pt)

#show link: underline

#show heading: it => [
  #pad(y: 2pt, block(it.body))
]

//////////////////

#grid(
  columns: (25%,25%,25%,25%),
  column-gutter: 4pt,
  inset: 10pt,
  stroke: (_, y) => (
    right: (paint: rgb("E8E8E8"), thickness: 1pt, cap: "round")
  ),
  include "introduction.typ",
  include "academic.typ",
  include "technical-skills.typ",
  include "professional-experiences.typ",
)
