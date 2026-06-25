<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="html" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:import href="../../../xsl/names/prefer.xsl"/>

<xsl:template match="/">
<temporal>
    <xsl:apply-templates select="//item"/>
</temporal>
</xsl:template>


<xsl:template match="item">
	<xsl:apply-templates select="document(.)/*" />
</xsl:template>


</xsl:stylesheet>
