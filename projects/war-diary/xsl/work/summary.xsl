<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>


<xsl:template match="/">
<html:html>
<html:head><html:title>Work</html:title></html:head>
<html:body>
	<html:h2><xsl:copy-of select="//description"/></html:h2>
    <xsl:apply-templates select="//item"/>
</html:body>
</html:html>
</xsl:template>


<xsl:template match="item">
	<xsl:apply-templates select="document(.)//html:p[@class = 'tnaref']"/>
</xsl:template>

<xsl:template match="html:p[@class = 'tnaref'][. = 'TNA: WO 95/1487/5, p 253']">
	<xsl:copy-of select="ancestor::html:article[1]"/>
</xsl:template>

<xsl:template match="html:p"/>

</xsl:stylesheet>
