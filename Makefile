LATEXMK ?= latexmk
LATEXMK_FLAGS = -pdf -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -outdir=build

.PHONY: all slides handout
all: slides handout

slides:
	$(LATEXMK) $(LATEXMK_FLAGS) slides.tex

handout:
	$(LATEXMK) $(LATEXMK_FLAGS) handout.tex
