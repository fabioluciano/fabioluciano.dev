// Experience/Job Entry Component
// Unified job entry with variant support
// Usage: #import "components/experience.typ": job-entry

#import "../design.typ": *
#import "../i18n.typ": t

// ═══════════════════════════════════════════════════════════════════════════════
// HIGHLIGHT BULLET
// ═══════════════════════════════════════════════════════════════════════════════

#let highlight-bullet(content, variant: "full") = {
  let (
    bullet-width,
    text-size,
    text-color
  ) = if variant == "full" {
    (12pt, size-small-full, color-text)
  } else {
    (8pt, size-highlight-onepage, color-text)
  }

  grid(
    columns: (bullet-width, 1fr),
    [#text(size: text-size, fill: color-accent)[•]],
    [#text(size: text-size, fill: text-color)[#content]]
  )
}

// ═══════════════════════════════════════════════════════════════════════════════
// JOB ENTRY - FULL VARIANT
// ═══════════════════════════════════════════════════════════════════════════════

#let job-entry-full(position, company, url, department, start, end, highlights, lang: "en") = {
  block(above: spacing-block-full, below: spacing-block-full, width: 100%)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(size: size-job-title-full, weight: "bold", fill: color-text-bold)[#position]
        #h(4pt)
        #text(size: size-body-full, fill: color-muted)[#t("at", lang)]
        #h(4pt)
        #text(size: size-company-full, weight: "semibold", fill: color-accent)[#link(url)[#company]]
        #if department != none [
          #linebreak()
          #text(size: size-small-full, fill: color-muted, style: "italic")[#department]
        ]
      ],
      [#date-badge(format-date(start, end, lang: lang))]
    )

    #if highlights != none and highlights.len() > 0 [
      #v(0.6em)
      #block(inset: (left: 0pt))[
        #for highlight in highlights {
          block(below: 0.45em)[#highlight-bullet(highlight, variant: "full")]
        }
      ]
    ]
  ]
  line(length: 100%, stroke: stroke-normal + color-divider-strong)
}

// ═══════════════════════════════════════════════════════════════════════════════
// JOB ENTRY - ONEPAGE VARIANT
// ═══════════════════════════════════════════════════════════════════════════════

#let job-entry-onepage(position, company, start, end, highlights, lang: "en", show-divider: true) = {
  block(above: 0.2em, below: 0.2em)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        #text(weight: "bold", size: size-job-title-onepage, fill: color-text-bold)[#position]
        #text(size: size-company-onepage, fill: color-accent)[ @ #company]
      ],
      [#date-badge-small(format-date-year(start, end, lang: lang))]
    )
    #v(-0.6em)

    #if highlights != none and highlights.len() > 0 {
      for h in highlights {
        block(below: 0.4em)[#highlight-bullet(h, variant: "onepage")]
      }
    }
  ]
  if show-divider {
    v(0.4em)
    line(length: 100%, stroke: stroke-thin + color-divider)
    v(0.4em)
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// UNIFIED JOB ENTRY
// ═══════════════════════════════════════════════════════════════════════════════

#let job-entry(
  job,
  variant: "full",
  lang: "en",
  show-divider: true
) = {
  if variant == "full" {
    job-entry-full(
      job.position,
      job.name,
      job.url,
      job.at("summary", default: none),
      job.startDate,
      job.at("endDate", default: none),
      job.at("highlights", default: none),
      lang: lang
    )
  } else {
    job-entry-onepage(
      job.position,
      job.name,
      job.startDate,
      job.at("endDate", default: none),
      job.at("highlights", default: none),
      lang: lang,
      show-divider: show-divider
    )
  }
}
