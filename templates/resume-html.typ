// Resume HTML Template - Semantic HTML with Tailwind CSS
// Usage: typst compile --features html --format html --input lang=en resume-html.typ

#import "design.typ": *
#import "data-loader.typ": load-resume-data
#import "i18n.typ": t
#import "filters.typ": filter-k8s-certs, filter-other-certs, get-k8s-certs-text

#let lang = sys.inputs.at("lang", default: "en")
#let data = load-resume-data(lang)

// ═══════════════════════════════════════════════════════════════════════════════
// TAILWIND CSS CLASSES (Design Tokens)
// ═══════════════════════════════════════════════════════════════════════════════

#let tw = (
  // Primary colors - Kubestronaut Premium (Amber/Gold)
  primary-text: "text-amber-700 dark:text-amber-500",
  primary-border: "border-amber-700 dark:border-amber-500",
  accent-text: "text-amber-600 dark:text-amber-400",
  accent-hover: "hover:text-amber-800 dark:hover:text-amber-300",
  muted-text: "text-slate-500 dark:text-slate-400",
  bg-card: "bg-stone-50 dark:bg-slate-800",
  // K8s specific (blue only for Kubernetes)
  k8s-text: "text-blue-600 dark:text-blue-400",
  k8s-border: "border-blue-500",
  k8s-bg: "bg-blue-50 dark:bg-blue-900/30",
  // Section header style - Premium gold
  section-header: "flex items-center gap-3 text-lg font-bold uppercase tracking-wider text-amber-700 dark:text-amber-500 pb-2 border-b-2 border-amber-700 dark:border-amber-500",
)

// Nerd Font icons for HTML (same as design.typ)
#let nf-icon-html(name) = {
  let icons = (
    // Social (nf-fa brand icons)
    "github": "\u{f09b}",      // nf-fa-github
    "linkedin": "\u{f0e1}",    // nf-fa-linkedin
    "twitter": "\u{f099}",     // nf-fa-twitter
    "telegram": "\u{f2c6}",    // nf-fa-telegram
    "blog": "\u{f02d}",        // nf-fa-book
    // Contact (nf-md icons)
    "email": "󰇮",              // nf-md-email
    "phone": "\u{f095}",       // nf-fa-phone
    "location": "\u{f041}",    // nf-fa-map_marker
    "website": "󰖟",            // nf-md-web
    // Sections (nf-fa icons)
    "summary": "\u{f15c}",     // nf-fa-file_text
    "experience": "\u{f0b1}",  // nf-fa-briefcase
    "education": "\u{f19d}",   // nf-fa-graduation_cap
    "certifications": "\u{f0a3}", // nf-fa-certificate
    "skills": "\u{f121}",      // nf-fa-code
    "languages": "\u{f1ab}",   // nf-fa-language
    "projects": "\u{f07b}",    // nf-fa-folder_open
    "speaking": "\u{f130}",    // nf-fa-microphone
    "k8s": "󱃾",                // nf-md-kubernetes
    // Navigation bar icons
    "pdf": "󰈙",                // nf-md-file_pdf_box
    "download": "󰇚",           // nf-md-download
  )
  let icon-char = icons.at(lower(name), default: "")
  html.elem("span", attrs: (class: "nf mr-1"))[#icon-char]
}

#let format-date-range-html(start, end, lang: "en") = {
  let end-text = if end == "" or end == none { t("present", lang) } else { end }
  start + " — " + end-text
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN DOCUMENT
// ═══════════════════════════════════════════════════════════════════════════════

#set document(
  title: data.basics.name + " - " + data.basics.label,
  author: data.basics.name,
)

// ═══════════════════════════════════════════════════════════════════════════════
// NAVIGATION BAR
// ═══════════════════════════════════════════════════════════════════════════════

#html.nav(class: "fixed top-0 left-0 right-0 z-50 bg-white/90 dark:bg-slate-900/90 backdrop-blur-sm border-b border-slate-200 dark:border-slate-700 print:hidden", aria-label: "Document options")[
  #html.div(class: "max-w-4xl mx-auto px-4 py-3 flex items-center justify-between gap-4")[
    // Language Switch
    #html.div(class: "flex items-center gap-2")[
      #html.span(class: "text-xs text-slate-500 dark:text-slate-400 hidden sm:inline")[#nf-icon-html("languages") #if lang == "en" { "Language:" } else { "Idioma:" }]
      #if lang == "en" [
        #html.span(class: "text-sm font-semibold text-slate-900 dark:text-slate-100 px-2 py-1 bg-amber-100 dark:bg-amber-900 rounded")[EN]
        #html.a(href: "../ptbr/index.html", class: "text-sm text-slate-600 dark:text-slate-400 hover:text-amber-700 dark:hover:text-amber-400 px-2 py-1 rounded hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors")[PT]
      ] else [
        #html.a(href: "../en/index.html", class: "text-sm text-slate-600 dark:text-slate-400 hover:text-amber-700 dark:hover:text-amber-400 px-2 py-1 rounded hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors")[EN]
        #html.span(class: "text-sm font-semibold text-slate-900 dark:text-slate-100 px-2 py-1 bg-amber-100 dark:bg-amber-900 rounded")[PT]
      ]
    ]

    // PDF Downloads
    #html.div(class: "flex items-center gap-2")[
      #html.span(class: "text-xs text-slate-500 dark:text-slate-400 hidden sm:inline")[#nf-icon-html("pdf") PDF:]
      #html.a(href: "resume.pdf", class: "inline-flex items-center gap-1 text-xs font-medium text-amber-600 dark:text-amber-400 hover:text-amber-800 dark:hover:text-amber-300 px-2 py-1 rounded border border-amber-400 dark:border-amber-700 hover:bg-amber-50 dark:hover:bg-amber-900/30 transition-colors", download: "")[#nf-icon-html("download") Full]
      #html.a(href: "resume-onepage.pdf", class: "inline-flex items-center gap-1 text-xs font-medium text-amber-600 dark:text-amber-400 hover:text-amber-800 dark:hover:text-amber-300 px-2 py-1 rounded border border-amber-400 dark:border-amber-700 hover:bg-amber-50 dark:hover:bg-amber-900/30 transition-colors", download: "")[#nf-icon-html("download") 1-Page]
    ]

    // Theme Toggle
    #html.elem("button",
      attrs: (
        id: "theme-toggle",
        type: "button",
        class: "p-2 rounded-full bg-slate-200 dark:bg-slate-700 hover:bg-slate-300 dark:hover:bg-slate-600 shadow transition-all duration-300 cursor-pointer",
        "aria-label": "Toggle dark mode",
        onclick: "toggleTheme()"
      )
    )[
      #html.span(id: "icon-sun", class: "hidden dark:block text-lg")[☀️]
      #html.span(id: "icon-moon", class: "block dark:hidden text-lg")[🌙]
    ]
  ]
]

#html.div(class: "h-14 print:hidden")[]

// ═══════════════════════════════════════════════════════════════════════════════
// HEADER
// ═══════════════════════════════════════════════════════════════════════════════

#html.header(class: "pb-8 mb-8 border-b-2 border-slate-300", role: "banner")[
  // Name and label (centered)
  #html.div(class: "text-center mb-6")[
    #html.h1(class: "text-4xl font-bold tracking-wide text-slate-900 dark:text-slate-100 mb-2")[#data.basics.name]
    #html.p(class: "text-lg font-medium " + tw.primary-text)[#data.basics.label]
  ]

  // Photo + Contact + Social (3 equal columns)
  #html.div(class: tw.bg-card + " rounded-lg p-6")[
    #html.div(class: "grid grid-cols-1 md:grid-cols-3 gap-6 md:divide-x divide-slate-300 dark:divide-slate-600")[
      // Photo (left)
      #html.div(class: "flex justify-center items-center")[
        #if data.basics.at("image", default: none) != none [
          #html.img(
            src: "../" + data.basics.image,
            alt: data.basics.name,
            class: "w-32 h-32 rounded-full object-cover object-top border-4 border-amber-600 shadow-lg"
          )
        ]
      ]

      // Contact info (center)
      #html.div(class: "md:pl-6")[
        #html.h3(class: "text-sm font-bold " + tw.primary-text + " mb-3")[#t("contact", lang)]
        #html.address(class: "not-italic space-y-2")[
          #html.a(href: "mailto:" + data.basics.email, class: "flex items-center gap-2 text-sm " + tw.accent-text + " hover:text-amber-800 hover:underline")[#nf-icon-html("email") #data.basics.email]
          #html.span(class: "flex items-center gap-2 text-sm text-slate-500")[#nf-icon-html("phone") #data.basics.phone]
          #html.span(class: "flex items-center gap-2 text-sm text-slate-500")[#nf-icon-html("location") #data.basics.location.city, #data.basics.location.region]
          #html.a(href: data.basics.url, class: "flex items-center gap-2 text-sm " + tw.accent-text + " hover:text-amber-800 hover:underline", target: "_blank")[#nf-icon-html("website") Website]
        ]
      ]

      // Social links (right)
      #html.div(class: "md:pl-6")[
        #html.h3(class: "text-sm font-bold " + tw.primary-text + " mb-3")[#t("social", lang)]
        #html.nav(class: "space-y-2", aria-label: "Social profiles")[
          #for profile in data.basics.profiles [
            #html.a(href: profile.url, class: "flex items-center gap-2 text-sm font-medium " + tw.accent-text + " hover:text-amber-800 transition-colors", target: "_blank", rel: "noopener")[#nf-icon-html(profile.network) #profile.network]
          ]
        ]
      ]
    ]
  ]
]

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN CONTENT
// ═══════════════════════════════════════════════════════════════════════════════

#html.main(class: "space-y-10")[
  // SUMMARY
  #html.section(class: "space-y-4", aria-labelledby: "summary-title")[
    #html.h2(id: "summary-title", class: tw.section-header)[#nf-icon-html("summary") #t("summary", lang)]
    #html.p(class: tw.bg-card + " p-5 rounded-lg leading-relaxed text-slate-700 dark:text-slate-300")[#data.basics.summary]
  ]

  // WORK EXPERIENCE
  #html.section(class: "space-y-4", aria-labelledby: "experience-title")[
    #html.h2(id: "experience-title", class: tw.section-header)[#nf-icon-html("experience") #t("experience", lang)]

    #for job in data.work [
      #html.article(class: "pb-5 mb-5 border-b border-slate-200 dark:border-slate-700 last:border-b-0 last:mb-0 last:pb-0")[
        #html.header(class: "flex flex-col sm:flex-row sm:justify-between sm:items-start gap-2 mb-3")[
          #html.div(class: "flex-1")[
            #html.h3(class: "text-lg font-semibold text-slate-900 dark:text-slate-100 mb-1")[#job.position]
            #html.p(class: "text-base text-slate-700 dark:text-slate-300")[
              #html.span(class: "text-slate-500")[ #t("at", lang) ]
              #html.a(href: job.url, class: "font-medium " + tw.accent-text + " hover:underline", target: "_blank", rel: "noopener")[#job.name]
            ]
            #if job.at("summary", default: none) != none [
              #html.p(class: "text-sm italic " + tw.muted-text + " mt-1")[#job.summary]
            ]
          ]
          #html.span(class: "shrink-0 text-sm font-medium " + tw.muted-text + " bg-slate-100 dark:bg-slate-700 px-3 py-2 rounded-md whitespace-nowrap")[
            #format-date-range-html(job.startDate, job.at("endDate", default: none), lang: lang)
          ]
        ]

        #if job.at("highlights", default: none) != none and job.highlights.len() > 0 [
          #html.ul(class: "mt-3 pl-4 space-y-2")[
            #for highlight in job.highlights [
              #html.li(class: "relative pl-4 text-sm text-slate-700 dark:text-slate-300 leading-relaxed before:content-['•'] before:absolute before:left-0 before:text-sky-500 before:font-bold")[#highlight]
            ]
          ]
        ]
      ]
    ]
  ]

  // EDUCATION
  #html.section(class: "space-y-4", aria-labelledby: "education-title")[
    #html.h2(id: "education-title", class: tw.section-header)[#nf-icon-html("education") #t("education", lang)]

    #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-4")[
      #for edu in data.education [
        #html.article(class: tw.bg-card + " p-4 rounded-lg")[
          #html.h3(class: "text-base font-semibold text-slate-900 dark:text-slate-100 mb-1")[#edu.studyType]
          #html.p(class: "text-sm text-slate-700 dark:text-slate-300 mb-2")[#edu.area]
          #html.p(class: "text-xs " + tw.muted-text)[#edu.institution #html.span(class: "mx-2")[•] #edu.startDate]
        ]
      ]
    ]
  ]

  // CERTIFICATIONS
  #html.section(class: "space-y-4", aria-labelledby: "certs-title")[
    #html.h2(id: "certs-title", class: tw.section-header)[#nf-icon-html("certifications") #t("certifications", lang)]

    #{
      let k8s-certs = filter-k8s-certs(data.certificates)

      if k8s-certs.len() > 0 [
        #html.div(class: "flex items-center gap-4 " + tw.k8s-bg + " border-2 " + tw.k8s-border + " p-4 rounded-lg mb-5")[
          #html.span(class: "text-4xl nf " + tw.k8s-text)[󱃾]
          #html.div[
            #html.h3(class: "text-base font-bold " + tw.k8s-text + " uppercase tracking-wider mb-1")[#t("k8s-title", lang)]
            #html.p(class: "text-sm " + tw.k8s-text)[#get-k8s-certs-text(data.certificates)]
          ]
        ]
      ]
    }

    #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-3")[
      #{
        for cert in filter-other-certs(data.certificates) [
          #html.article(class: "border border-slate-300 dark:border-slate-600 p-3 rounded-md")[
            #html.h3(class: "text-sm font-semibold text-slate-900 dark:text-slate-100 mb-1")[#cert.name]
            #html.p(class: "text-xs " + tw.muted-text)[#cert.issuer #html.span(class: "mx-2")[•] #cert.date]
          ]
        ]
      }
    ]
  ]

  // SKILLS
  #html.section(class: "space-y-4", aria-labelledby: "skills-title")[
    #html.h2(id: "skills-title", class: tw.section-header)[#nf-icon-html("skills") #t("skills", lang)]

    #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-4")[
      #for skill in data.skills [
        #html.article(class: "mb-2")[
          #html.h3(class: "text-sm font-semibold " + tw.primary-text + " mb-2")[#skill.name]
          #html.ul(class: "flex flex-wrap gap-2")[
            #for keyword in skill.keywords [
              #html.li(class: "text-xs " + tw.muted-text + " bg-slate-100 dark:bg-slate-700 px-2 py-1 rounded")[#keyword]
            ]
          ]
        ]
      ]
    ]
  ]

  // LANGUAGES
  #html.section(class: "space-y-4", aria-labelledby: "languages-title")[
    #html.h2(id: "languages-title", class: tw.section-header)[#nf-icon-html("languages") #t("languages", lang)]

    #html.div(class: "grid grid-cols-2 md:grid-cols-3 gap-4")[
      #for language in data.languages [
        #html.article(class: tw.bg-card + " p-3 rounded-md text-center")[
          #html.h3(class: "text-base font-semibold text-slate-900 dark:text-slate-100 mb-1")[#language.language]
          #html.p(class: "text-xs " + tw.muted-text)[#language.fluency]
        ]
      ]
    ]
  ]

  // PROJECTS
  #if data.at("projects", default: none) != none and data.projects.len() > 0 [
    #html.section(class: "space-y-4", aria-labelledby: "projects-title")[
      #html.h2(id: "projects-title", class: tw.section-header)[#nf-icon-html("projects") #t("projects", lang)]

      #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-4")[
        #for project in data.projects [
          #html.article(class: "border border-slate-300 dark:border-slate-600 p-4 rounded-lg hover:shadow-md transition-shadow")[
            #html.h3(class: "text-base font-semibold mb-2")[
              #html.a(href: project.url, class: tw.accent-text + " hover:underline", target: "_blank", rel: "noopener")[#project.name]
            ]
            #html.p(class: "text-sm " + tw.muted-text + " leading-relaxed")[#project.description]
          ]
        ]
      ]
    ]
  ]

  // PUBLICATIONS/TALKS
  #if data.at("publications", default: none) != none and data.publications.len() > 0 [
    #html.section(class: "space-y-4", aria-labelledby: "publications-title")[
      #html.h2(id: "publications-title", class: tw.section-header)[#nf-icon-html("speaking") #t("publications", lang)]

      #for pub in data.publications [
        #html.article(class: "flex gap-4 mb-4 last:mb-0")[
          #html.span(class: "shrink-0 text-xs font-medium " + tw.muted-text + " bg-slate-100 dark:bg-slate-700 px-2 py-1 rounded h-fit")[#pub.releaseDate]
          #html.div[
            #html.h3(class: "text-base font-semibold text-slate-900 dark:text-slate-100 mb-1")[#pub.name]
            #html.p(class: "text-sm " + tw.muted-text)[#pub.summary]
          ]
        ]
      ]
    ]
  ]
]

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER
// ═══════════════════════════════════════════════════════════════════════════════

#html.footer(class: "mt-12 pt-6 border-t border-slate-200 dark:border-slate-700 text-center", role: "contentinfo")[
  #html.p(class: "text-sm " + tw.muted-text)[
    #datetime.today().year() #data.basics.name
  ]
]
