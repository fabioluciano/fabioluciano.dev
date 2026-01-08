// Design System - Colors, Typography, and Styling
// This file centralizes all design tokens for consistent styling across templates
// Components are in the components/ directory

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE - Kubestronaut Premium Theme
// ═══════════════════════════════════════════════════════════════════════════════

// Primary colors - Amber/Gold for premium feel
#let color-primary = rgb("#b45309")       // Amber 700 - main brand color (premium gold)
#let color-accent = rgb("#d97706")        // Amber 600 - links, highlights
#let color-k8s = rgb("#326ce5")           // Kubernetes blue - ONLY for K8s certifications

// Text colors - Clear hierarchy with warm slate
#let color-text = rgb("#1e293b")          // Slate 800 - body text
#let color-text-bold = rgb("#0f172a")     // Slate 900 - headings
#let color-muted = rgb("#64748b")         // Slate 500 - secondary text
#let color-subtle = rgb("#94a3b8")        // Slate 400 - tertiary/hints

// Background colors - Warm neutrals
#let color-bg-light = rgb("#f8f7f4")      // Warm off-white - light background
#let color-bg-card = rgb("#f5f4f1")       // Warm gray - card background
#let color-bg-column = rgb("#f8f7f4")     // Column background - onepage
#let color-bg-white = white
#let color-k8s-bg = rgb("#eff6ff")        // Blue 50 - K8s highlight (keep blue here)

// Header colors (onepage) - Premium dark
#let color-header-bg = rgb("#1e293b")     // Slate 800 - dark header background
#let color-header-text = rgb("#f8f7f4")   // Warm white - header text
#let color-header-accent = rgb("#fbbf24") // Amber 400 - header accent (gold)

// Border colors
#let color-divider = rgb("#e7e5e4")       // Stone 200 - light border
#let color-divider-strong = rgb("#d6d3d1") // Stone 300 - stronger border

// ═══════════════════════════════════════════════════════════════════════════════
// TYPOGRAPHY - Font Families
// ═══════════════════════════════════════════════════════════════════════════════

#let font-primary = ("Liberation Sans", "DejaVu Sans", "Noto Sans")
#let font-sans = ("Liberation Sans", "DejaVu Sans", "Noto Sans")
#let font-icons = ("Symbols Nerd Font",)

// Helper function to render Nerd Font icons
#let nf-icon(icon, size: 1em, color: none) = {
  let icon-color = if color != none { color } else { color-primary }
  text(font: font-icons, size: size, fill: icon-color)[#icon]
}

// ═══════════════════════════════════════════════════════════════════════════════
// TYPOGRAPHY - Font Sizes
// ═══════════════════════════════════════════════════════════════════════════════

// Full template sizes
#let size-name-full = 24pt
#let size-label-full = 12pt
#let size-section-full = 11pt
#let size-section-icon-full = 14pt
#let size-body-full = 10pt
#let size-job-title-full = 11pt
#let size-company-full = 10.5pt
#let size-date-full = 8.5pt
#let size-small-full = 9pt
#let size-highlight-full = 9.5pt

// Onepage template sizes (compact but readable)
#let size-name-onepage = 14pt
#let size-label-onepage = 8pt
#let size-section-onepage = 8pt
#let size-section-icon-onepage = 8pt
#let size-body-onepage = 7pt
#let size-job-title-onepage = 7pt
#let size-company-onepage = 5pt
#let size-date-onepage = 4.5pt
#let size-small-onepage = 5pt
#let size-highlight-onepage = 5pt

// ═══════════════════════════════════════════════════════════════════════════════
// SPACING
// ═══════════════════════════════════════════════════════════════════════════════

// Full template spacing
#let spacing-section-full = 1.5em
#let spacing-block-full = 1.2em
#let spacing-line-full = 0.8em

// Onepage template spacing (compact but readable)
#let spacing-section-onepage = 0.4em
#let spacing-section-below-onepage = 0.6em
#let spacing-block-onepage = 0.4em
#let spacing-line-onepage = 0.4em

// ═══════════════════════════════════════════════════════════════════════════════
// BORDERS & RADIUS
// ═══════════════════════════════════════════════════════════════════════════════

#let radius-small = 2pt
#let radius-medium = 3pt
#let radius-large = 4pt

#let stroke-thin = 0.3pt
#let stroke-normal = 0.5pt
#let stroke-medium = 1pt
#let stroke-thick = 1.5pt

// ═══════════════════════════════════════════════════════════════════════════════
// PAGE MARGINS
// ═══════════════════════════════════════════════════════════════════════════════

#let margin-full = (x: 2cm, y: 1cm)
#let margin-onepage = (x: 0.8cm, y: 0.6cm)

// ═══════════════════════════════════════════════════════════════════════════════
// INSETS & PADDINGS
// ═══════════════════════════════════════════════════════════════════════════════

#let inset-header-full = (x: 16pt, y: 8pt)
#let inset-header-onepage = (x: 10pt, y: 6pt)
#let inset-block-full = 12pt
#let inset-block-onepage = 4pt
#let inset-card = 10pt
#let inset-small = 8pt
#let inset-badge = (x: 8pt, y: 4pt)
#let inset-badge-small = (x: 4pt, y: 2pt)

// ═══════════════════════════════════════════════════════════════════════════════
// GRID GUTTERS
// ═══════════════════════════════════════════════════════════════════════════════

#let gutter-large = 1.2em
#let gutter-medium = 1em
#let gutter-small = 0.8em
#let gutter-xs = 0.6em
#let gutter-xxs = 0.5em
#let gutter-tiny = 4pt

// ═══════════════════════════════════════════════════════════════════════════════
// TRACKING (Letter spacing)
// ═══════════════════════════════════════════════════════════════════════════════

#let tracking-wide = 1pt
#let tracking-normal = 0.5pt
#let tracking-tight = 0.3pt

// ═══════════════════════════════════════════════════════════════════════════════
// ICONS - Nerd Font Unicode characters
// ═══════════════════════════════════════════════════════════════════════════════

#let icon-summary = "\u{f15c}"       // nf-fa-file_text
#let icon-experience = "\u{f0b1}"    // nf-fa-briefcase
#let icon-education = "\u{f19d}"     // nf-fa-graduation_cap
#let icon-certifications = "\u{f0a3}" // nf-fa-certificate
#let icon-skills = "\u{f121}"        // nf-fa-code
#let icon-languages = "\u{f1ab}"     // nf-fa-language
#let icon-projects = "\u{f07b}"      // nf-fa-folder_open
#let icon-speaking = "\u{f130}"      // nf-fa-microphone
#let icon-k8s = "󱃾"                  // nf-md-kubernetes
#let icon-email = "󰇮"                // nf-md-email
#let icon-phone = "\u{f095}"         // nf-fa-phone
#let icon-location = "\u{f041}"      // nf-fa-map_marker
#let icon-website = "󰖟"              // nf-md-web

// Social media icons
#let icon-github = "\u{f09b}"        // nf-fa-github
#let icon-linkedin = "\u{f0e1}"      // nf-fa-linkedin
#let icon-twitter = "\u{f099}"       // nf-fa-twitter
#let icon-telegram = "\u{f2c6}"      // nf-fa-telegram
#let icon-blog = "\u{f02d}"          // nf-fa-book

// Get social media icon by network name
#let get-social-icon(network) = {
  let network-lower = lower(network)
  if network-lower == "github" { icon-github }
  else if network-lower == "linkedin" { icon-linkedin }
  else if network-lower == "twitter" { icon-twitter }
  else if network-lower == "telegram" { icon-telegram }
  else if network-lower == "blog" { icon-blog }
  else { "" }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

// Format date range (full format)
#let format-date(start, end, lang: "en") = {
  let end-text = if end == "" or end == none {
    if lang == "en" { "Present" } else { "Atual" }
  } else { end }
  [#start — #end-text]
}

// Format date range (year only)
#let format-date-year(start, end, lang: "en") = {
  let start-year = if type(start) == str and start.len() >= 4 { start.slice(0, 4) } else { str(start) }
  let end-text = if end == "" or end == none {
    if lang == "en" { "Now" } else { "Atual" }
  } else {
    if type(end) == str and end.len() >= 4 { end.slice(0, 4) } else { str(end) }
  }
  [#start-year → #end-text]
}

// Date badge (full size)
#let date-badge(content, size: size-date-full) = {
  box(
    fill: color-bg-light,
    radius: radius-medium,
    inset: inset-badge,
  )[
    #text(size: size, weight: "medium", fill: color-muted)[#content]
  ]
}

// Date badge (small/onepage size)
#let date-badge-small(content, size: size-date-onepage) = {
  box(
    fill: color-bg-light,
    radius: radius-small,
    inset: inset-badge-small,
  )[
    #text(size: size, fill: color-muted)[#content]
  ]
}

// Summary block
#let summary-block(content) = {
  block(
    fill: color-bg-light,
    radius: radius-large,
    inset: inset-block-full,
    width: 100%,
  )[
    #text(size: size-body-full, fill: color-text)[#content]
  ]
}

// Contact box (full)
#let contact-box-full(content) = {
  box(
    fill: color-bg-light,
    radius: radius-large,
    inset: inset-header-full,
  )[
    #text(size: size-date-full, fill: color-muted)[#content]
  ]
}

// Profile photo (circular crop)
// For best results, use a square image cropped to show the face
#let profile-photo(path, size: 80pt) = {
  box(
    width: size,
    height: size,
    radius: 50%,
    clip: true,
    stroke: 2pt + color-primary,
  )[
    #image(path, width: size, height: size, fit: "cover")
  ]
}

// Profile photo small (for onepage) - zoomed into face
#let profile-photo-small(path, size: 45pt) = {
  box(
    width: size,
    height: size,
    radius: 50%,
    clip: true,
    stroke: 1.5pt + white,
    inset: 0pt,
  )[
    #align(center + top)[
      #image(path, width: size, fit: "cover")
    ]
  ]
}
