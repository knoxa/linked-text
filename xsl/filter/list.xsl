<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" encoding="utf-8" />

<xsl:template match="/">
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="*">
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="html:span[@content]">
	<xsl:value-of select="@content"/>
	<xsl:text>&#10;</xsl:text>
</xsl:template>

</xsl:stylesheet>
