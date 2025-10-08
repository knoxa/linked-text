<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Partition events by entity.

 -->

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="temporal">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates select="//entity" />
	</xsl:copy>
</xsl:template>

<xsl:template match="entity"/>

<xsl:template match="entity[not(preceding::entity[. = current()])]">
	<partition name="{.}">
		<xsl:copy-of select="//event[entity = current()]"/>
	</partition>
</xsl:template>


</xsl:stylesheet>
