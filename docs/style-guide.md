# Palermo style guide

Palermo pairs the dark Metropolis title bar with a white slide body, Fira Sans
text, Palatino mathematics, and a blue progress line. See the
[example source](../slides.tex) for editable patterns and the
[README](../README.md) for installation and build commands.

## Scientific slides

- Give each slide one job. Introduce the physical setup, show the equation or
  diagram that describes it, then state the consequence.
- Use short, specific titles such as “Shot noise lifts the rank.” Put
  definitions and assumptions beside the equations that use them.
- Keep notation and colour roles consistent across equations, plots, and diagrams.
  For comparisons, align corresponding panels and use comparable axes.
- Use the slide body for the result and the footer for its sources. Label toy
  data as illustrative and distinguish proposed work from established results.
- Check the compiled PDF for readable labels, balanced columns, and space for
  citations. Split a crowded slide before shrinking it.

## Cover, navigation, and settings

Set `\title`, `\author`, `\institute`, and `\date` in the preamble, with
optional `\subtitle`. Call `\maketitleslide` and `\maketoc` between frames.
The cover uses the network background and the UniPa and QuNiPa marks by default.
`\maketoc` lists sections and frame titles. `\maketoc[short]` lists sections
alone. Use `\frametitle[Short title]{Full title}` to shorten an entry.
`\section{Title}` creates a divider, and a `standout` frame works for a short
transition or closing message.

Use `\slidesetup` after loading the package. Artwork paths are relative to
the project directory. Give an artwork key an empty value to hide it.
The author keys control citation highlighting independently of `\author`.

```tex
\slidesetup{
  title background=custom-background.pdf,
  university logo=my-logo.pdf,
  group logo={},
  highlight author family={Surname},
  highlight author given={Given name},
  highlight author initial={G}
}
```

The default highlighted name is Alessandro Romancino. Set all three author
keys to `{}` to disable highlighting.

## Layout and colour

Frame bodies and column content are centred by default. Columns use the text
width and align vertically at the centre. Use `\begin{columns}[T]` to align
their top edges, and `\raggedright` for a left-aligned block. Inside a column,
use `\linewidth` for figure widths.

| Command | Use |
| --- | --- |
| `\capt{text}` | Small grey supporting text |
| `\chip[fill]{text}`, `\schip[fill]{text}`, `\tchip[fill]{text}` | Progressively smaller labels with a default fill of `tlblue!45` |
| `\smallgap`, `\gap`, `\biggap` | Extra vertical space of 1, 3, or 6 mm |
| `\pub{colour}{title}{details}` | A manually formatted publication entry |
| `\mydot` | Centred text dot for metadata and headings |
| `\llm[Heading.]{Text.}` | Disclosure or acknowledgement footer. Leave room for it and use it on a frame without citations. |

Use `\begin{math}...\end{math}` for large equations in a column and
`\begin{equation*}...\end{equation*}` for displayed equations. Use an
`equation` environment and `\label` when a formula needs a reference.

| Palette | Typical use |
| --- | --- |
| `tdark`, `tgray` | Headers and body text, captions and footers |
| `tblue`, `tlblue` | Links, measurements, and primary accents |
| `tmag`, `tpink`, `tlpink` | Observables, readouts, and state or prior terms |
| `tyellow`, `tgreen`, `tred` | Inputs, baselines, and alerts |

Set `\slideprogressheight`, `\slidetitleseparatorheight`, and
`\slidecitationsep` with `\setlength` to adjust the bars and citation spacing.
The progress bar uses frame numbers, which stay fixed across overlays.

## Citations

The theme loads BibLaTeX with Biber. In the preamble, register your
[bibliography](../references.bib) with `\addbibresource{references.bib}`.
At the end of each scientific frame, add citations for its claims and figures.

```tex
\cite{2026romancinoa}
\cite*{2026romancino}
```

`\cite` includes the title and `\cite*` uses a shorter format. Each call
adds one footer paragraph. A comma-separated list groups several references
in that paragraph. Use `\cite[Sec.~3]{2026romancinoa}` for a postnote.

The publication links to its DOI or falls back to the bibliography URL.
arXiv identifiers link separately. The bibliography’s `eid` field takes
precedence over page numbers. Both citation forms abbreviate author lists
longer than three names. To expand them, set
`\ExecuteBibliographyOptions{maxcitenames=99}` in the preamble.

## Diagrams and figures

Use `control diagram` for a sequence of labelled boxes. The presets
`identification diagram` and `reservoir diagram` use variants of its spacing.
The `collaboration diagram` preset defines nodes and labels for a network.

```tex
\begin{tikzpicture}[control diagram]
  \node[box,fill=tlpink] (state) {$\rho$};
  \node[box,fill=tlblue,right=of state] (measurement) {$\{\mu_b\}$};
  \draw[arr] (state) -- (measurement);
\end{tikzpicture}
```

PGFPlots uses the `palermo cycle` by default. For imported figures, prefer vector
PDFs and use `\includegraphics[width=\linewidth]{device.pdf}` inside a
column. Preserve the axes, units, legends, and uncertainties needed to read
the figure.

## Handout

[handout.tex](../handout.tex) passes Beamer’s `handout` option and inputs
`slides.tex`. Ordinary overlays collapse into a static page. Add an explicit
handout overlay if a reveal needs its own page:

```tex
\only<3|handout:2>{...}
```

This shows the reveal on overlay 3 in the presentation and on page 2 of
that frame in the handout. Check both PDFs when using this pattern.
