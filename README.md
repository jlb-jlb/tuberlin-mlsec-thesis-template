# TU Berlin MLSec thesis template

A working LaTeX thesis for the Chair of Machine Learning and Security at TU
Berlin. Every chapter is filled with placeholder text that exercises one part of
the layout, so the build shows what the template can do before you write a word.
Based on the PSI chair thesis template (`PSIThesis.cls`, LPPL), adapted for TU
Berlin: title page, the German declaration the examination office prescribes, a
German abstract beside the English one, a wide margin column, and wide floats
that span text and margin.

```bash
make            # lualatex, biber, two more passes
make quick      # one pass while writing
```

`example.pdf` is this template built once, so you can see the result without
running LaTeX. It is a snapshot, not a build artifact: `main.pdf` stays untracked,
so your own builds never show up as changes.

Two marks name the template, both defined under TEMPLATE ATTRIBUTION in
`misc/setup.tex`. The PDF's creator field carries a "made with" note, which is
metadata and never part of your text. The verso of the title page carries a line in
white on white, so that page still prints blank, and copy and paste, screen readers
and text extraction return it. Remove either one there if you do not want it in
your submission.

The build needs LuaLaTeX and Biber; it does not compile with pdfLaTeX, because
the fonts are loaded through `fontspec`.

## What to edit first

| Where | What |
|---|---|
| `main.tex`, THESIS INFORMATION block | title, your name, student id, examiners, supervisor |
| `misc/acronyms.tex` | your acronyms, one `\DeclareAcronym` each |
| `literature.bib` | your references, exported from Zotero or by hand |
| `chapters/*.tex` | the text, replacing the placeholder prose |
| `figures/signature_cropped.png` | your signature, cropped to the ink; without it the declaration prints a blank rule |

The declaration on the first page is the wording of the German
`Eigenständigkeitserklärung`, reproduced verbatim. Do not paraphrase it. It
points at the section on generative AI tools in the methodology chapter, where
the office requires the product name, the manufacturer, the version, and the
purpose of every tool used.

## Layout elements

The page carries a 41.4 mm margin column beside a 115 mm text block. Each
element below appears in the built PDF, so look there for the rendered result.

| Element | Where it is shown | Use it for |
|---|---|---|
| `margintable` | `chapters/introduction.tex`, `chapters/results.tex` | three or four narrow columns beside the paragraph that reads them |
| `marginfigure` | `chapters/background.tex` | a small plot or sketch, centred on its line |
| `\sidenote` | `chapters/introduction.tex` | a remark that would break the sentence |
| a caption-less `marginfigure` | `chapters/methodology.tex`, the robot beside the AI section | decoration, kept out of the list of figures by omitting caption and label |
| `table`, `figure` | `chapters/methodology.tex` | anything that fits the 115 mm text block |
| `widetable`, `widefigure` | `chapters/results.tex` | a table or plot that needs text block plus margin, 164.6 mm |
| `lstlisting` | `chapters/methodology.tex`, `appendices/appendixB.tex` | code and verbatim material |
| full-width appendices | `appendices/` | the margin folds into the text block after `\appendix` |

Draw figures with TikZ where you can, using the styles in `misc/figures.tex`, so
they inherit the thesis fonts and the TU palette and stay sharp at any zoom.

## Chapter structure

```
1 Introduction                     motivation, research question, contributions, outline
2 Background and Related Work
3 Dataset and Corpus Engineering   where the data comes from and how it is processed
4 Methodology                      task, protocol, models, and the AI-tools section
5 Experiments and Results          chapters/experiments/, one file per experiment
6 Discussion                       interprets chapter 5, closing with the limitations
7 Conclusion and Future Work
A, B Appendices                    full width, for reproducibility material and listings
```

Two files are pulled in with `\input` rather than `\include`, because `\include`
forces a page break and `\input` does not. The limitations are a section of the
discussion, kept in `chapters/limitations.tex` so they can be written and reviewed
on their own. The first experiment section is `\input` from
`chapters/experiments.tex`, so the chapter opening runs straight into it instead
of sitting alone on a page; every later section is `\include`d from `main.tex` and
keeps its own `.aux` for `scripts/scope.sh`.

Delete a chapter you do not need. A thesis that uses an existing dataset drops
chapter 3, and a short one can keep the experiments in a single file.

## Conventions the template assumes

One sentence per line in the source, which keeps diffs readable and makes a
sentence easy to move. Cross-references through cleveref, so `\Cref{...}`
supplies the word and you never type "Section" yourself. A `% Source:` comment
beside every number, naming the run or file it came from. Table and figure
headers as plain text, since an acronym macro renders them as a coloured link.

## Files

```
main.tex              document structure: front matter, includes, bibliography, appendices
PSIThesis.cls         the class, from the PSI template (LPPL)
misc/setup.tex        packages, page geometry, fonts, colours, float environments
misc/commands.tex     small text commands
misc/figures.tex      shared TikZ styles and the TU palette
misc/titlepage.tex    the title page
misc/acronyms.tex     acronym definitions
chapters/             one file per chapter
chapters/experiments/ one file per experiment section
appendices/           one file per appendix
figures/              images and standalone TikZ files
fonts/                Roboto and Iosevka, used by fontspec
scripts/scope.sh      limit a build to one chapter while writing
```

## Building one chapter

A full build typesets everything. While working on a single chapter:

```bash
./scripts/scope.sh chapters/methodology.tex   # only this file is re-typeset
./scripts/scope.sh --all                      # back to a full build
```

Every other chapter is reused from its `.aux`, so page numbers and references
stay correct. Run one full build first, so that each chapter has an `.aux` file.

## Licence

The template and this text are CC BY-SA 4.0, following the PSI thesis template
it derives from. `PSIThesis.cls` is LPPL v1.3c. The bundled fonts carry their own
licences in `fonts/`.
