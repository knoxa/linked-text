<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/">
<bag>
	<xsl:apply-templates select="//entity"/>
</bag>
</xsl:template>

<xsl:template match="entity">
	<entry key="{normalize-space(.)}" value="{@type}"/>
</xsl:template>


</xsl:stylesheet>
