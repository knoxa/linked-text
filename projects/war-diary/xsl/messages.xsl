<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="html" encoding="UTF-8" indent="no"/>

<xsl:template match="/">
<html>
	<head><title>Messages</title></head>
	<body>
		<table>
			<tr><th>No</th><th>Datetime</th><th>Place</th><th>From</th><th>To</th><th>Ref</th><th>Reply</th><th>TNA Ref</th></tr>
			<xsl:apply-templates select="//html:table[@class = 'footer']//html:time">
				<xsl:sort select="@datetime" order="ascending"/>
			</xsl:apply-templates>
		</table>
	</body>
</html>
</xsl:template>

<xsl:template match="html:time">
<tr>
	<td><xsl:value-of select="position()"/><xsl:text>.</xsl:text></td>
	<td><xsl:value-of select="@datetime"/></td>
	<xsl:apply-templates select="ancestor::html:table[1]" mode="footer"/>
	<td><xsl:value-of select="ancestor::html:article[1]/html:p[@class = 'tnaref']"/></td>
</tr>
</xsl:template>

<xsl:template match="html:table" mode="footer">
	<td><xsl:apply-templates select="html:tr[2]/html:td[2]" mode="value"/></td>
	<td><xsl:apply-templates select="html:tr[1]/html:td[2]" mode="value"/></td>
	<xsl:apply-templates select="../html:table[@class = 'header'][1]" mode="header"/>
</xsl:template>

<xsl:template match="html:table" mode="header">
	<td><xsl:apply-templates select=".//html:*[@typeof = 'mil:unit'][1]" mode="value"/></td>
	<td><xsl:apply-templates select="html:tr[2]/html:td[1]" mode="sender"/></td>
	<td><xsl:apply-templates select="html:tr[2]/html:td[3]" mode="sender"/></td>
</xsl:template>

<xsl:template match="html:*" mode="value">
	<xsl:choose>
		<xsl:when test="@content">
			<xsl:value-of select="@content"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="normalize-space(.)"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="html:*" mode="sender">
	<xsl:apply-templates select="html:*|text()" mode="sender"/>
</xsl:template>

<xsl:template match="html:*[@class = 'formfld']" mode="sender"/>

<xsl:template match="text()" mode="sender">
	<xsl:value-of select="."/>
</xsl:template>

</xsl:stylesheet>
