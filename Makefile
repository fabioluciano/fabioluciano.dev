include .env

.PHONY: all

all: generate_github_informations generate_pdf

generate_github_informations:
	@( \
		source .venv/bin/activate; \
		pip install -r src/python/requirements.txt; \
		GITHUB_TOKEN=${GITHUB_TOKEN} python src/python/main.py \
  )

generate_pdf:
	docker run -it  --platform linux/amd64 -v `pwd`:/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf -a allow-uri-read -a pdf-theme=src/resources/themes/default-theme.yml -a pdf-fontsdir=src/resources/fonts -o ./output/resume-raw.pdf src/resume-ptbr.adoc