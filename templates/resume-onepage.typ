// Resume Onepage Template - Single page, landscape, multi-column layout
// Usage: typst compile --input lang=en resume-onepage.typ

#import "design.typ": *
#import "data-loader.typ": load-resume-data
#import "i18n.typ": t
#import "filters.typ": *
#import "components/section.typ": section-title
#import "components/cards.typ": education-card, language-card, cert-card, project-card, publication-card, skill-block
#import "components/experience.typ": job-entry
#import "components/k8s-highlight.typ": k8s-highlight
#import "components/header.typ": header-onepage

#let lang = sys.inputs.at("lang", default: "en")
#let data = load-resume-data(lang)

#let resume-onepage(data, lang: "en") = {
  // Configuration
  let max-experiences = 6
  let main-columns = (1fr, 1.1fr, 0.9fr)
  let languages-columns = (1fr, 1fr, 1fr)

  // Page setup
  set page(paper: "a4", flipped: true, margin: margin-onepage, fill: color-bg-white)
  set text(font: font-sans, size: size-body-onepage, lang: lang, fill: color-text)
  set par(leading: spacing-line-onepage, justify: false)

  // ═══════════════════════════════════════════════════════════════════
  // HEADER - Full width banner
  // ═══════════════════════════════════════════════════════════════════

  header-onepage(data, lang: lang)

  // ═══════════════════════════════════════════════════════════════════
  // MAIN CONTENT - Three columns
  // ═══════════════════════════════════════════════════════════════════

  block(height: 1fr, width: 100%)[
    #grid(
      columns: main-columns,
      rows: (100%),
      gutter: gutter-medium,

    // COLUMN 1: Summary + Skills + Languages
    block(
      fill: color-bg-column,
      radius: radius-large,
      inset: inset-block-onepage,
      width: 100%,
      height: 100%,
      clip: true,
    )[
      #section-title(t("summary", lang), icon: icon-summary, variant: "onepage")
      #block(fill: white, radius: radius-medium, inset: 6pt, width: 100%)[
        #set par(leading: 0.5em)
        #text(size: size-highlight-onepage, fill: color-text)[#data.basics.summary]
      ]

      #v(0.2em)
      #section-title(t("skills", lang), icon: icon-skills, variant: "onepage")

      #for skill in data.skills {
        skill-block(skill, variant: "onepage")
      }

      #v(0.4em)
      #section-title(t("languages", lang), icon: icon-languages, variant: "onepage")
      #grid(
        columns: languages-columns,
        gutter: gutter-tiny,
        ..data.languages.map(l => language-card(l.language, l.fluency, variant: "onepage"))
      )
    ],

    // COLUMN 2: Experience
    block(
      fill: white,
      radius: radius-large,
      inset: inset-block-onepage,
      width: 100%,
      height: 100%,
      clip: true,
    )[
      #section-title(t("experience", lang), icon: icon-experience, variant: "onepage")

      #for (i, job) in data.work.slice(0, max-experiences).enumerate() {
        job-entry(job, variant: "onepage", lang: lang, show-divider: i < max-experiences - 1)
      }
    ],

    // COLUMN 3: Certifications + Education + Projects
    block(
      fill: color-bg-column,
      radius: radius-large,
      inset: inset-block-onepage,
      width: 100%,
      height: 100%,
      clip: true,
    )[
      #section-title(t("certifications", lang), icon: icon-certifications, variant: "onepage")

      #k8s-highlight(data.certificates, variant: "onepage", lang: lang)

      #for cert in filter-other-certs(data.certificates) {
        block(below: 0.4em)[
          #text(size: size-small-onepage, weight: "semibold", fill: color-text-bold)[#cert.name]
          #text(size: size-date-onepage, fill: color-text)[ • #cert.issuer]
        ]
      }

      #v(0.4em)
      #section-title(t("education", lang), icon: icon-education, variant: "onepage")

      #for edu in data.education {
        education-card(edu.studyType, edu.area, edu.institution, variant: "onepage")
      }

      #v(0.4em)
      #section-title(t("projects", lang), icon: icon-projects, variant: "onepage")

      #if data.at("projects", default: none) != none {
        for project in data.projects {
          project-card(project.name, project.url, project.description, variant: "onepage")
        }
      }

      #v(0.4em)
      #section-title(t("publications", lang), icon: icon-speaking, variant: "onepage")

      #if data.at("publications", default: none) != none {
        for pub in data.publications {
          publication-card(pub.name, pub.url, pub.summary, pub.releaseDate)
        }
      }
    ]
    )
  ]
}

#resume-onepage(data, lang: lang)
