<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<!-- 
	Rowe: Input XHTML events, output event objects with text and mentioned entities
 -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="source" select="'operations.xhtml'"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//html:tr[html:td/@class = 'op']"/>
</temporal>
</xsl:template>

<xsl:template match="html:tr">
	<event uri="{generate-id()}">
		<xsl:apply-templates select="following-sibling::html:tr[1]/html:td[1]/html:datetime" mode="fm"/>
		<xsl:apply-templates select="following-sibling::html:tr[2]/html:td[1]/html:datetime" mode="to"/>
		<text><xsl:value-of select="html:td"/></text>
	</event>
</xsl:template>

<xsl:template match="html:datetime" mode="fm">
	<xsl:attribute name="fm"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="html:datetime" mode="to">
	<xsl:attribute name="to"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

</xsl:stylesheet>
