## ┌───────────────────────────────────────────────────────────────────┐
## │                   Resume Builder with Typst                       │
## │ ───────────────────────────────────────────────────────────────── │
## │ Commands: make build, make pdf, make html, make clean             │
## └───────────────────────────────────────────────────────────────────┘

.PHONY: help all build pdf html clean install-typst watch dev

# Default target
.DEFAULT_GOAL := help

# Variables
TYPST := typst
OUTPUT_DIR := output
DATA_DIR := data
TEMPLATES_DIR := templates
VALIDATOR := scripts/validate_resume.py

# Colors for terminal output
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

help: ## Show this help
	@echo "┌───────────────────────────────────────────────────────────────────┐"
	@echo "│                   Resume Builder - Commands                       │"
	@echo "└───────────────────────────────────────────────────────────────────┘"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

# ─────────────────────────────────────────────────────────────────────
# Build targets
# ─────────────────────────────────────────────────────────────────────

all: validate build ## Validate and build everything (PDFs and HTMLs)

build: setup pdf html ## Build all outputs
	@echo "$(GREEN)✓ All builds completed$(NC)"

setup: ## Create output directories
	@mkdir -p $(OUTPUT_DIR)/en $(OUTPUT_DIR)/ptbr

# ─────────────────────────────────────────────────────────────────────
# PDF Generation (2 versions: full, onepage)
# Uses --input to pass language and data file to single template
# ─────────────────────────────────────────────────────────────────────

pdf: pdf-en pdf-ptbr ## Generate all PDFs

pdf-en: setup pdf-en-full pdf-en-onepage ## Generate English PDFs

pdf-en-full: setup ## Generate English full resume PDF
	@echo "$(YELLOW)Building English full resume PDF...$(NC)"
	$(TYPST) compile --root . --input lang=en $(TEMPLATES_DIR)/resume-full.typ $(OUTPUT_DIR)/en/resume.pdf
	@echo "$(GREEN)✓ Created $(OUTPUT_DIR)/en/resume.pdf$(NC)"

pdf-en-onepage: setup ## Generate English one-page resume PDF (landscape, columns)
	@echo "$(YELLOW)Building English one-page resume PDF...$(NC)"
	$(TYPST) compile --root . --input lang=en $(TEMPLATES_DIR)/resume-onepage.typ $(OUTPUT_DIR)/en/resume-onepage.pdf
	@echo "$(GREEN)✓ Created $(OUTPUT_DIR)/en/resume-onepage.pdf$(NC)"

pdf-ptbr: setup pdf-ptbr-full pdf-ptbr-onepage ## Generate Portuguese PDFs

pdf-ptbr-full: setup ## Generate Portuguese full resume PDF
	@echo "$(YELLOW)Building Portuguese full resume PDF...$(NC)"
	$(TYPST) compile --root . --input lang=pt $(TEMPLATES_DIR)/resume-full.typ $(OUTPUT_DIR)/ptbr/resume.pdf
	@echo "$(GREEN)✓ Created $(OUTPUT_DIR)/ptbr/resume.pdf$(NC)"

pdf-ptbr-onepage: setup ## Generate Portuguese one-page resume PDF (landscape, columns)
	@echo "$(YELLOW)Building Portuguese one-page resume PDF...$(NC)"
	$(TYPST) compile --root . --input lang=pt $(TEMPLATES_DIR)/resume-onepage.typ $(OUTPUT_DIR)/ptbr/resume-onepage.pdf
	@echo "$(GREEN)✓ Created $(OUTPUT_DIR)/ptbr/resume-onepage.pdf$(NC)"

# ─────────────────────────────────────────────────────────────────────
# HTML Generation (using Typst typed HTML + Tailwind CSS)
# Uses resume-html.typ template with Tailwind classes
# ─────────────────────────────────────────────────────────────────────

CSS_FILE := $(TEMPLATES_DIR)/styles-html.css

# Tailwind CDN script to inject
TAILWIND_SCRIPT := <script src=\"https://cdn.tailwindcss.com\"></script><script>tailwind.config={darkMode:\"class\"}</script>

# Nerd Font via @font-face (jsDelivr CDN)
NERDFONT_CDN := <style>@font-face{font-family:\"Symbols Nerd Font\";src:url(\"https://cdn.jsdelivr.net/gh/ryanoasis/nerd-fonts@v3.3.0/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf\") format(\"truetype\");font-weight:normal;font-style:normal;font-display:swap;}.nf{font-family:\"Symbols Nerd Font\",monospace;}</style>

# Theme toggle JavaScript
THEME_SCRIPT := <script>function toggleTheme(){document.documentElement.classList.toggle(\"dark\");localStorage.setItem(\"theme\",document.documentElement.classList.contains(\"dark\")?\"dark\":\"light\")}(function(){const t=localStorage.getItem(\"theme\")||(window.matchMedia(\"(prefers-color-scheme:dark)\").matches?\"dark\":\"light\");if(t===\"dark\")document.documentElement.classList.add(\"dark\")})()</script>

# SEO Meta tags (injected during HTML post-processing)
SEO_META_EN := <meta name=\"description\" content=\"Platform Engineer with 10+ years of experience. CNCF Kubestronaut. Specialized in IDP, DevEx, and Cloud Native technologies.\"><meta name=\"keywords\" content=\"Platform Engineer, Kubernetes, DevOps, Cloud Native, CNCF, Kubestronaut, IDP, DevEx\"><meta name=\"author\" content=\"Fabio Luciano\"><meta property=\"og:type\" content=\"profile\"><meta property=\"og:title\" content=\"Fabio Luciano - Platform Engineer\"><meta property=\"og:description\" content=\"Platform Engineer | CNCF Kubestronaut | DevEx Specialist\"><meta name=\"twitter:card\" content=\"summary\">
SEO_META_PTBR := <meta name=\"description\" content=\"Platform Engineer com mais de 10 anos de experiência. CNCF Kubestronaut. Especializado em IDP, DevEx e tecnologias Cloud Native.\"><meta name=\"keywords\" content=\"Platform Engineer, Kubernetes, DevOps, Cloud Native, CNCF, Kubestronaut, IDP, DevEx\"><meta name=\"author\" content=\"Fabio Luciano\"><meta property=\"og:type\" content=\"profile\"><meta property=\"og:title\" content=\"Fabio Luciano - Platform Engineer\"><meta property=\"og:description\" content=\"Platform Engineer | CNCF Kubestronaut | DevEx Specialist\"><meta name=\"twitter:card\" content=\"summary\">

html: html-en html-ptbr ## Generate all HTML files

html-en: setup ## Generate English HTML resume
	@echo "$(YELLOW)Building English HTML resume (Tailwind)...$(NC)"
	$(TYPST) compile --root . --input lang=en --features html --format html $(TEMPLATES_DIR)/resume-html.typ $(OUTPUT_DIR)/en/index.html
	@python3 -c "import sys; css=open('$(CSS_FILE)').read(); html=open('$(OUTPUT_DIR)/en/index.html').read(); html=html.replace('</head>', '$(SEO_META_EN)$(NERDFONT_CDN)$(TAILWIND_SCRIPT)$(THEME_SCRIPT)<style>'+css+'</style></head>'); html=html.replace('<body>', '<body class=\"max-w-4xl mx-auto p-8 bg-white dark:bg-slate-900 text-slate-900 dark:text-slate-100 font-sans antialiased transition-colors duration-300\">'); open('$(OUTPUT_DIR)/en/index.html','w').write(html)"
	@echo "$(GREEN)✓ Created $(OUTPUT_DIR)/en/index.html$(NC)"

html-ptbr: setup ## Generate Portuguese HTML resume
	@echo "$(YELLOW)Building Portuguese HTML resume (Tailwind)...$(NC)"
	$(TYPST) compile --root . --input lang=pt --features html --format html $(TEMPLATES_DIR)/resume-html.typ $(OUTPUT_DIR)/ptbr/index.html
	@python3 -c "import sys; css=open('$(CSS_FILE)').read(); html=open('$(OUTPUT_DIR)/ptbr/index.html').read(); html=html.replace('</head>', '$(SEO_META_PTBR)$(NERDFONT_CDN)$(TAILWIND_SCRIPT)$(THEME_SCRIPT)<style>'+css+'</style></head>'); html=html.replace('<body>', '<body class=\"max-w-4xl mx-auto p-8 bg-white dark:bg-slate-900 text-slate-900 dark:text-slate-100 font-sans antialiased transition-colors duration-300\">'); open('$(OUTPUT_DIR)/ptbr/index.html','w').write(html)"
	@echo "$(GREEN)✓ Created $(OUTPUT_DIR)/ptbr/index.html$(NC)"

# ─────────────────────────────────────────────────────────────────────
# Development & Utility
# ─────────────────────────────────────────────────────────────────────

watch: ## Watch for changes and rebuild (English full)
	$(TYPST) watch --root . $(TEMPLATES_DIR)/resume-full.typ $(OUTPUT_DIR)/en/resume.pdf

watch-ptbr: ## Watch for changes and rebuild (Portuguese full)
	$(TYPST) watch --root . $(TEMPLATES_DIR)/resume-full-ptbr.typ $(OUTPUT_DIR)/ptbr/resume.pdf

dev: ## Start development mode with live reload
	@echo "$(YELLOW)Starting development mode...$(NC)"
	@echo "Open another terminal to view changes"
	$(TYPST) watch --root . $(TEMPLATES_DIR)/resume-full.typ $(OUTPUT_DIR)/en/resume.pdf

# ─────────────────────────────────────────────────────────────────────
# Validation targets
# ─────────────────────────────────────────────────────────────────────

validate: ## Validate all resume YAML files against JSON Resume schema
	@echo "$(YELLOW)Validating resume files against JSON Resume schema...$(NC)"
	python3 $(VALIDATOR) --all

validate-en: ## Validate English resume YAML file
	@echo "$(YELLOW)Validating English resume...$(NC)"
	python3 $(VALIDATOR) $(DATA_DIR)/resume.en.yaml

validate-ptbr: ## Validate Portuguese resume YAML file
	@echo "$(YELLOW)Validating Portuguese resume...$(NC)"
	python3 $(VALIDATOR) $(DATA_DIR)/resume.ptbr.yaml

install-validator-deps: ## Install dependencies for resume validation
	@echo "$(YELLOW)Installing validation dependencies...$(NC)"
	pip3 install jsonschema PyYAML
	@echo "$(GREEN)✓ Validation dependencies installed$(NC)"

# ─────────────────────────────────────────────────────────────────────
# Utilities
# ─────────────────────────────────────────────────────────────────────

clean: ## Remove all generated files
	@echo "$(YELLOW)Cleaning output directory...$(NC)"
	rm -rf $(OUTPUT_DIR)/*
	@echo "$(GREEN)✓ Cleaned$(NC)"

install-typst: ## Install Typst (macOS)
	@echo "$(YELLOW)Installing Typst...$(NC)"
	brew install typst
	@echo "$(GREEN)✓ Typst installed$(NC)"

# ─────────────────────────────────────────────────────────────────────
# Copy YAML files to output for web access
# ─────────────────────────────────────────────────────────────────────

copy-data: setup ## Copy YAML resume files and photo to output directory
	cp $(DATA_DIR)/common.yaml $(OUTPUT_DIR)/common.yaml
	cp $(DATA_DIR)/resume.en.yaml $(OUTPUT_DIR)/en/resume.yaml
	cp $(DATA_DIR)/resume.ptbr.yaml $(OUTPUT_DIR)/ptbr/resume.yaml
	@if [ -f $(DATA_DIR)/photo.jpg ]; then cp $(DATA_DIR)/photo.jpg $(OUTPUT_DIR)/photo.jpg; fi
	@echo "$(GREEN)✓ Data files copied to output$(NC)"

# ─────────────────────────────────────────────────────────────────────
# Release target
# ─────────────────────────────────────────────────────────────────────

release: clean build copy-data ## Build everything for release
	@echo "$(GREEN)✓ Release build completed$(NC)"
	@echo ""
	@echo "Output files:"
	@find $(OUTPUT_DIR) -type f | sort
