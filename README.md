# Palermo Beamer

A reusable Beamer theme based on Alessandro Romancino’s Online QML seminar
slides. It keeps the original network cover, UniPa and QuNiPa logos, Fira Sans
text, Palatino math, dark title bars, and blue progress line. Scientific
slides pair an equation or diagram with a brief interpretation and a linked
citation footer.

[Example presentation](docs/example-slides.pdf) ·
[Example handout](docs/example-handout.pdf) ·
[Theme reference and style guide](docs/style-guide.md)

## Install once with TinyTeX or TeX Live

From the repository root, run:

```sh
./install-texmf
kpsewhich palermo-slides.sty
```

The installer copies the package and cover artwork into the active TeX
distribution's personal tree, `TEXMFHOME/tex/latex/palermo-slides`. It uses
the `kpsewhich` on your `PATH` to locate the tree. Rerun it from a newer
checkout to update the installed package.

TinyTeX uses `tlmgr` for the dependencies. On a minimal setup, install these
if they are missing:

```sh
tlmgr install latexmk biber beamer beamertheme-metropolis biblatex \
  fira lm psnfss palatino mathpazo fpl pgf pgfplots
```

## Use the package in a talk

Load the package after the Beamer class:

```tex
\documentclass[aspectratio=169,11pt]{beamer}
\usepackage{palermo-slides}
% \addbibresource{references.bib}
```

The package loads the Metropolis layout components and configures BibLaTeX.
If the deck already loads a theme or BibLaTeX, integrate those settings with
this package call. Set the standard Beamer title metadata and use
`\maketitleslide` for the cover. To change or omit an asset, use
`\slidesetup{group logo={}, university logo=figures/my-logo.pdf}`.
Paths for custom artwork are relative to the deck.

To share a self-contained deck, copy `template/` beside its main `.tex` file
and use `\usepackage{template/palermo-slides}`. Keep the full `assets/`
directory with the style file.

## Build the example

From the repository root, compile either file with `latexmk`, or give it both
filenames to build the presentation and handout together:

```sh
latexmk -pdf -synctex=1 -interaction=nonstopmode -halt-on-error -outdir=build slides.tex handout.tex
```

The files are `build/slides.pdf` and `build/handout.pdf`. Latexmk runs Biber and
the extra LaTeX passes for references and contents. The example was built with
TinyTeX (TeX Live 2026), latexmk 4.88, and Biber 2.22.

## Start a new talk

After installing the theme, run:

```sh
palermo_repo="$HOME/Palermo/palermo-beamer"
"$palermo_repo/new-deck" "$PWD/my-talk"
cd my-talk
latexmk -pdf -synctex=1 -interaction=nonstopmode -halt-on-error -outdir=build slides.tex handout.tex
```

Edit `slides.tex` for the talk and `references.bib` for citations. Add artwork
to `figures/`. The starter uses the installed theme, so future talks only need
the small set of source files. To reproduce a particular package revision,
install from that Git commit or keep the theme with the deck as shown above.

## Slide patterns

| Pattern | How to use it |
| --- | --- |
| Cover and navigation | Call `\maketitleslide` and `\maketoc[short]`. Use `\maketoc` for linked slide titles as well as sections. |
| Diagram and equation | Use Beamer `columns` with a TikZ diagram on one side and the defining equation on the other. Columns center by default. Use `[T]` to align their tops. |
| Supporting text | Use `\capt{...}` for interpretation, `\schip{...}` for a short condition or takeaway, and `\gap` or `\biggap` between groups. |
| Research figures | Use `\includegraphics[width=\linewidth]{...}` inside a column. The image placeholder in the example has a ready-to-use `\includegraphics` line beside it. Its editable TikZ and PGFPlots examples are in `slides.tex`. |
| Citations | Call `\cite{key}` inside the relevant frame. Use `\cite*{key}` for a compact footer. DOI and arXiv links are clickable. |
| Closing | Use a `standout` frame for questions or a short closing message. |

The example uses two papers by Alessandro Romancino. Its plot shows illustrative
distributions, with the coordinates next to the plot in [slides.tex](slides.tex).
The bibliography records and citation keys are in [references.bib](references.bib).

- [Entanglement percolation in random quantum networks](https://doi.org/10.1088/2058-9565/ae5fca)
- [Random entanglement percolation on realistic quantum networks](https://doi.org/10.1393/ncc/i2026-26176-2)

## Handout

The two-line [handout.tex](handout.tex) wrapper passes the `handout` option to
Beamer and inputs `slides.tex`. Both editions share the same slide source.
Ordinary overlays collapse into a static page. When a reveal needs its own
handout page, give it an explicit handout number:

```tex
\only<3|handout:2>{...}
```

In the example, this prints the threshold frame with all its ordinary content,
followed by the same frame with the takeaway revealed. The reveal appears on
overlay 3 in the presentation.
