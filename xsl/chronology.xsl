<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="rewrite.xsl"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//html:article"/>
</temporal>
</xsl:template>

<xsl:template match="html:article">
	<xsl:apply-templates select=".//html:*[@class = 'claim']">
		<xsl:with-param name="posn" select="position()"/>
	</xsl:apply-templates>
</xsl:template>

<!-- 
<xsl:template match="html:*[@class = 'claim'][contains(., 'consul')]">
 -->

<xsl:template match="html:*[@class = 'claim'][contains(., 'consul') or contains(., 'birth') or contains(., 'death') or contains(., 'emperor')]">
	<xsl:param name="posn"/>
	<event id="{generate-id()}" fm="{$posn}" to="{$posn}" type="interval" label="{normalize-space(.)}"/>
</xsl:template>

<xsl:template match="html:*"/>

</xsl:stylesheet>
