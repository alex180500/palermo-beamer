# Palermo Beamer

A reusable Beamer theme based on Alessandro Romancino’s Online QML seminar
slides. It keeps the original network cover, UniPa and QuNiPa logos, Fira Sans
text, Palatino math, dark title bars, and blue progress line. Scientific
slides pair an equation or diagram with a brief interpretation and a linked
citation footer.

[Example presentation](docs/example-slides.pdf) ·
[Example handout](docs/example-handout.pdf) ·
[Theme reference](#theme-defaults-and-configuration) ·
[Scientific slide style](#scientific-writing-and-slide-design)

## Install once with TinyTeX or TeX Live

From the repository root, copy the package and cover artwork into the active
TeX distribution’s personal tree:

```sh
texmf_home="$(kpsewhich -var-value=TEXMFHOME)"
package_dir="$texmf_home/tex/latex/palermo-slides"
mkdir -p "$package_dir"
cp -R template/palermo-slides.sty template/assets "$package_dir/"
mktexlsr "$texmf_home"
kpsewhich palermo-slides.sty
```

Run the same commands after changing the theme or pulling a newer revision.

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
`\slidesetup{group logo={}, university logo=my-logo.pdf}`.
Paths for custom artwork are relative to the deck.

To share a self-contained deck, copy `template/` beside its main `.tex` file
and use `\usepackage{template/palermo-slides}`. Keep the full `assets/`
directory with the style file.

## Build the example

The example loads the theme bundled with the repository. From the repository
root, compile either file with `latexmk`, or give it both
filenames to build the presentation and handout together:

```sh
latexmk -pdf -synctex=1 -interaction=nonstopmode -halt-on-error slides.tex handout.tex
```

The `.latexmkrc` puts both PDFs and their auxiliary files in `.pdf/`.
Each successful PDF build also refreshes the corresponding preview in `docs/`.
Latexmk runs Biber and the extra LaTeX passes for references and contents.
The example was built with TinyTeX (TeX Live 2026), latexmk 4.88, and Biber 2.22.

## Start a new talk

After installing the theme, run:

```sh
palermo_repo="$HOME/Palermo/palermo-beamer"
"$palermo_repo/new-deck" "$PWD/my-talk"
cd my-talk
latexmk -pdf -synctex=1 -interaction=nonstopmode -halt-on-error slides.tex handout.tex
```

Edit `slides.tex` for the talk and `references.bib` for citations. Add artwork
alongside the deck or use project-relative paths. The starter uses the
installed theme. To reproduce a particular version, install it from that Git
commit or keep a copy of the theme with the deck.

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

## Theme defaults and configuration

### Cover and author highlighting

Call `\slidesetup{...}` after loading the package to override selected keys.
Repeated calls update only the keys supplied.

| Key | Default | Purpose |
| --- | --- | --- |
| `title background` | Theme's `assets/palermo-slides-background-networks.pdf` | Cover background |
| `university logo` | Theme's `assets/palermo-slides-unipa.pdf` | First cover logo |
| `group logo` | Theme's `assets/palermo-slides-qunipa.pdf` | Second cover logo |
| `highlight author family` | `Romancino` | Family name to bold in citations |
| `highlight author given` | `Alessandro` | Full given name to match |
| `highlight author initial` | `A` | Initial to match, also accepting `A.` |

Custom artwork paths are relative to the project directory. An empty artwork value hides that asset:

```tex
\slidesetup{
  title background=custom-background.pdf,
  group logo={}
}
```

The background preserves its proportions and fills the cover with a centred
crop, at full opacity. Both logos preserve their proportions and sit at the
bottom right. These assets are applied by `\maketitleslide` only. Use that helper
to obtain the complete cover layout; a bare `\titlepage` does not add its artwork.

Set all three highlighting keys for another author, or empty all three to disable
name highlighting. This controls bibliography names independently of `\author`:

```tex
\slidesetup{
  highlight author family={},
  highlight author given={},
  highlight author initial={}
}
```

### Typography, colour and navigation

The theme supplies a white body background, dark title bars, centred body text,
filled Beamer blocks, blue links and a fractional frame counter. Title and author
text use `\LARGE`; frame and section titles use `\large` and `\Large`, respectively.
The institute is italic. Standard Beamer commands such as `\setbeamerfont` and
`\setbeamercolor` remain available for deliberate local changes.

| Colour | Hex | Typical use in the reference deck |
| --- | --- | --- |
| `tblue` | `0072B2` | Online Training, measurements, links and primary accents |
| `tlblue` | `91BADE` | Light measurement boxes and chips |
| `tpink` | `CC79A7` | State-prior terms and secondary distinctions |
| `tlpink` | `EBBCD7` | Quantum states, reservoirs and highlighted conditions |
| `tmag` | `AA3377` | Trained readouts, observables and POVM-prior terms |
| `tred` | `AA3939` | Red accent for alerts or annotations |
| `tyellow` | `FFE099` | Inputs, probes and selected assumptions |
| `tgreen` | `228833` | Pseudoinverse baseline in method comparisons |
| `tdark` | `23373B` | Main text, headers and standout backgrounds |
| `tgray` | `6B6B6B` | Supporting captions, labels and citation text |

These scientific associations are conventions, not enforced mappings. Define a
consistent meaning for colours within a talk, especially when importing plots.
Standard xcolor mixtures work, for example `tlblue!45` or `tmag!20`.

A progress bar runs along the bottom of content slides, section dividers and
standout slides. `\maketitleslide` suppresses it for the cover. Its fraction uses
Beamer's frame counters, so it need not equal the physical PDF page fraction.
The cover is a `plain` frame, not explicitly a `noframenumbering` frame.

### Adjustable lengths

| Length | Default | Effect |
| --- | --- | --- |
| `\slideparagraphskip` | `1mm` | Shared paragraph spacing, including columns |
| `\slidecitationsep` | `2pt` | Vertical separation between separate citation calls |
| `\slideprogressheight` | `1.2pt` | Bottom progress-bar thickness |
| `\slidetitleseparatorheight` | `2pt` | Cover separator thickness |

The last three can be changed directly after loading the theme:

```tex
\setlength{\slidecitationsep}{3pt}
\setlength{\slideprogressheight}{1.5pt}
\setlength{\slidetitleseparatorheight}{2pt}
```

Paragraph spacing is also copied into TeX and Metropolis lengths when the theme
loads. To override it consistently in a deck preamble, update all three:

```tex
\setlength{\slideparagraphskip}{1.5mm}
\setlength{\parskip}{\slideparagraphskip}
\makeatletter
\setlength{\metropolis@parskip}{\slideparagraphskip}
\makeatother
```

## Command reference

The following are the theme's public helpers. Commands whose names begin with
`\palermo@` implement the theme internally and should not appear in slide content.

### Frames, cover and contents

| Command or environment | Behaviour |
| --- | --- |
| `\slidesetup{key=value,...}` | Overrides the configuration keys listed above |
| `\maketitleslide` | Creates a complete cover frame using standard metadata and bundled artwork |
| `\maketoc` | Creates a left-aligned frame titled “Contents” with `\tableofcontents` |
| `\maketoc[short]` | Creates the same contents frame showing only section headings |
| `\section{Title}` | Uses Metropolis's section-divider behaviour and supplies a contents heading |
| `\begin{frame}{Title} ... \end{frame}` | Standard scientific content frame |
| `\begin{frame}[standout] ... \end{frame}` | Dark frame for a short transition or closing message |
| `\mydot` | Centred text dot, safe in metadata and headings |

Call `\maketitleslide` and `\maketoc` **between frames**, because each creates a
frame. Set `\title`, optional `\subtitle`, `\author`, `\institute` and `\date` in
the preamble.

The contents include section headings and titled content frames, with frame
titles rendered as indented entries. Frames before the first section and
untitled frames are omitted from those frame entries. Each frame is registered
once even when it has overlays. To shorten a contents entry, use
`\frametitle[Short title]{Full title}` inside the frame. This automatic listing
reuses Beamer's subsection-entry rendering; ordinary section headings and frame
titles are sufficient for the reference deck's structure.

Use `\maketoc[short]` for a compact overview that shows only sections. It hides
the indented slide-title entries, as well as any actual subsection and
subsubsection entries. The default `\maketoc` keeps the full listing.

```tex
\maketoc[short] % Sections only; call between frames
```

Use `\tableofcontents` directly inside your own frame when you need filtering,
such as `[currentsection]`, or a custom contents layout. Check long contents
lists visually and split or filter them when they no longer fit.

### Alignment and spacing

`columns` defaults to `[c,onlytextwidth]`: columns align vertically at their
centres and occupy the text width. Use `[T]` for aligned top edges. Horizontal
centering is automatic in frame bodies and columns; use `\raggedright` or
`\raggedleft` locally when appropriate.

```tex
\begin{columns}[T]
  \column{0.46\textwidth}
    Left-hand method.
  \column{0.46\textwidth}
    Right-hand method.
\end{columns}
```

Leave room between columns. Inside a column, size figures with `\linewidth`.
Blank lines or `\par` separate content paragraphs and use the theme's shared
paragraph gap. `\\` only breaks a line within a paragraph.

| Helper | Definition | Use |
| --- | --- | --- |
| `\smallgap` | `\vspace{1mm}` | Small additional separation |
| `\gap` | `\vspace{3mm}` | Separate closely related content blocks |
| `\biggap` | `\vspace{6mm}` | Mark a larger conceptual break |

All three helpers exist and are used in the reference deck. Put them between
content blocks, normally after a blank line. They add vertical space; they do
not replace paragraph breaks or automatically prevent overflow. The reference
deck sometimes doubles `\biggap` for a deliberate large separation.

### Captions, chips and publication entries

| Helper | Appearance and behaviour |
| --- | --- |
| `\capt{text}` | Small grey supporting text; ends its paragraph and preserves surrounding alignment |
| `\chip[fill]{text}` | Rounded label with `\small` text |
| `\schip[fill]{text}` | Rounded label with `\footnotesize` text |
| `\tchip[fill]{text}` | Rounded label with `\scriptsize` text |
| `\pub{colour}{title}{details}` | Coloured square, bold `\footnotesize` title and grey `\scriptsize` details, left-aligned in the current line width |

All chips default to `tlblue!45`. Their text is a compact single node; keep it
short rather than expecting automatic paragraph wrapping.

```tex
\chip{1 \mydot learn the measurement}

\gap
\schip[tlpink]{finite shots}
\schip{one linear regression}

\smallgap
\capt{The assumption that makes this relation possible.}
```

Use `\tchip` for annotations such as matrix dimensions beside an algorithm.
Use `\pub` for an explicit publication list if needed:

```tex
\pub{tblue}{Publication title}{Authors, venue and year}
```

`\pub` is a manual layout helper; it neither looks up bibliography keys nor adds
a citation footer. It is available in the theme but is not used by the current
reference deck. `\capt` is also a layout helper, not a numbered figure caption.

### Disclosure or acknowledgement footer

```tex
\llm{Describe the assistance actually used.}
\llm[Acknowledgements.]{Acknowledgement text.}
\llm[]{Footer text without a heading.}
```

These are alternative calls. The optional heading defaults to **Use of AI/LLM
Tools.** The footer uses `\footnotesize`, is left-aligned near the bottom, and
captures the current text colour, including white on a standout slide. Use one
call per frame: a later call replaces the earlier notice. The notice resets for
each frame and does not reserve body space automatically. Leave room for it and
place it on a frame without citation footers to avoid overlap. The reference
deck uses it on the final thank-you slide.

## Equations and scientific notation

Use native LaTeX math environments so editor completion, highlighting and
previews keep working.

| Syntax | Theme behaviour | Suitable use |
| --- | --- | --- |
| `\begin{math} ... \end{math}` | `\Large`, display-style mathematics in inline layout | Standalone compact formula, column formula, formula beside an annotation |
| `\begin{equation*} ... \end{equation*}` | `\Large`, unnumbered display with surrounding display skips set to zero | Centred display equation |
| `\begin{equation} ... \end{equation}` | Same display formatting, with equation numbering | Equations referenced elsewhere with `\label` and `\eqref` |
| `$...$` or `\(...\)` | Display style, with the surrounding text size | Math in labels, chips, captions and body text |

The reference deck predominantly uses `math`, with paragraph breaks and spacing
helpers to position formulas. Inline fractions and sums also use display style,
which can make labels taller. Inspect their fit. Other AMS environments remain
available, but the automatic `\Large`/zero-skip hooks apply specifically to
`equation` and `equation*`, not to every possible display environment.

For several related equations, nest `aligned` inside a display:

```tex
\begin{equation*}
  \begin{aligned}
    Y &\simeq W\Phi, \\
    W &= Y\Phi^{+}.
  \end{aligned}
\end{equation*}
```

The theme loads AMS math, `bm` and Palatino math. Commands specific to the science
stay in the deck. The original Online QML seminar defined the following:

```tex
\newcommand{\Tr}{\mathop{\mathsf{Tr}}\nolimits}
\newcommand{\ntr}{n_{\mathsf{tr}}}
\newcommand{\nout}{n_{\mathsf{out}}}
\newcommand{\kett}[1]{|#1\rangle\!\rangle}
\newcommand{\bbra}[1]{\langle\!\langle#1|}
```

These are **not supplied by the theme**. Copy only the notation needed by a new
talk, or keep it in a separate notation file. The old `\bigeq` helper is absent;
use the native environments above.

## Citations and bibliography

### Loading sources

The theme loads `biblatex` with Biber. Add your bibliography in the preamble:

```tex
\addbibresource{references.bib}
```

For another project, substitute its actual bibliography filename. Standard
BibTeX fields such as `journal` and `year` are accepted through BibLaTeX's input
handling, alongside `journaltitle`, `date`, `eprint` and `eprinttype`. Existing
keys in this repository can be found in [references.bib](references.bib).
Use complete records where available; the formatter's tolerance of missing
fields does not make an incomplete record authoritative.

### Footer commands

Place citations inside the relevant frame, usually at the end of its source
after the scientific content:

```tex
\cite{2026romancinoa}
\cite*{2026romancino}
```

Each call contributes a paragraph to a small footer below a thin separator.
It produces no citation marker in the body. Multiple keys in **one call** run
consecutively in the **same paragraph**, wrapping naturally as needed:

```tex
\cite{2026romancinoa,2026romancino}
```

Use separate calls when you want separate paragraphs or a mix of full and
compact formatting. The reference deck uses both patterns. The theme measures
the footer and reserves space for it on normal, non-autobreak frames. Plain and
automatically broken frames skip that adjustment, so check their layout
separately. Citations reset on each frame.

| Form | Formatting |
| --- | --- |
| `\cite{key}` | Authors, italic title, publication details, year and eprint when present |
| `\cite*{key}` | Omits the title and prefers `shortjournal` over `journaltitle` |
| `\cite[postnote]{key}` | Adds a postnote, for example a chapter or equation reference |
| `\cite[prenote][postnote]{key}` | Adds both notes |

For example, `\cite[Sec.~3]{2026romancinoa}` points readers to a section
of the article. Starred citations accept the same optional-note syntax.

Both forms use initials and family names. **Both currently abbreviate long
author lists**: the package sets `maxcitenames=3`, `mincitenames=1`,
`maxbibnames=3` and `minbibnames=1`. The unstarred form does not force every author
to print. If a talk needs all named authors, override the BibLaTeX limits in its
preamble, for example:

```tex
\ExecuteBibliographyOptions{maxcitenames=99,maxbibnames=99}
```

An entry containing `and others` still represents an incomplete author list.
Author highlighting applies only to names that are actually printed.

Journal volumes are bold. Article numbers (`eid`) take precedence over pages;
otherwise the first page is printed. Publication details link to the DOI when
present, with the record's URL as a fallback in both full and compact citations.
arXiv identifiers link to their abstract pages. Raw URL and ISBN printing remain
disabled. For records without a journal, the custom formatter uses available
type, institution, publisher and note fields followed by the year. It is a
compact slide formatter, not a complete reproduction of every entry-type driver.

The footer uses 5.6 pt text with 6.8 pt leading. Prefer compact citations or
split the scientific material across frames when the footer becomes crowded.
Do not reduce the font further merely to fit more references. The old `\refs`
command is absent. Other BibLaTeX citation commands do not automatically acquire
this theme's custom `\cite` footer behaviour.

## Diagrams and research figures

### TikZ presets

The theme loads TikZ with `arrows.meta`, `calc`, `positioning` and
`decorations.pathmorphing`. Select a preset on each relevant picture:

| Preset | Styles provided | Defaults |
| --- | --- | --- |
| `control diagram` | `box`, `arr`, `lbl` | Rounded centred boxes, minimum 2.3 cm × 1 cm, `\small` node text; Stealth arrows; grey italic `\scriptsize` labels; node distance 8 mm vertically and 9 mm horizontally |
| `identification diagram` | `box`, `arr`, `lbl` | Inherits control formatting, with 0.95 cm minimum box height and 7 mm horizontal node distance |
| `reservoir diagram` | `box`, `arr`, `lbl` | Inherits control formatting, with 1 cm minimum box height and no preset minimum box width |
| `collaboration diagram` | `inst`, `home`, `lab`, `tag` | Blue 5 mm institution circles, magenta 7 mm home circle, centred `\scriptsize` labels, and sloped italic `\tiny` edge tags |

The short style names are local to pictures selecting that preset. Specify
fills, text colours, dimensions and positions for the scientific objects in the
deck. For example, the control preset does not assign a scientific meaning or a
fill colour to every box.

```tex
\begin{tikzpicture}[control diagram]
  \node[box,fill=tlpink] (state) {$\rho$};
  \node[box,fill=tlblue,right=of state] (measurement)
    {$\{\mu_b\}$};
  \node[right=of measurement] (outcome) {$b$};
  \draw[arr] (state) -- (measurement);
  \draw[arr] (measurement) -- (outcome);
  \node[lbl,below=of measurement] {measurement};
\end{tikzpicture}
```

The reference deck uses `control diagram` for networks, physical/effective
measurement pictures, prior comparisons and feedback loops, and `reservoir
diagram` for the QRC outlook. It also draws matrix schematics with ordinary TikZ
without a preset. Collaboration and identification presets are available for
other talks, although the current deck does not use them.

### PGFPlots and imported figures

PGFPlots uses `compat=1.18`. The global `palermo cycle` cycles through
`tblue/mark=*`, `tmag/mark=square*`, `tgreen/mark=triangle*`,
`tpink/mark=diamond*` and `tgray/mark=pentagon*`. A new `axis` inherits this cycle;
individual plot options can override it. Imported PDFs retain their original
styling and are not recoloured by the theme.

Place scientific figures next to the deck or use their path relative to the
project directory. Include them inside a frame or column:

```tex
\includegraphics[
  width=\linewidth,height=0.6\textheight,keepaspectratio
]{device.pdf}
```

Here width and height are upper bounds; `keepaspectratio` prevents stretching.
Adjust the height allowance to leave room for the frame's equations and footer.
Prefer vector PDFs for scientific plots. Crop surrounding paper text and excess
margins before sizing a figure; use `trim=left bottom right top,clip` when a local
crop is appropriate. Never crop away axes, units, legends or conditions needed
to interpret the result. For side-by-side plots, align their visual baselines
and use comparable scales. Check labels at the final projected size.

## Scientific writing and slide design

### Build an argument the audience can follow

The reference deck moves through a deliberate sequence: familiar linear
learning, its quantum measurement interpretation, the finite-shot problem,
the changed regression problem, the resulting method, evidence, computational
cost and extensions. A new talk should have its own equally clear causal path.

Introduce the physical object or experimental problem first. Then show the
equation that describes it. Finish with the consequence the audience needs for
the next step. This progression can happen within one slide or across several.
Give each scientific frame one main job: define, explain, compare, demonstrate
or interpret. Several equations can support that one job.

The slides support a spoken explanation. Put the relation the audience must
see on the screen; leave lengthy derivations and connecting prose to the talk
or backup material. Keep enough definitions and assumptions on the slide for
the displayed claim to be understood correctly.

### Keep writing minimal and specific

Use short labels, concrete titles and compact interpretations. Prefer a
diagram or equation when it can carry the explanation. Avoid paragraphs
copied from a paper, long bullet lists, repeated introductions and sentences
that merely announce what the presenter is about to do.

The reference voice is direct and conversational: “Shot noise lifts the rank”,
“More training states stop helping”, “Same data, two readouts”. Titles can name
a topic, state a supported result or ask a useful question. A playful question
can work on the cover or a transition; technical claims still need precision.
Do not force every title into a slogan or the same grammatical template.
Use sentence case and omit trailing periods from short titles.

| Wordy slide copy | More characteristic slide copy |
| --- | --- |
| “The following diagram illustrates the fact that the hidden features are kept fixed while the output layer is trained.” | Diagram labels: “fixed, random” and “trained” |
| “We now present a comparison of the two readout procedures when applied to an identical data set.” | “Same data, two readouts” |
| “The method does not require us to retain all observations collected in previous iterations.” | “no stored history” |

Use “we” when a short explanatory sentence benefits from shared reasoning.
Preserve mathematical `I` and established notation. Prefer common verbs such
as learn, measure, estimate, invert, compare and update. Avoid generic praise,
vague novelty claims and phrases such as “a powerful framework” or “unlocking
new possibilities”. Short text must still say something scientifically exact.

### Let equations carry the formal statement

Show the defining identity, estimator, scaling law or update rule. Usually one
to three prominent equations are enough for a frame; a method comparison or
algorithm may need more. This is a readability guide, not a numerical quota.

Introduce symbols before relying on them. Match symbols across the equation,
diagram and plot. Keep exact quantities, estimates, pseudoinverses, subscripts
and averaging operations distinct. Preserve the difference between `=`,
`\simeq`, `\propto` and asymptotic scaling. Keep the regime or assumption beside
the result, using a caption or short chip when appropriate.

Use `\underbrace` for a meaningful decomposition, as with bias and fluctuations.
Use colour to identify the same contribution across equations and plots. Include
only the algebra needed to understand the step; split a derivation when the
audience would have to read several independent arguments at once.

Follow the equation with its physical meaning: a short caption, a labelled
arrow, an annotated plot or a consequence such as “one linear regression”.
Do not simply restate every mathematical symbol in a sentence.

### Use many diagrams, with a scientific purpose

Use diagrams throughout the explanation, particularly for mechanisms,
transformations and algorithms. A diagram should make a relation visible:
what flows into what, which part is trained, what is measured, where noise
enters, or how a feedback loop closes.

Prefer editable TikZ for networks, measurement chains, matrix schematics,
geometric subspaces and feedback loops. Reuse the theme presets and existing
visual vocabulary. Label arrows when the operation or transmitted quantity
matters. Keep the reading direction clear and the notation identical to the
equations. Avoid decorative icons or unrelated imagery added only to fill space.

Use actual research plots for quantitative claims. A schematic with illustrative
entries is not numerical evidence. Preserve data, axes and uncertainty, and do
not invent a trend or simulation to make a slide more visually persuasive.

### Make comparisons easy to inspect

Give parallel methods parallel layouts: matching column widths, corresponding
equation positions, comparable plot scales and stable colour assignments. State
what is held fixed, what changes and the resulting difference. The comparison
“Same data, two readouts” is effective because its two formulas answer the same
question under the same setup.

Use chips for short conclusions, assumptions, regimes or dimensions. They are
small annotations, not containers for whole paragraphs. Use filled Beamer
blocks when they help group a real comparison, as in the algorithm slide.
Leave visible space between the main visual, mathematics and interpretation.
When a frame is crowded, remove repetition or split the argument before reducing
font sizes or uniformly shrinking the whole slide.

### Cite every scientific content slide

Include `\cite` or `\cite*` on every slide presenting scientific definitions,
methods, mathematical claims, data, prior work or proposed applications. This
includes recap and outlook slides. Repeat a relevant reference when its result
appears again; the audience should be able to identify the source on that page.

Choose sources that support the particular claim or figure. Cite original work
and the relevant current project where appropriate. Mark unpublished work as
such in the bibliography. On outlook slides, separate established background
from the proposed extension; citing related work does not establish the proposal.

The title, contents, section dividers, a purely rhetorical transition and the
thank-you/disclosure slide normally do not need scientific citations. If a
transition introduces a new factual claim, it needs a source too. These are the
natural exceptions to “citations on every page” in this style.

Use existing, verified bibliography keys. Never invent an author, title, DOI,
arXiv identifier or citation key to make a footer look complete. If a source is
missing, flag it during drafting and resolve it before delivery. Choose `\cite*`
when titles make the footer too long, and use separate calls when individual
references need their own paragraph.

### End with the result and its limits

Use a recap to recover the problem, idea and result, preferably through their
defining equations or diagrams. Give a concrete next step: the new physical
setting, proposed operation and unresolved issue. Label open work plainly,
as the reference deck does for correlated, history-dependent reservoir states.

Reserve standout slides for a genuine change of pace or the closing message.
Keep them short. An acknowledgement or AI-assistance notice should describe
what actually happened; never copy the reference deck's model attribution into
a new talk unless it is accurate for that work.

## Instructions for humans and LLMs

### Authoring workflow

1. Read the scientific sources, current notation, bibliography and available
   figures. Read this theme's implementation when an interface detail is unclear.
2. Outline the argument. For each proposed slide, record its one main point,
   supporting equation or visual, necessary assumptions and citation keys.
3. Choose a composition for the scientific relation. Use the patterns above
   selectively: mechanism, equivalence, result, comparison, algorithm or outlook.
4. Draft the title, principal diagram or plot, and equations before adding prose.
   Add only the labels and short interpretation needed to understand them.
5. Keep styling in `palermo-slides.sty`, reusable artwork in `template/assets/`,
   research figures with the talk, and talk-specific notation and content in the
   deck. Reuse helpers instead of reimplementing them in individual frames.
6. Check every scientific claim, assumption and citation against its source.
   Review the sequence for missing conceptual steps and unexplained symbols.
7. Compile with latexmk, inspect the actual PDF, then revise the slide content
   and layout where needed. Repeat the affected checks after changes.

### Reusable authoring brief

The following can be given to a human collaborator or an LLM alongside the
scientific material, bibliography, theme and reference deck:

```text
Create scientific Beamer slides in Alessandro Romancino's presentation style,
following README.md and using template/palermo-slides.sty.
Use slides.tex as an example of composition and explanatory order.

Build a clear argument: physical intuition, mathematical statement, then its
meaning or consequence. Give each scientific slide one main job. Use minimal
writing, prominent equations, many purposeful scientific diagrams, and actual
research plots. Prefer short labels and captions to paragraphs or bullet lists.
Keep titles direct and specific. Make comparisons visually parallel.

Preserve the supplied notation, assumptions, uncertainty and scientific claims.
Keep symbols and colours consistent across diagrams, equations and plots.
Distinguish established results, approximations and proposed extensions.
Never invent data, references or stronger conclusions than the sources support.

Cite every scientific content slide, including recaps and outlook, using verified
bibliography keys and the theme's \cite or \cite* footers. Covers, contents,
dividers and purely rhetorical or closing slides may omit scientific citations.
Flag missing evidence instead of filling it with a plausible-looking citation.

Use the existing native math environments, spacing helpers, captions, chips,
columns and TikZ presets. Keep shared styling in the theme and scientific content
in the deck. Do not introduce new dependencies or helpers without a concrete need.
Use the default cover artwork unless the brief requests an override.

Reduce text or split a crowded slide before shrinking type. Check figure labels,
equation width, diagram arrows, citation space, and the contents in the rendered
PDF. A successful build alone is not a visual or scientific review. Keep drafting
notes and implementation commentary out of the finished slides.
```

## Review and troubleshooting

### Before presenting or handing off

- Does every scientific frame have a clear purpose and a supported conclusion?
- Can the audience follow the conceptual sequence without an unexplained jump?
- Are notation, assumptions, estimates and approximation symbols consistent?
- Does every scientific content frame have the right citation or citations?
- Are plots legible at presentation size, with necessary axes and conditions?
- Do diagrams explain a mechanism or relation, with readable labels and arrows?
- Do equations, chips, title bars and footers fit without overlap or clipping?
- Do cover artwork, progress bars, contents links and frame counts render correctly?
- Are all citation keys resolved, and do rendered references match the intended works?
- Are proposed extensions and any assistance disclosures described accurately?

Inspect the compiled PDF at full-slide size. Use extracted text as an additional
check, but not as a substitute for looking at the page. Check the log separately
for missing assets, undefined commands, unresolved citations/references and
overfull boxes. A build that exits successfully may still have layout problems.

### Common issues

| Symptom | Check or correction |
| --- | --- |
| `palermo-slides.sty` not found | Run `kpsewhich palermo-slides.sty` to check the installation, or use `\usepackage{template/palermo-slides}` with a project-local copy |
| Cover artwork missing | Copy the full theme folder, including `assets/`; check optional custom paths and intentionally empty setup keys |
| Requested/provided package-name warning | Use the current style file, whose declaration includes its loading path dynamically |
| Undefined `\Tr`, `\ntr`, `\nout`, `\kett` or `\bbra` | Define the required scientific notation in the deck |
| Undefined `\bigeq` or `\refs` | Replace them with native math environments or bibliography-backed `\cite` calls |
| Citations or contents have not updated | Let latexmk complete Biber and subsequent LaTeX passes; inspect the build log if it stops |
| Figure, equation or chip is clipped | Check the actual bounding box and available column width; simplify or split the content |
| Citation/disclosure overlap | Use the disclosure on a separate frame and reserve enough visible footer space |
| PGFPlots `Duplicate label =` in VS Code only | Check whether the warning refers to internal `\let\label=...` code; this can be a LaTeX Workshop false positive. Compare with the LaTeX log before changing any source labels |

When updating this guide, check helper definitions, default values and real deck
usage together. In particular, preserve the distinction between theme commands
and scientific notation, and verify citation formatting in the rendered PDF.
