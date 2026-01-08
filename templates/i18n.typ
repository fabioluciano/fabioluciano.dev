// Internationalization System
// Centralizes all translations for DRY compliance
// Usage: #import "i18n.typ": t, translations

#let translations = (
  en: (
    // Section titles
    summary: "Professional Summary",
    experience: "Professional Experience",
    education: "Education",
    certifications: "Certifications",
    skills: "Technical Skills",
    languages: "Languages",
    projects: "Open Source Projects",
    publications: "Talks & Publications",

    // Date formatting
    present: "Present",
    now: "Now",

    // Labels
    at: "at",
    contact: "Contact",
    social: "Social Networks",

    // K8s highlight
    k8s-title: "CNCF Kubernetes Certifications",
    kubestronaut: "KUBESTRONAUT",
  ),
  pt: (
    // Section titles
    summary: "Resumo Profissional",
    experience: "Experiência Profissional",
    education: "Formação Acadêmica",
    certifications: "Certificações",
    skills: "Habilidades Técnicas",
    languages: "Idiomas",
    projects: "Projetos Open Source",
    publications: "Palestras & Publicações",

    // Date formatting
    present: "Atual",
    now: "Atual",

    // Labels
    at: "em",
    contact: "Contato",
    social: "Redes Sociais",

    // K8s highlight
    k8s-title: "Certificações Kubernetes CNCF",
    kubestronaut: "KUBESTRONAUT",
  )
)

// Get translation by key and language
// Usage: #t("summary", lang)
#let t(key, lang) = {
  let lang-key = if lang == "pt" or lang == "ptbr" { "pt" } else { "en" }
  translations.at(lang-key).at(key, default: key)
}

// Get all translations for a language (for bulk access)
#let get-translations(lang) = {
  let lang-key = if lang == "pt" or lang == "ptbr" { "pt" } else { "en" }
  translations.at(lang-key)
}
