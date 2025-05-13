<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>


<xsl:template match="/">
<html:html>
<html:head><html:title>Work</html:title></html:head>
<html:body>
	<html:h2><xsl:copy-of select="//description"/></html:h2>
    <xsl:apply-templates select="//item"/>
</html:body>
</html:html>
</xsl:template>

<xsl:template match="item">
	<xsl:apply-templates select="document(.)//html:article"/>
</xsl:template>

<xsl:template match="html:article[@typeof = 'mil:message']">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="html:article">
</xsl:template>

</xsl:stylesheet>
