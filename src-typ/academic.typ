#import "lib.typ" as lib

#align(center)[
  == Formação e certificações
]

=== Formação Acadêmica
#lib.academic(
  yaml("data/academic.yaml")
)

=== Certificações
#lib.certifications(
  yaml("data/certifications.yaml")
)


=== Idiomas
#lib.languages(
  yaml("data/languages.yaml")
)
