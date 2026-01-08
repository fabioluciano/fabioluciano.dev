// Unified Card Components
// Consolidated cards with variant support for DRY compliance
// Usage: #import "components/cards.typ": education-card, language-card, cert-card, project-card, publication-card

#import "../design.typ": *

// ═══════════════════════════════════════════════════════════════════════════════
// EDUCATION CARD
// ═══════════════════════════════════════════════════════════════════════════════

#let education-card(study-type, area, institution, date: none, variant: "full") = {
  let (
    text-size,
    small-size,
    date-size,
    card-inset,
    card-radius,
    card-below,
    card-fill
  ) = if variant == "full" {
    (size-body-full, size-small-full, size-date-full, inset-card, radius-large, 0pt, color-bg-light)
  } else {
    (size-company-onepage, size-small-onepage, size-date-onepage, 6pt, radius-medium, 0.25em, white)
  }

  block(
    fill: card-fill,
    radius: card-radius,
    inset: card-inset,
    width: 100%,
    below: card-below,
  )[
    #text(size: text-size, weight: "bold", fill: color-text-bold)[#study-type]
    #linebreak()
    #text(size: small-size, fill: color-text)[#area]
    #linebreak()
    #text(size: date-size, fill: color-muted)[#institution #if date != none [• #date]]
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// LANGUAGE CARD
// ═══════════════════════════════════════════════════════════════════════════════

#let language-card(language, fluency, variant: "full") = {
  let (
    text-size,
    date-size,
    card-inset,
    card-radius,
    card-fill,
    fluency-color
  ) = if variant == "full" {
    (size-body-full, size-date-full, inset-card, radius-large, color-bg-light, color-text)
  } else {
    (size-small-onepage, size-date-onepage, gutter-tiny, radius-small, white, color-text)
  }

  box(
    fill: card-fill,
    radius: card-radius,
    inset: card-inset,
    width: 100%,
  )[
    #text(size: text-size, weight: "bold")[#language]
    #linebreak()
    #text(size: date-size, fill: fluency-color)[#fluency]
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// CERTIFICATION CARD
// ═══════════════════════════════════════════════════════════════════════════════

#let cert-card(name, issuer, date, variant: "full") = {
  let (
    name-size,
    meta-size,
    card-inset,
    card-radius,
    card-below,
    card-fill
  ) = if variant == "full" {
    (size-date-full, 7pt, inset-small, radius-large, 0pt, color-bg-light)
  } else {
    (size-highlight-onepage, 4pt, 5pt, radius-medium, 0.15em, white)
  }

  block(
    fill: card-fill,
    radius: card-radius,
    inset: card-inset,
    width: 100%,
    below: card-below,
  )[
    #text(size: name-size, weight: "semibold", fill: color-text-bold)[#name]
    #if variant == "full" { linebreak() } else { [ ] }
    #text(size: meta-size, fill: color-text)[#issuer • #date]
    #if variant == "onepage" { v(0.5em) }
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// PROJECT CARD
// ═══════════════════════════════════════════════════════════════════════════════

#let project-card(name, url, description, variant: "full") = {
  let (
    name-size,
    desc-size,
    card-inset,
    card-radius,
    card-below,
    card-fill
  ) = if variant == "full" {
    (size-body-full, size-date-full, inset-card, radius-large, 0pt, color-bg-light)
  } else {
    (size-small-onepage, size-date-onepage, 6pt, radius-medium, 0.25em, white)
  }

  block(
    fill: card-fill,
    radius: card-radius,
    inset: card-inset,
    width: 100%,
    below: card-below,
  )[
    #text(size: name-size, weight: "bold", fill: color-accent)[#link(url)[#name]]
    #linebreak()
    #text(size: desc-size, fill: color-text)[#description]
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// PUBLICATION CARD (onepage only, full uses inline)
// ═══════════════════════════════════════════════════════════════════════════════

#let publication-card(name, url, summary, date, variant: "onepage") = {
  block(
    fill: white,
    radius: radius-medium,
    inset: 6pt,
    width: 100%,
    below: 0.25em,
  )[
    #text(size: size-small-onepage, weight: "bold", fill: color-accent)[#link(url)[#name]]
    #linebreak()
    #text(size: size-date-onepage, fill: color-text)[#date]
    #linebreak()
    #text(size: size-date-onepage, fill: color-text)[#summary]
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// SKILL BLOCK
// ═══════════════════════════════════════════════════════════════════════════════

#let skill-block(skill, variant: "full") = {
  let (
    name-size,
    keywords-size,
    block-below
  ) = if variant == "full" {
    (size-small-full, size-date-full, 0pt)
  } else {
    (size-company-onepage, size-highlight-onepage, gutter-xxs)
  }

  let keywords-color = color-text

  if variant == "full" {
    block(
      fill: color-bg-light,
      radius: radius-large,
      inset: inset-card,
      width: 100%,
      below: 0pt,
    )[
      #text(size: name-size, weight: "bold", fill: color-primary)[#skill.name]
      #linebreak()
      #text(size: keywords-size, fill: keywords-color)[#skill.keywords.join(", ")]
    ]
  } else {
    block(below: block-below)[
      #text(size: name-size, weight: "bold", fill: color-primary)[#skill.name]
      #v(-0.2em)
      #text(size: keywords-size, fill: keywords-color)[#skill.keywords.join(", ")]
      #v(0.4em)
    ]
  }
}
