// Reusable Filters
// Centralizes filtering logic for DRY compliance
// Usage: #import "filters.typ": filter-k8s-certs, filter-other-certs

// Keywords that identify Kubernetes certifications
#let k8s-keywords = (
  "Kubernetes",
  "Kubestronaut",
  "CKS",
  "CKA",
  "CKAD",
  "KCSA",
  "KCNA"
)

// Check if a certificate is K8s-related
#let is-k8s-cert(cert) = {
  k8s-keywords.any(kw => cert.name.contains(kw))
}

// Filter only Kubernetes certifications
#let filter-k8s-certs(certificates) = {
  certificates.filter(is-k8s-cert)
}

// Filter non-Kubernetes certifications
#let filter-other-certs(certificates) = {
  certificates.filter(c => not is-k8s-cert(c))
}

// Format K8s cert names for display (removes verbose parts)
#let format-k8s-cert-name(name) = {
  name
    .replace("Certified ", "")
    .replace(" - Associate", "")
}

// Get formatted K8s cert names as joined string
#let get-k8s-certs-text(certificates, separator: " • ") = {
  filter-k8s-certs(certificates)
    .map(c => format-k8s-cert-name(c.name))
    .join(separator)
}
