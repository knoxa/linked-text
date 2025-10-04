<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="graphml">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>


<xsl:template match="/">
<html>
	<head>
		<title>WW1 Ops</title>
		<style>
		.op {
			font-weight: bold;
			padding-top: 5px;
		}
		datetime {
			font-style: italic;
			padding-right: 5px;
		}
		</style>
	</head>
	<body>
		<h1>Principle Events 1914-1918: Military Operations</h1>
		<table>
			<xsl:apply-templates select="//graphml:edge[@source = @target]"/>
		</table>
	</body>
</html>
</xsl:template>


<xsl:template match="graphml:edge[@source = @target]">
	<xsl:variable name="opname" select="graphml:data[@key = 'entity']"/>
	<td class="op" colspan="2"><xsl:value-of select="$opname"/></td>
	<xsl:apply-templates select="." mode="trace"/>
	<xsl:apply-templates select="//graphml:node[./@id = current()/@target]"/>
</xsl:template>

<xsl:template match="graphml:edge" mode="trace">
	<xsl:choose>
		<xsl:when test="//graphml:edge[./@target = current()/@source and ./@source != current()/@source and ./graphml:data[@key = 'entity']  = current()/graphml:data[@key = 'entity']][1]">
			<xsl:apply-templates select="//graphml:edge[./@target != ./@source and ./@target = current()/@source and ./graphml:data[@key = 'entity']  = current()/graphml:data[@key = 'entity']][1]" mode="trace"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="//graphml:node[./@id = current()/@source]"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="graphml:node">
	<tr>
		<td><datetime><xsl:value-of select="graphml:data[@key = 'date']"/></datetime></td>
		<td><xsl:value-of select="graphml:data[@key = 'text']"/></td>
	</tr>
</xsl:template>

</xsl:stylesheet>
