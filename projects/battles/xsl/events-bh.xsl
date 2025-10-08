<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<temporal>
    <xsl:apply-templates select="//html:div"/>
</temporal>
</xsl:template>


<xsl:template match="html:div">
    <xsl:apply-templates select="html:article"/>
</xsl:template>

<xsl:template match="html:article">
	<event uri="{concat('#', generate-id())}" fm="{.//html:datetime[1]/@content}" to="{.//html:datetime[last()]/@content}">
		<text><xsl:value-of select="html:h3"/></text>
		<entity type="theatre"><xsl:value-of select="ancestor::html:div[1]/@id"/></entity>
	</event>
</xsl:template>


</xsl:stylesheet>
