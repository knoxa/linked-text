<xsl:stylesheet version="1.0" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" encoding="UTF-8" />

<xsl:template match="/">
	<xsl:apply-templates select="//html:span" />
</xsl:template>

<xsl:template match="html:span">
	<xsl:apply-templates select="document(@href)" mode="extract"/>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>
