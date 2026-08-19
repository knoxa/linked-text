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

<xsl:template match="html:article[@typeof = 'mil:intsum' or @typeof = 'mil:orders'][.//html:span[@typeof = 'btmaps:GridReference']]">
	<table>
		<tr><th>Date</th><th>Location</th><th>Ref</th><th>TNA</th></tr>
		<xsl:apply-templates select=".//html:span[@typeof = 'btmaps:GridReference']"/>
	</table>
</xsl:template>

<xsl:template match="html:*[@typeof = 'btmaps:GridReference']">
<tr>
	<td>
		<xsl:value-of select="ancestor::html:article//html:datetime/@content"/>
	</td>
	<td>
		<xsl:value-of select="@content"/>
	</td>
	<td>
		<xsl:value-of select="ancestor::html:article/*[@class = 'reference'][1]/@content"/>
	</td>
	<td>
		<xsl:value-of select="ancestor::html:article/*[@class = 'tnaref'][1]"/>
	</td>
</tr>
</xsl:template>

<xsl:template match="html:article">
</xsl:template>

</xsl:stylesheet>
