<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<!-- 
	Make an "entity" XML elements from html:span
 -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template name="getSpanAsEntity">
	<xsl:choose>
		<xsl:when test="@content">
			<entity type="{@class}" surface="{normalize-space(.)}"><xsl:value-of select="@content"/></entity>
		</xsl:when>
		<xsl:otherwise>
			<entity type="{@class}"><xsl:value-of select="normalize-space(.)"/></entity>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
