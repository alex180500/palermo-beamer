# Palermo Beamer

A Beamer theme based on Alessandro Romancino’s Online QML slides.

[Example slides](docs/example-slides.pdf) · [Example handout](docs/example-handout.pdf) · [Style guide](docs/style-guide.md)

## Install with TinyTeX or TeX Live

Install any missing dependencies with `tlmgr`:

```sh
tlmgr install latexmk biber beamer beamertheme-metropolis biblatex \
  fira lm psnfss palatino mathpazo fpl pgf pgfplots
```

From the repository root, run these commands to install or update the theme:

```sh
texmf_home="$(kpsewhich -var-value=TEXMFHOME)"
package_dir="$texmf_home/tex/latex/palermo-slides"
mkdir -p "$package_dir"
cp -R template/palermo-slides.sty template/assets "$package_dir/"
mktexlsr "$texmf_home"
kpsewhich palermo-slides.sty
```

## Use in a deck

```tex
\documentclass[aspectratio=169,11pt]{beamer}
\usepackage{palermo-slides}
% \addbibresource{references.bib}
```

Set your cover metadata and call `\maketitleslide` after `\begin{document}`.
For a starter, copy [slides.tex](slides.tex), [handout.tex](handout.tex),
[references.bib](references.bib), and [.latexmkrc](.latexmkrc).

## Build the example

Run `latexmk` from the repository root to build both PDFs with the bundled theme.
LaTeX Workshop uses the **Palermo slides and handout** recipe when this repo is
opened as a VS Code folder. Build one PDF with `latexmk slides.tex` or
`latexmk handout.tex`.

Build files go into `.pdf/`. Successful builds refresh the previews in `docs/`.
