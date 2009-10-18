<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<xsl:import href="http://db2latex.sourceforge.net/xsl/docbook.xsl"/>

<xsl:variable name="use.extentions">1</xsl:variable>
<xsl:variable name="latex.use.parskip">1</xsl:variable>
<xsl:variable name="admon.graphics.path">/usr/share/xml/docbook/stylesheet/db2latex/latex/figures</xsl:variable>
<xsl:variable name="l10n.gentext.default.language">en</xsl:variable>
<xsl:variable name="latex.documentclass.common"></xsl:variable>
<xsl:variable name="latex.babel.language"></xsl:variable>
<xsl:template name="latex.float.preamble" />

</xsl:stylesheet>
