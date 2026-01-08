// Kubernetes Certifications Highlight Component
// Unified K8s highlight box with variant support
// Usage: #import "components/k8s-highlight.typ": k8s-highlight

#import "../design.typ": *
#import "../i18n.typ": t
#import "../filters.typ": filter-k8s-certs, get-k8s-certs-text

// ═══════════════════════════════════════════════════════════════════════════════
// K8S HIGHLIGHT - FULL VARIANT
// ═══════════════════════════════════════════════════════════════════════════════

#let k8s-highlight-full(certs-text, lang: "en") = {
  block(
    fill: color-k8s-bg,
    stroke: stroke-medium + color-k8s,
    radius: radius-large,
    inset: inset-card,
    width: 100%,
    below: gutter-small,
  )[
    #grid(
      columns: (auto, 1fr),
      gutter: inset-card,
      [#nf-icon(icon-k8s, size: 20pt, color: color-k8s)],
      [
        #text(size: size-body-full, weight: "bold", fill: color-k8s)[#upper(t("k8s-title", lang))]
        #linebreak()
        #text(size: size-small-full, fill: color-k8s)[#certs-text]
      ]
    )
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// K8S HIGHLIGHT - ONEPAGE VARIANT
// ═══════════════════════════════════════════════════════════════════════════════

#let k8s-highlight-onepage(lang: "en") = {
  block(
    fill: color-k8s-bg,
    stroke: stroke-medium + color-k8s,
    radius: radius-medium,
    inset: inset-block-onepage,
    width: 100%,
    below: gutter-xxs,
  )[
    #grid(
      columns: (auto, 1fr),
      gutter: inset-block-onepage,
      align: horizon,
      [#nf-icon(icon-k8s, size: 12pt, color: color-k8s)],
      [
        #text(size: size-small-onepage, weight: "bold", fill: color-k8s)[#t("kubestronaut", lang)]
        #linebreak()
        #text(size: size-date-onepage, fill: color-k8s)[
          CKS • CKA • CKAD • KCSA • KCNA
        ]
      ]
    )
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// UNIFIED K8S HIGHLIGHT
// ═══════════════════════════════════════════════════════════════════════════════

#let k8s-highlight(certificates, variant: "full", lang: "en") = {
  let k8s-certs = filter-k8s-certs(certificates)

  if k8s-certs.len() > 0 {
    if variant == "full" {
      k8s-highlight-full(get-k8s-certs-text(certificates), lang: lang)
    } else {
      k8s-highlight-onepage(lang: lang)
    }
  }
}
