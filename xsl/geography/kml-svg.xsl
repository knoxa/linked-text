<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:kml="http://www.opengis.net/kml/2.2" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<svg viewBox="-1 -51 8 4" preserveAspectRatio="none">
<style>
.point {
	stroke:		none;
	fill:		red;
	opacity:	0.1;
}
.path {
	stroke:		pink;
	stroke-width: 0.005;
	fill:		none;
}
</style>

<g id="A" transform="scale(1.0,-1.0)">
	<xsl:apply-templates select="//kml:Point"/>
</g>

<g class="path" id="B" transform="scale(1.0,-1.0)">
	<xsl:apply-templates select="//kml:LineString[1]"/>
</g>

</svg>
</xsl:template>


<xsl:template match="kml:Point">
	<xsl:variable name="lon"><xsl:value-of select="number(substring-before(kml:coordinates, ','))"/></xsl:variable>
	<xsl:variable name="lat"><xsl:value-of select="number(substring-before(substring-after(kml:coordinates, ','), ','))"/></xsl:variable>
	<circle class="point" cx="{$lon}" cy="{$lat}" r="0.03" />
</xsl:template>

<xsl:template match="kml:LineString">	
	<xsl:variable name="path"><xsl:apply-templates select="kml:coordinates" mode="linestring"/></xsl:variable>
	<path d="{$path}"/>
</xsl:template>

<xsl:template match="kml:coordinates" mode="linestring">
	<xsl:call-template name="getOneCoordinate">
		<xsl:with-param name="text" select="." />
		<xsl:with-param name="op" select="'M'" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="getOneCoordinate">
	<xsl:param name="text" />
	<xsl:param name="op" select="'L'"/>
	<xsl:variable name="next"><xsl:value-of select="substring-before($text, ' ')"/></xsl:variable>
	<xsl:variable name="subsequent"><xsl:value-of select="substring-after($text, ' ')"/></xsl:variable>
	<xsl:if test="string-length($subsequent) &gt; 0">
		<xsl:variable name="lon"><xsl:value-of select="number(substring-before($next, ','))"/></xsl:variable>
		<xsl:variable name="lat"><xsl:value-of select="substring-before(substring-after($next, ','), ',')"/></xsl:variable>
		<xsl:text><xsl:value-of select="$op"/> </xsl:text><xsl:value-of select="$lon"/><xsl:text> </xsl:text><xsl:value-of select="$lat"/>
		<xsl:call-template name="getOneCoordinate">
			<xsl:with-param name="text" select="$subsequent" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
