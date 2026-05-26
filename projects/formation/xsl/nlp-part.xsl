<?xml version="1.0"?>
<xsl:stylesheet xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="nlp">

<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<!-- 
	Convert Baleen XML to events
 -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/">
<map description="KEY is part of VALUE">
	<xsl:apply-templates select="//nlp:document"/>
</map>
</xsl:template>

<xsl:template match="nlp:document">
	<xsl:apply-templates select="nlp:sentence"/>
</xsl:template>

<xsl:template match="nlp:sentence">
	<xsl:apply-templates select="nlp:token[nlp:lemma[. = 'part'][@type = 'VP']]" mode="part"/>
</xsl:template>

<xsl:template match="nlp:token" mode="part">
	<xsl:variable name="target"><xsl:value-of select="following-sibling::nlp:token[1]//nlp:lemma[@type = 'UNIT'][1]"/></xsl:variable>
	<xsl:choose>
		<xsl:when test="string-length($target) &gt; 0">
	<xsl:message><xsl:value-of select="$target"/></xsl:message>
			<xsl:apply-templates select="preceding-sibling::nlp:token[1]" mode="entry">
				<xsl:with-param name="target" select="$target"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
	<xsl:message>unkown: <xsl:value-of select="following-sibling::nlp:token[1]/nlp:surface"/></xsl:message>
			<xsl:apply-templates select="preceding-sibling::nlp:token[1]" mode="entry">
				<xsl:with-param name="target" select="following-sibling::nlp:token[1]/nlp:surface"/>
			</xsl:apply-templates>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="nlp:token" mode="entry">
	<xsl:param name="target"/>
	<xsl:for-each select=".//nlp:lemma[@type = 'UNIT']">
		<entry key="{.}" value="{$target}"/>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
