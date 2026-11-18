# Palermo Beamer

A reusable Beamer theme based on Alessandro Romancino’s Online QML seminar
slides. It keeps the original network cover, UniPa and QuNiPa logos, Fira Sans
text, Palatino math, dark title bars, and blue progress line. Scientific
slides pair an equation or diagram with a brief interpretation and a linked
citation footer.

[Example presentation](docs/example-slides.pdf) ·
[Example handout](docs/example-handout.pdf) ·
[Theme reference and style guide](docs/style-guide.md)

## Build the example

Use pdfLaTeX, latexmk, Biber, and Make. A full TeX Live or MacTeX installation
includes the TeX dependencies. With a minimal installation, you will also need
Beamer, Metropolis, Fira Sans, Latin Modern, Palatino math, TikZ/PGF, PGFPlots
1.18 or later, and BibLaTeX with a compatible Biber version.

From the repository root, run:

```sh
make          # both PDFs
make slides   # build/slides.pdf
make handout  # build/handout.pdf
```

You can also run the builds directly:

```sh
latexmk -pdf -synctex=1 -interaction=nonstopmode -halt-on-error -outdir=build slides.tex
latexmk -pdf -synctex=1 -interaction=nonstopmode -halt-on-error -outdir=build handout.tex
```

Latexmk runs Biber and the subsequent LaTeX passes for references, contents, and
frame counts. Git ignores `build/`. The example was built with TeX Live
2026, latexmk 4.88, and Biber 2.22.

## Start a new talk

```sh
palermo_repo="$HOME/Palermo/palermo-beamer"
"$palermo_repo/new-deck" "$PWD/my-talk"
cd my-talk
make
```

Edit `slides.tex` for the talk, `references.bib` for citations, and `data.tex`
for shared plot data. Add artwork to `figures/`. The command copies those
starter files, the Makefile, and the full theme into a new directory. Keep the
copied `template/` under version control with the talk so it builds from the
same assets and style on another machine. To reproduce a particular theme
revision, check out that commit or tag in the theme repository before running
`new-deck`. Once hosted, a clone of the repository works the same way.

## Add the theme to an existing deck

From the root of the deck, copy the package and its artwork together. The
example below uses `palermo-theme/` as the local folder name.

```sh
palermo_repo="$HOME/Palermo/palermo-beamer"
test ! -e palermo-theme && cp -R "$palermo_repo/template" palermo-theme
```

Load the package after the Beamer class:

```tex
\documentclass[aspectratio=169,11pt]{beamer}
\usepackage{palermo-theme/palermo-slides}
% \addbibresource{references.bib}
```

The package loads the Metropolis layout components and configures BibLaTeX.
If the deck already loads a theme or BibLaTeX, integrate those settings with
this package call. Set the standard Beamer title metadata and use
`\maketitleslide` for the cover. To change or omit an asset, use
`\slidesetup{group logo={}, university logo=figures/my-logo.pdf}`.
Paths for custom artwork are relative to the project root. The package finds
its bundled artwork alongside the style file.

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
distributions, with the values kept in [data.tex](data.tex). The bibliography
records and citation keys are in [references.bib](references.bib).

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
