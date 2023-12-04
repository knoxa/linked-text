<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:template name="getArgument">
	<xsl:apply-templates select="." mode="text"/>
</xsl:template>

<xsl:template match="html:span[@content]" mode="text">
<!-- 
<xsl:message><xsl:value-of select="ancestor::html:article[1]//html:*[@class = 'name'][. = current()/@content]/.."/></xsl:message>
<xsl:message>rewriting...</xsl:message>
 -->
	<xsl:value-of select="@content"/>
</xsl:template>

<xsl:template match="*" mode="text">
	<xsl:apply-templates select="*|text()" mode="text"/>
</xsl:template>

<xsl:template match="text()" mode="text">
	<xsl:value-of select="translate(., '.', '')"/>
</xsl:template>

</xsl:stylesheet>
