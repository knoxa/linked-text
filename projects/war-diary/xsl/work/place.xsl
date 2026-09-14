<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html>
<head>
<title>Work</title>
<style type="text/css">
table, th, td {
	border: 1px solid;
	border-collapse: collapse;
	padding: 5px;
}
td {
	vertical-align: top;
}

</style>
</head>
<body>
	<h2><xsl:copy-of select="//description"/></h2>
    <xsl:apply-templates select="//item"/>
</body>
</html>
</xsl:template>

<xsl:template match="item">
<div about="{.}">
	<p><xsl:value-of select="."/></p>
	<xsl:apply-templates select="document(.)//html:article"/>
</div>
</xsl:template>

<xsl:template match="html:article">
	<table>
		<tr><th>outer</th><th>inner</th><th>TNA</th></tr>
		<xsl:apply-templates select=".//html:span[@class = 'place']"/>
		<xsl:apply-templates select=".//html:span[@typeof = 'btmaps:GridReference']"/>
	</table>
	<br/>
</xsl:template>

<xsl:template match="html:span[@class = 'place'][html:span[@class = 'place']]">
	<xsl:apply-templates select="html:span[@typeof = 'btmaps:GridReference']" mode ="place">
		<xsl:with-param name="place" select="."/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="html:span[@class = 'place']|html:span[@typeof = 'btmaps:GridReference']">
	<xsl:variable name="place">
		<xsl:choose>
			<xsl:when test="@content">
				<xsl:value-of select="normalize-space(@content)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="normalize-space(.)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:apply-templates select="ancestor::html:span[@class = 'place']" mode ="place">
		<xsl:with-param name="place" select="$place"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="html:span[@class = 'place']" mode="place">
<tr>
	<xsl:param name="place"/>
	<td><xsl:value-of select="."/></td>
	<td><xsl:value-of select="$place"/></td>
	<td><xsl:value-of select="ancestor::html:article/*[@class = 'tnaref'][1]"/></td>
</tr>
</xsl:template>

<xsl:template match="html:span"/>

</xsl:stylesheet>
