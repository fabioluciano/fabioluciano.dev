include .env

## ┌───────────────────────────────────────────────────────────────────┐
## │                       Example Makefile                            │
## │ ───────────────────────────────────────────────────────────────── │
## │ Example commands: "make build" or "make install"                  │
## └───────────────────────────────────────────────────────────────────┘

help: ## show this help
	@sed -ne "s/^##\(.*\)/\1/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 2` Make Commands `tput sgr0`────────────────────────────────\n"
	@sed -ne "/@sed/!s/\(^[^#?=]*:\).*##\(.*\)/`tput setaf 2``tput bold`\1`tput sgr0`\2/p" $(MAKEFILE_LIST)

# make help the default
.DEFAULT_GOAL := help

.PHONY: all

all: execute_scripts generate_htmls generate_pdfs optimize_pdfs ## Execute all steps
generate_htmls: generate_ptbr_html generate_en_html ## Generate HTML files for hosting purposes
generate_pdfs: generate_ptbr_pdf generate_en_pdf generate_ptbr_condensed_pdf generate_en_consensed_pdf ## Generate PDF files for hosting purposes
optimize_pdfs: optimize_en_pdfs optimize_ptbr_pdfs

execute_scripts: ## Execute python code for generate informations
	@docker build -t python-with-poetry -f src/python/Dockerfile . && \
	docker run --rm -e "GITHUB_TOKEN=${GITHUB_TOKEN}" \
	-v `pwd`/src/python:/app \
	-v `pwd`/src/resources/data:/app/resources/data python-with-poetry

generate_ptbr_html: 
	docker run --rm --platform linux/amd64 -v `pwd`:/documents/ \
		asciidoctor/docker-asciidoctor asciidoctor \
		-o ./output/ptbr/index.html -a toc=left \
		-a docinfo=shared src/resume-ptbr.adoc

generate_ptbr_pdf:
	docker run --rm  --platform linux/amd64 -v `pwd`:/documents/ \
		asciidoctor/docker-asciidoctor asciidoctor-pdf -a allow-uri-read \
		-a pdf-theme=src/resources/themes/default-theme.yml \
		-a pdf-fontsdir=src/resources/fonts \
		-o ./output/resume-ptbr-raw.pdf src/resume-ptbr.adoc

generate_ptbr_condensed_pdf:
	docker run --rm  --platform linux/amd64 -v `pwd`:/documents/ \
		asciidoctor/docker-asciidoctor asciidoctor-pdf \
		-a with_activities=false -a allow-uri-read \
		-a pdf-theme=src/resources/themes/default-theme.yml \
		-a pdf-fontsdir=src/resources/fonts \
		-o ./output/resume-condensed-ptbr-raw.pdf src/resume-ptbr.adoc

generate_en_html: 
	docker run --rm  --platform linux/amd64 -v `pwd`:/documents/ \
		asciidoctor/docker-asciidoctor asciidoctor \
		-o ./output/en/index.html -a toc=left \
		-a docinfo=shared src/resume-en.adoc

generate_en_pdf:
	docker run --rm  --platform linux/amd64 -v `pwd`:/documents/ \
		asciidoctor/docker-asciidoctor asciidoctor-pdf \
		-a allow-uri-read -a pdf-theme=src/resources/themes/default-theme.yml \
		-a pdf-fontsdir=src/resources/fonts \
		-o ./output/resume-en-raw.pdf src/resume-en.adoc
	
generate_en_consensed_pdf:
	docker run --rm  --platform linux/amd64 -v `pwd`:/documents/ \
		asciidoctor/docker-asciidoctor asciidoctor-pdf \
		-a with_activities=false -a allow-uri-read \
		-a pdf-theme=src/resources/themes/default-theme.yml \
		-a pdf-fontsdir=src/resources/fonts \
		-o ./output/resume-condensed-en-raw.pdf src/resume-en.adoc

optimize_en_pdfs: output/resume-condensed-en-raw.pdf output/resume-en-raw.pdf
	docker run --rm  --platform linux/amd64 -v `pwd`:/app -w /app minidocks/ghostscript \
		-sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
		-dPrinted=false -dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=output/en/resume.pdf output/resume-en-raw.pdf && \
	docker run --rm  --platform linux/amd64 -v `pwd`:/app -w /app minidocks/ghostscript \
		-sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
		-dPrinted=false -dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=output/en/resume-condensed.pdf output/resume-condensed-en-raw.pdf

optimize_ptbr_pdfs: output/resume-condensed-ptbr-raw.pdf output/resume-ptbr.pdf
	docker run --rm  --platform linux/amd64 -v `pwd`:/app -w /app minidocks/ghostscript \
		-sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
		-dPrinted=false -dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=output/ptbr/resume.pdf output/resume-ptbr-raw.pdf && \
	docker run --rm  --platform linux/amd64 -v `pwd`:/app -w /app minidocks/ghostscript \
		-sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
		-dPrinted=false -dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=output/ptbr/resume-condensed.pdf output/resume-condensed-ptbr-raw.pdf
