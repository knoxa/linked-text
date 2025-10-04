<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/">
<bag>
	<xsl:apply-templates select="//entity"/>
</bag>
</xsl:template>

<xsl:template match="entity">
	<xsl:variable name="surface">
		<xsl:choose>
			<xsl:when test="@surface">
				<xsl:value-of select="@surface"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="normalize-space(.)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<entry key="{$surface}" value="{normalize-space(.)}"/>
</xsl:template>


</xsl:stylesheet>
