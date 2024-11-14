<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
	<context>
		<xsl:apply-templates select="//extent" />
	</context>
</xsl:template>

<xsl:template match="extent">
	<xsl:if test="not(//edge[@to = current()/@id])">
		<xsl:apply-templates select="." mode="start"/>
	</xsl:if>
</xsl:template>

<xsl:template match="extent[attribute]" mode="start">
	<object name="{@id}">
		<xsl:copy-of select="attribute" />
		<xsl:apply-templates select="//edge[@from = current()/@id]" mode="chain" />
	</object>
</xsl:template>

<xsl:template match="edge" mode="chain">
	<xsl:apply-templates select="//extent[./@id = current()/@to]" mode="chain" />
</xsl:template>

<xsl:template match="extent[attribute]" mode="chain">
	<xsl:copy-of select="attribute" />
	<xsl:apply-templates select="//edge[./@from = current()/@id]" mode="chain" />
</xsl:template>

<xsl:template match="extent" mode="start">
	<xsl:apply-templates select="//edge[@from = current()/@id]" mode="start" />
</xsl:template>

<xsl:template match="edge" mode="start">
	<xsl:apply-templates select="//extent[./@id = current()/@to]" mode="start" />
</xsl:template>

<xsl:template match="extent[contains(object, 'ASSERTION')]" mode="start">
<xsl:message>HERE</xsl:message>
	<object name="{@id}">
		<xsl:copy-of select="attribute" />
		<xsl:apply-templates select="//edge[@from = current()/@id]" mode="chain" />
	</object>
</xsl:template>

</xsl:stylesheet>
