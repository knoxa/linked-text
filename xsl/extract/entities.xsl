<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<!-- 
	Extract a set of html:span elements of type 'place'
 -->

<xsl:import href="span-entity.xsl"/>

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/">
<bag>
	<xsl:apply-templates select="//html:span[@class]"/>
	<xsl:apply-templates select="//html:p[@class = 'tnaref']"/>
</bag>
</xsl:template>

<xsl:template match="html:span|html:p">
	<xsl:call-template name="getSpanAsEntity"/>
</xsl:template>


</xsl:stylesheet>
