<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nlp="http://example.org/nlp/parse" exclude-result-prefixes="nlp" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<map>
<xsl:comment>Key is altLabel, value is prefLabel, are both places</xsl:comment>
    <xsl:apply-templates select="//nlp:annotation[@type = '_SAME_AS_']"/>
</map>
</xsl:template>

<xsl:template match="nlp:annotation[@type = '_SAME_AS_']">
	<xsl:apply-templates select="../nlp:annotation[@type = '*place']" mode="place">
		<xsl:with-param name="value" select="preceding-sibling::nlp:annotation[@type = '*place'][1]/@lemma"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="nlp:annotation[@type = '_SAME_AS_'][contains(@lemma, 'abbreviation for')]">
	<xsl:apply-templates select="preceding-sibling::nlp:annotation[@type = '*place'][1]" mode="place">
		<xsl:with-param name="value" select="following-sibling::nlp:annotation[@type = '*place'][1]/@lemma"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="nlp:annotation" mode="place">
	<xsl:param name="value"/>
	<entry key="{./@lemma}" value="{$value}"/>
</xsl:template>

</xsl:stylesheet>

