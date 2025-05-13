<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<context>
	<xsl:apply-templates select="//event"/>
</context>
</xsl:template>

<xsl:template match="event">
	<object name="{@uri}">
		<xsl:copy-of select="text"/>
		<xsl:apply-templates select="entity"/>
	</object>
</xsl:template>

<xsl:template match="entity">
	<attribute><xsl:value-of select="."/></attribute>
</xsl:template>

</xsl:stylesheet>
