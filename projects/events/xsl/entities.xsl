<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:import href="../../../xsl/extract/entities.xsl"/>

<xsl:template match="/">
<bag>
    <xsl:apply-templates select="//item"/>
</bag>
</xsl:template>


<xsl:template match="item">
	<xsl:apply-templates select="document(.)//html:span"/>
</xsl:template>


<xsl:template match="html:span[@class = 'person' or @class = 'op' or @class = 'vessel' or @class = 'polity']">
	<xsl:apply-imports/>
</xsl:template>

<xsl:template match="html:span"/>

</xsl:stylesheet>
