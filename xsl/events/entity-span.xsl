<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<xsl:template match="html:span">
<xsl:if test="not(preceding-sibling::html:span[. = current()])">
	<xsl:choose>
		<xsl:when test="@content">
			<entity type="{@class}" surface="{normalize-space(.)}"><xsl:value-of select="@content"/></entity>
		</xsl:when>
		<xsl:otherwise>
			<entity type="{@class}"><xsl:value-of select="normalize-space(.)"/></entity>
		</xsl:otherwise>
	</xsl:choose>
</xsl:if>
</xsl:template>

</xsl:stylesheet>
