
all: check xhtml pdf ps txt

clean:
	rm -f *.aux *.dvi *.out *.log *.glo *.idx *.ind *.ilg *.lot *.lof *.toc *.tex *.fo *.tmp cdbs-doc_error.log

dist-clean: clean
	rm -f *.xhtml *.pdf *.ps *.txt

check: check.tmp
check.tmp: cdbs-doc.xml
	(xmllint --xinclude --postvalid --noblanks --noout cdbs-doc.xml 2>&1) >cdbs-doc_error.log
	touch check.tmp

xhtml: cdbs-doc.xhtml
cdbs-doc.xhtml: check.tmp cdbs-doc-xhtml.xsl
	xsltproc --xinclude -o cdbs-doc.xhtml cdbs-doc-xhtml.xsl cdbs-doc.xml

tex: cdbs-doc.tex
cdbs-doc.tex: check.tmp cdbs-doc-latex.xsl
	xsltproc --xinclude -o cdbs-doc.tex cdbs-doc-latex.xsl cdbs-doc.xml

dvi: cdbs-doc.dvi
cdbs-doc.dvi: cdbs-doc.tex
	# 3 passes to avoid undefined references
	latex cdbs-doc.tex
	mkindex cdbs-doc.tex
	latex cdbs-doc.tex
	latex cdbs-doc.tex

pdf: cdbs-doc.pdf
cdbs-doc.pdf: cdbs-doc.tex
	pdflatex cdbs-doc.tex
	pdflatex cdbs-doc.tex

ps: cdbs-doc.ps
cdbs-doc.ps: cdbs-doc.dvi
	dvips cdbs-doc.dvi

txt: cdbs-doc.txt
cdbs-doc.txt: cdbs-doc.dvi
	catdvi cdbs-doc.dvi > cdbs-doc.txt

