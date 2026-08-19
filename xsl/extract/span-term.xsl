<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0">

<!-- 
	Make a simple list of the contents for span elements - for use in dictionary lookup.	
	The @content value, if set, is use in place of the body of the span.
 -->

<xsl:output method="text" version="1.0" encoding="UTF-8" />

<xsl:template match="/">
    <xsl:apply-templates select="//html:span"/>
</xsl:template>
 
<xsl:template match="html:span">
 	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&#13;</xsl:text>
</xsl:template>
 
<xsl:template match="html:span[@class = 'doubtful']"/>
 
<xsl:template match="html:span[@content]">
 	<xsl:value-of select="normalize-space(@content)"/>
	<xsl:text>&#13;</xsl:text>
</xsl:template>

</xsl:stylesheet>


