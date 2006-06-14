all: html pdf

graphics = buildcore depgraph

xmllint-stamp-%: %.xml
	xmllint --xinclude --postvalid --noblanks --noout $<
	touch $@

html: cdbs-doc.html
%.html: %.xml xmllint-stamp-% cdbs-doc-xhtml.xsl $(graphics:%=%.png)
	xsltproc --xinclude -o $@ cdbs-doc-xhtml.xsl $<

%.tex-pdf: %.xml xmllint-stamp-% cdbs-doc-latex.xsl
	xsltproc --xinclude --stringparam graphic.default.extension pdf -o $@ cdbs-doc-latex.xsl $<

%.tex-ps: %.xml xmllint-stamp-% cdbs-doc-latex.xsl
	xsltproc --xinclude --stringparam graphic.default.extension eps -o $@ cdbs-doc-latex.xsl $<

dvi: cdbs-doc.dvi
%.dvi: %.tex-ps $(graphics:%=%.eps)
# 3 passes to avoid undefined references
	latex $<
	mkindex $<
	latex $<
	latex $<

pdf: cdbs-doc.pdf
%.pdf: %.tex-pdf $(graphics:%=%.pdf)
	pdflatex $<
	pdflatex $<

ps: cdbs-doc.ps
%.ps: %.dvi
	dvips $<

txt: cdbs-doc.txt
%.txt: %.html
	elinks -dump -no-numbering -no-references $< >$@

%.png: %.dot
	dot -Tpng -o $@ $^

%.eps: %.dot
	dot -Tps2 -o $@ $^ -Gsize='6,10'

%.pdf: %.eps
	epstopdf --outfile=$@ $<

all_mk_files := $(wildcard ../1/*/*.mk)

depgraph-tmp.dot: gen-dotty.pl $(all_mk_files)
	perl $^ >$@

depgraph.dot: depgraph-tmp.dot
	unflatten -l 5 -o $@ $^


clean:
	rm -f *.aux *.dvi *.out *.log *.glo *.idx *.ind *.ilg *.lot *.lof *.toc *.tex *.fo *.png *.pdf *.eps *.tex-* *.html *.ps *.txt xmllint-stamp-*
	rm -f depgraph.dot depgraph-tmp.dot

distclean: clean


.PHONY: all install install-data install-exec uninstall install-info installdirs check installcheck clean distclean maintainer-clean

.SECONDARY:
