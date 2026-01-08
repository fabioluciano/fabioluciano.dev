// Section Title Component
// Unified section title with variant support
// Usage: #import "components/section.typ": section-title

#import "../design.typ": *

// Unified section title component
// variant: "full" or "onepage"
#let section-title(title, icon: none, variant: "full") = {
  let (
    spacing-section,
    size-section,
    size-icon,
    tracking,
    stroke-width,
    gutter
  ) = if variant == "full" {
    (spacing-section-full, size-section-full, size-section-icon-full, tracking-normal, stroke-thick, inset-small)
  } else {
    (spacing-section-onepage, size-section-onepage, size-section-icon-onepage, tracking-tight, stroke-medium, gutter-tiny)
  }

  let block-below = if variant == "full" { gutter-medium } else { spacing-section-below-onepage }

  v(spacing-section)
  block(below: block-below, sticky: true)[
    #grid(
      columns: (auto, 1fr),
      gutter: gutter,
      align: horizon,
      [
        #if icon != none and icon != "" [
          #nf-icon(icon, size: size-icon)
        ]
      ],
      [
        #text(size: size-section, weight: "bold", fill: color-primary, tracking: tracking)[#upper(title)]
        #v(-0.9em)
        #line(length: 100%, stroke: stroke-width + color-primary)
      ]
    )
  ]
}
