<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="//extent" mode="facts"/>
</context>
</xsl:template>

<xsl:template match="extent[attribute = 'FACT']" mode="facts">
	<xsl:apply-templates select="." mode="object"/>
</xsl:template>

<!-- 
<xsl:template match="extent[object = 'paes']" mode="facts">
	<xsl:apply-templates select="." mode="object"/>
</xsl:template>
 -->

<xsl:template match="extent[object]" mode="object">
	<object name="{object}">
		<xsl:apply-templates select="." mode="attributes"/>
	</object>
</xsl:template>

<xsl:template match="extent[object][attribute = 'FACT']" mode="object">
	<object name="{object}">
		<xsl:apply-templates select="." mode="attributesx"/>
	</object>
</xsl:template>

<xsl:template match="extent" mode="object">
	<xsl:apply-templates select="//edge[./@to = current()/@id]" mode="down"/>
</xsl:template>

<xsl:template match="edge" mode="down">
	<xsl:apply-templates select="//extent[./@id = current()/@from]" mode="object"/>
</xsl:template>

<xsl:template match="extent" mode="attributes">
	<xsl:copy-of select=".//attribute"/>
	<xsl:choose>
		<xsl:when test="attribute = 'FACT'">
		</xsl:when>
		<xsl:when test="not(//edge[@from = current()/@id])">
			<xsl:apply-templates select="//edge[./@to = current()/@id]" mode="follow-down"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="//edge[./@from = current()/@id]" mode="follow"/>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template match="extent" mode="attributesx">
	<xsl:copy-of select=".//attribute"/>
	<xsl:choose>
		<xsl:when test="not(//edge[@from = current()/@id])">
			<xsl:apply-templates select="//edge[./@to = current()/@id]" mode="follow-down"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="//edge[./@from = current()/@id]" mode="follow"/>
		</xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<xsl:template match="extent" mode="attributes-down">
	<xsl:copy-of select=".//attribute"/>
	<xsl:apply-templates select="//edge[./@to = current()/@id]" mode="follow-down"/>
</xsl:template>

<xsl:template match="edge" mode="follow">
	<xsl:apply-templates select="//extent[./@id = current()/@to]" mode="attributes"/>
</xsl:template>

<xsl:template match="edge" mode="follow-down">
	<xsl:apply-templates select="//extent[./@id = current()/@from]" mode="attributes-down"/>
</xsl:template>

<xsl:template match="extent" mode="facts"/>

</xsl:stylesheet>
