// Resume Full Template - Complete resume with all details
// Usage: typst compile --input lang=en resume-full.typ

#import "design.typ": *
#import "data-loader.typ": load-resume-data
#import "i18n.typ": t
#import "filters.typ": filter-k8s-certs, filter-other-certs, get-k8s-certs-text
#import "components/section.typ": section-title
#import "components/cards.typ": education-card, language-card, cert-card, project-card, skill-block
#import "components/experience.typ": job-entry
#import "components/k8s-highlight.typ": k8s-highlight
#import "components/header.typ": header-full

#let lang = sys.inputs.at("lang", default: "en")
#let data = load-resume-data(lang)

#let resume(data, lang: "en") = {
  // Page setup
  set page(paper: "a4", margin: margin-full)
  set text(font: font-primary, size: size-body-full, lang: lang, fill: color-text)
  set par(leading: spacing-line-full)

  // ═══════════════════════════════════════════════════════════════════
  // HEADER
  // ═══════════════════════════════════════════════════════════════════

  header-full(data, lang: lang)

  // ═══════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════

  section-title(t("summary", lang), icon: icon-summary, variant: "full")
  summary-block(data.basics.summary)

  // ═══════════════════════════════════════════════════════════════════
  // WORK EXPERIENCE
  // ═══════════════════════════════════════════════════════════════════

  section-title(t("experience", lang), icon: icon-experience, variant: "full")

  for job in data.work {
    job-entry(job, variant: "full", lang: lang)
  }

  // ═══════════════════════════════════════════════════════════════════
  // EDUCATION
  // ═══════════════════════════════════════════════════════════════════

  section-title(t("education", lang), icon: icon-education, variant: "full")

  grid(
    columns: (1fr, 1fr),
    gutter: gutter-medium,
    ..data.education.map(edu => education-card(edu.studyType, edu.area, edu.institution, date: edu.startDate, variant: "full"))
  )

  // ═══════════════════════════════════════════════════════════════════
  // CERTIFICATIONS
  // ═══════════════════════════════════════════════════════════════════

  section-title(t("certifications", lang), icon: icon-certifications, variant: "full")

  k8s-highlight(data.certificates, variant: "full", lang: lang)

  grid(
    columns: (1fr, 1fr),
    gutter: gutter-xs,
    ..filter-other-certs(data.certificates).map(c => cert-card(c.name, c.issuer, c.date, variant: "full"))
  )

  // ═══════════════════════════════════════════════════════════════════
  // SKILLS
  // ═══════════════════════════════════════════════════════════════════

  section-title(t("skills", lang), icon: icon-skills, variant: "full")

  grid(
    columns: (1fr, 1fr),
    gutter: gutter-xs,
    ..data.skills.map(skill => skill-block(skill, variant: "full"))
  )

  // ═══════════════════════════════════════════════════════════════════
  // LANGUAGES
  // ═══════════════════════════════════════════════════════════════════

  section-title(t("languages", lang), icon: icon-languages, variant: "full")

  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: gutter-small,
    ..data.languages.map(l => language-card(l.language, l.fluency, variant: "full"))
  )

  // ═══════════════════════════════════════════════════════════════════
  // PROJECTS
  // ═══════════════════════════════════════════════════════════════════

  if data.at("projects", default: none) != none and data.projects.len() > 0 {
    section-title(t("projects", lang), icon: icon-projects, variant: "full")
    grid(
      columns: (1fr, 1fr),
      gutter: gutter-small,
      ..data.projects.map(p => project-card(p.name, p.url, p.description, variant: "full"))
    )
  }

  // ═══════════════════════════════════════════════════════════════════
  // PUBLICATIONS/TALKS
  // ═══════════════════════════════════════════════════════════════════

  if data.at("publications", default: none) != none and data.publications.len() > 0 {
    section-title(t("publications", lang), icon: icon-speaking, variant: "full")

    for pub in data.publications {
      block(below: gutter-small)[
        #grid(
          columns: (auto, 1fr),
          gutter: inset-small,
          [#date-badge(pub.releaseDate, size: 7pt)],
          [
            #text(size: size-body-full, weight: "semibold")[#pub.name]
            #linebreak()
            #text(size: size-date-full, fill: color-muted)[#pub.summary]
          ]
        )
      ]
    }
  }
}

#resume(data, lang: lang)
