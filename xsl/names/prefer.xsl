<?xml version="1.0"?>
<xsl:stylesheet  xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xhtml" version="1.0">

<!-- 
	Make a map of surface text to preferred label from XHTML span elements that have a @content attribute.
 -->

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<map>
	<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
</map>
</xsl:template>

<xsl:template match="*|@*|comment()|processing-instruction()|text()">
	<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
</xsl:template>

<xsl:template match="xhtml:span[@content]">
	<entry key="{.}" value="{@content}"/>
</xsl:template>


</xsl:stylesheet>

