<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:kml="http://www.opengis.net/kml/2.2" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<map>
<xsl:comment>From Google Earth ...</xsl:comment>
    <xsl:apply-templates select="//kml:Placemark"/>
    <xsl:message><xsl:value-of select="count(//article)"/></xsl:message>
</map>
</xsl:template>

<xsl:template match="kml:Placemark">
	<xsl:variable name="value">
		<xsl:choose>
			<xsl:when test="contains(kml:name, ',')">
				<xsl:value-of select="substring-before(kml:name, ',')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="kml:name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<entry key="{$value}" value="{kml:name}"/>
</xsl:template>

</xsl:stylesheet>

