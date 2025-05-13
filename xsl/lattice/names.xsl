<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="//extent" mode="roots"/>
</context>
</xsl:template>

<xsl:template match="extent" mode="roots">
	<xsl:if test="not(//edge[@to = current()/@id])">
		<xsl:apply-templates select="." mode="find"/>
	</xsl:if>
</xsl:template>

<xsl:template match="extent[attribute]" mode="find">
	<object name="{@id}">
		<xsl:apply-templates select="." mode="attributes"/>
	</object>
</xsl:template>

<xsl:template match="extent" mode="find">
	<extent id="{@id}"/>
	<xsl:apply-templates select="//edge[./@from = current()/@id]" mode="find"/>
</xsl:template>

<xsl:template match="extent" mode="attributes">
	<xsl:copy-of select=".//attribute"/>
	<xsl:apply-templates select="//edge[./@from = current()/@id]" mode="follow"/>
</xsl:template>

<xsl:template match="edge" mode="find">
	<xsl:apply-templates select="//extent[./@id = current()/@to]" mode="find"/>
</xsl:template>

<xsl:template match="edge" mode="follow">
	<xsl:apply-templates select="//extent[./@id = current()/@to]" mode="attributes"/>
</xsl:template>

</xsl:stylesheet>
