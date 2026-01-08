// Data loader utility for merging YAML files
// This function loads common.yaml and merges with language-specific YAML
// Open/Closed: Adding new languages only requires creating new YAML files

// Language code mapping for file naming conventions
#let lang-file-map = (
  en: "en",
  pt: "ptbr",
  ptbr: "ptbr",
)

// Deep merge function - recursively merges dictionaries
#let merge-dict(target, source) = {
  let result = target

  for (key, value) in source {
    if key in target and type(target.at(key)) == dictionary and type(value) == dictionary {
      result.insert(key, merge-dict(target.at(key), value))
    } else {
      result.insert(key, value)
    }
  }

  result
}

// Main data loader function
// Usage: #let data = load-resume-data("en")
#let load-resume-data(lang) = {
  // Load common data (shared across all languages)
  let common-data = yaml("../data/common.yaml")

  // Resolve language code to file name
  let lang-code = lang-file-map.at(lang, default: lang)
  let lang-file = "../data/resume." + lang-code + ".yaml"

  // Load language-specific data
  let lang-data = yaml(lang-file)

  // Return merged data (language-specific overrides common)
  merge-dict(common-data, lang-data)
}

// Get supported languages
#let supported-languages = lang-file-map.keys()
