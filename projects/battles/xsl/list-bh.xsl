<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="text" encoding="UTF-8" />

<xsl:template match="/">
<temporal>
    <xsl:apply-templates select="//html:div"/>
</temporal>
</xsl:template>


<xsl:template match="html:div">
    <xsl:apply-templates select="html:article"/>
</xsl:template>

<xsl:template match="html:article">
	<xsl:apply-templates select=".//html:li"/>
</xsl:template>

<xsl:template match="html:li">
	<xsl:value-of select="."/><xsl:text>&#13;</xsl:text>
</xsl:template>

</xsl:stylesheet>
