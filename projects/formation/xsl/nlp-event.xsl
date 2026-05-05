<?xml version="1.0"?>
<xsl:stylesheet xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="nlp">

<!-- 
	Convert Baleen XML to events
 -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//nlp:document"/>
</temporal>
</xsl:template>

<xsl:template match="nlp:document">
	<xsl:apply-templates select="nlp:sentence"/>
</xsl:template>

<xsl:template match="nlp:sentence">
	<event uri="{generate-id()}">
		<text><xsl:value-of select="normalize-space(substring(../nlp:text, @begin + 1, @end - @begin))"/></text>
		<xsl:apply-templates select="nlp:annotation[@type = 'UNIT']"/>
		<xsl:apply-templates select="nlp:annotation[@type = 'DATE']"/>
	</event>
</xsl:template>

<xsl:template match="nlp:annotation[@type = 'UNIT']">
	<entity type="unit"><xsl:value-of select="@lemma"/></entity>
</xsl:template>

<xsl:template match="nlp:annotation[@type = 'DATE']">
	<entity type="date"><xsl:value-of select="@lemma"/></entity>
</xsl:template>

<xsl:template match="nlp:annotation" mode="fm">
	<xsl:attribute name="fm"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:annotation" mode="to">
	<xsl:attribute name="to"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

</xsl:stylesheet>
