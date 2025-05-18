<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="concept.xsl"/>

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="//extent"/>
</context>
</xsl:template>

<xsl:template match="extent[contains(object, 'same person')]">
	<object name="{object[1]}">
		<xsl:apply-templates select="//edge[./@from = current()/@id]" mode="follow"/>
	</object>
</xsl:template>

<xsl:template match="edge" mode="follow">
	<xsl:apply-templates select="//extent[./@id = current()/@to]" mode="attributes"/>
</xsl:template>

<xsl:template match="extent" mode="attributes">
		<xsl:call-template name="getAttributesBelow"/>
</xsl:template>

<xsl:template match="extent" />

</xsl:stylesheet>
