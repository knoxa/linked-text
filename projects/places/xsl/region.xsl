<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html>
	<head>
		<title>Hypotheses</title>
	</head>
	<body>
		<ul>
		    <xsl:apply-templates select="//object"/>
		</ul>
	</body>
</html>
</xsl:template>

<xsl:template match="object">
	<xsl:variable name="objectName" select="attribute[1]"/>
	<xsl:apply-templates select="attribute" mode="makeObject">
		<xsl:with-param name="region" select="$objectName"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="attribute" mode="makeObject">
	<xsl:param name="region"/>
	<xsl:variable name="relation">
		<xsl:choose>
			<xsl:when test="contains(., ' AND ')">
				<xsl:value-of select="' are places in '"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="' is a place in '"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<li class="claim">
		<xsl:value-of select="."/><xsl:value-of select="$relation"/><xsl:value-of select="$region"/><xsl:text>.</xsl:text>
	</li>
</xsl:template>

</xsl:stylesheet>
