<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nlp="http://example.org/nlp/parse" exclude-result-prefixes="nlp" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<map>
<xsl:comment>Key and value are both places, "key" is in "value".</xsl:comment>
    <xsl:apply-templates select="//nlp:annotation[@type = '_PLACEIN_' or @type = '_IS_IN_']"/>
</map>
</xsl:template>

<xsl:template match="nlp:annotation[@type = '_PLACEIN_' or @type = '_IS_IN_']">
	<xsl:apply-templates select="preceding-sibling::nlp:annotation[@type = '*place']" mode="placeIn">
		<xsl:with-param name="value" select="following-sibling::nlp:annotation[@type = '*place'][1]/@lemma"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="nlp:annotation" mode="placeIn">
	<xsl:param name="value"/>
	<entry key="{./@lemma}" value="{$value}"/>
</xsl:template>

</xsl:stylesheet>

