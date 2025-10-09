<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

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
			<xsl:apply-templates select="//link[@fm = @to]"/>
		</table>
	</body>
</html>
</xsl:template>


<xsl:template match="link[@fm = @to]">
	<xsl:variable name="opname" select="@reason"/>
	<tr>
		<td class="op" colspan="2"><xsl:value-of select="$opname"/></td>
	</tr>
	<xsl:apply-templates select="." mode="trace"/>
	<xsl:apply-templates select="//event[./@uri = current()/@to]"/>
</xsl:template>

<xsl:template match="link" mode="trace">
	<xsl:choose>
		<xsl:when test="//link[./@to = current()/@fm and ./@fm != current()/@fm and text  = current()/text][1]">
			<xsl:apply-templates select="//link[./@to != ./@fm and ./@to = current()/@fm and ./text  = current()/text][1]" mode="trace"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="//event[./@uri = current()/@fm]"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="event">
	<tr>
		<td><datetime><xsl:value-of select="@date"/></datetime></td>
		<td><xsl:value-of select="text"/></td>
	</tr>
</xsl:template>

</xsl:stylesheet>
