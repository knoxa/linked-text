<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
	  <xsl:apply-templates select="temporal"/>
</xsl:template>

<xsl:template match="temporal">
<xsl:copy>
	<xsl:apply-templates select="event">
		<xsl:sort select="interval[1]/@fm" data-type="number" order="ascending"/>
		<xsl:sort select="interval[1]/@to" data-type="number" order="ascending"/>
	</xsl:apply-templates>
	<xsl:copy-of select="link"/>
</xsl:copy>
</xsl:template>

<xsl:template match="event">
	<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
