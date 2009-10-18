all: html pdf

graphics = buildcore depgraph

xmllint-stamp-%: %.xml
	xmllint --nonet --xinclude --postvalid --noblanks --noout $<
	touch $@

html: cdbs-doc.html
%.html: %.xml xmllint-stamp-% cdbs-doc-xhtml.xsl $(graphics:%=%.png)
	xsltproc --nonet --xinclude -o $@ cdbs-doc-xhtml.xsl $<

pdf: cdbs-doc.pdf
%.pdf: %.xml xmllint-stamp-% $(graphics:%=%.pdf)
	dblatex -b pdftex -T db2latex $<

ps: cdbs-doc.ps
%.ps: %.xml xmllint-stamp-% $(graphics:%=%.eps)
	dblatex -T db2latex -t ps -f eps $<

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