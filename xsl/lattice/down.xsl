<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="//extent" mode="terminal"/>
</context>
</xsl:template>

<xsl:template match="extent" mode="terminal">
	<xsl:if test="not(//edge[@from = current()/@id])">
		<object name="{concat('N',@id)}">
			<xsl:apply-templates select="." mode="attributes"/>
		</object>
	</xsl:if>
</xsl:template>

<xsl:template match="extent" mode="attributes">
	<xsl:copy-of select=".//attribute"/>
	<xsl:apply-templates select="//edge[./@to = current()/@id]" mode="follow"/>
</xsl:template>

<xsl:template match="edge" mode="follow">
	<xsl:apply-templates select="//extent[./@id = current()/@from]" mode="attributes"/>
</xsl:template>

</xsl:stylesheet>
