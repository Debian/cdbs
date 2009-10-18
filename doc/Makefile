all: html pdf

xmllint-stamp-%: %.xml
	xmllint --xinclude --postvalid --noblanks --noout $<
	touch $@

html: cdbs-doc.html
%.html: %.xml xmllint-stamp-% cdbs-doc-xhtml.xsl
	xsltproc --xinclude -o $@ cdbs-doc-xhtml.xsl $<

tex: cdbs-doc.tex
%.tex: %.xml xmllint-stamp-% cdbs-doc-latex.xsl
	xsltproc --xinclude -o $@ cdbs-doc-latex.xsl $<

dvi: cdbs-doc.dvi
%.dvi: %.tex
# 3 passes to avoid undefined references
	latex $<
	mkindex $<
	latex $<
	latex $<

pdf: cdbs-doc.pdf
%.pdf: %.tex
	pdflatex $<
	pdflatex $<

ps: cdbs-doc.ps
%.ps: %.dvi
	dvips $<

txt: cdbs-doc.txt
%.txt: %.html
	elinks -dump -no-numbering -no-references $< >$@


clean:
	rm -f *.aux *.dvi *.out *.log *.glo *.idx *.ind *.ilg *.lot *.lof *.toc *.tex *.fo

distclean: clean
	rm -f *.html *.pdf *.ps *.txt


.PHONY: all install install-data install-exec uninstall install-info installdirs check installcheck clean distclean maintainer-clean
