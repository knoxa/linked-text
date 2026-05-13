<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="no"/>


<xsl:template match="nlp:document">
<article>
	<p>
		<xsl:apply-templates select="nlp:sentence"/>
	</p>
</article>
</xsl:template>

<xsl:template match="nlp:sentence">
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="nlp:token[1]" mode="next"/>
</xsl:template>

<xsl:template match="nlp:token">
	<xsl:value-of select="nlp:surface"/>
</xsl:template>

<xsl:template match="nlp:token" mode="next">
	<xsl:apply-templates select="."/>
	<xsl:if test="following-sibling::nlp:token[1][@begin &gt; current()/@end]"><xsl:text> </xsl:text></xsl:if>
	<xsl:apply-templates select="following-sibling::nlp:token[1]" mode="next"/>
</xsl:template>

</xsl:stylesheet>
