# Full build: lualatex, biber for the bibliography, then two more passes so that
# the table of contents, the cross-references and the citations settle.
main.pdf: main.tex misc/*.tex chapters/*.tex appendices/*.tex literature.bib
	lualatex main.tex && biber main && lualatex main.tex && lualatex main.tex

# One pass, for a quick look while writing. References may lag by one build.
quick:
	lualatex main.tex

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.lof *.log *.lot *.out *.run.xml *.synctex.gz *.toc
	rm -f chapters/*.aux appendices/*.aux misc/*.aux

.PHONY: quick clean
