<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="concept.xsl"/>

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="//object"/>
</context>
</xsl:template>

<xsl:template match="object">
	<object name="{.}">
		<xsl:apply-templates select=".." mode="attributes"/>
	</object>
</xsl:template>

<xsl:template match="extent" mode="attributes">
	<xsl:call-template name="getConceptAttributes"/>
</xsl:template>


</xsl:stylesheet>
