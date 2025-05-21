#let academic(contents) = {
  for study in contents {
    text[
      - *#study.course* - #study.level \
        #study.institution \
    ]
  }
}

#let certifications(contents) = {
  for certification in contents {
    text[
      - *#certification.name* - #certification.institute - #certification.period.start \~ #certification.period.end
    ]
  }
}

#let languages(contents) = {
  for language in contents {
    text[
      - *#language.name*
    ]
  }
}

#let professional_experiences(contents) = {
  for  experience in contents {
    text[
      - *#experience.title* - #experience.company  | #experience.period.start \~ #experience.period.end \
        #experience.summary
    ]
  }
}
