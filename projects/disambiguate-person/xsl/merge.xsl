<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<context>
    <xsl:apply-templates select="//item"/>
</context>
</xsl:template>

<xsl:template match="item">
	<xsl:copy-of select="document(.)//object"/>
</xsl:template>


</xsl:stylesheet>
