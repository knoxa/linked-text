<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Create a timeline for each entity.
Events that are about more than one entity are copied into more than one timeline.

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
	<timeline name="{.}">
		<xsl:copy-of select="//event[entity = current()]"/>
	</timeline>
</xsl:template>


</xsl:stylesheet>
