<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<!-- 
	Input XHTML events, output event objects with text and mentioned entities
 -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="source" select="''"/>
<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>
<xsl:import href="entity-span.xsl"/>

<xsl:template match="/">
<data>
	<xsl:apply-templates select="//html:article"/>
</data>
</xsl:template>

<xsl:template match="html:article">
	<xsl:apply-templates select=".//html:p[not(@class = 'date' or html:span/@class = 'date')]"/>
</xsl:template>

<xsl:template match="html:p">
<xsl:variable name="id"><xsl:call-template name="getId"/></xsl:variable>
<event source="{preceding::html:title[1]}" uri="{concat($source, '#', $id)}">
	<xsl:variable name="text"><xsl:apply-templates select="." mode="copy"/></xsl:variable>
	<xsl:variable name="hash">
		<xsl:call-template name="hashMD5">
			<xsl:with-param name="text" select="$text"/>
		</xsl:call-template>
	</xsl:variable>
	<text hash="{$hash}"><xsl:value-of select="normalize-space($text)"/></text>
	<xsl:apply-templates select="html:span"/>
	<xsl:apply-templates select="html:i/html:span"/>
</event>
</xsl:template>


<xsl:template match="html:span[@class= 'ref']"/>
<xsl:template match="html:span[@class= 'date']"/>

 
<xsl:template match="*" mode="copy">
	<xsl:apply-templates select="text()|*" mode="copy"/>
</xsl:template>

<xsl:template match="text()" mode="copy">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="html:span[@class = 'ref']" mode="copy"/>

<xsl:template name="getId">
	<xsl:choose>
		<xsl:when test="@id">
			<xsl:value-of select="@id"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="generate-id()"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
