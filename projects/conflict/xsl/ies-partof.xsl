<?xml version="1.0"?>
<xsl:stylesheet xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="ies skos rdf" version="1.0">

<xsl:output method="xml" encoding="UTF-8"/>
<xsl:import href="label.xsl"/>

<xsl:template match="/">
<map description="KEY is part of VALUE">
	<xsl:apply-templates select="//ies:isPartOf"/>
</map>
</xsl:template>

<xsl:template match="ies:isPartOf">
	<xsl:variable name="key">
		<xsl:apply-templates select=".." mode="label"/>
	</xsl:variable>
	<xsl:variable name="value">
		<xsl:apply-templates select="//*[@rdf:about = current()/*/@rdf:about[1]]" mode="label"/>
	</xsl:variable>
	<entry key="{$key}" value="{$value}"/>
</xsl:template>

<xsl:template match="ies:isPartOf[@rdf:resource]">
	<xsl:variable name="key">
		<xsl:apply-templates select=".." mode="label"/>
	</xsl:variable>
	<xsl:variable name="value">
		<xsl:apply-templates select="//*[@rdf:about = current()/@rdf:resource]" mode="label"/>
	</xsl:variable>
	<entry key="{$key}" value="{$value}"/>
</xsl:template>

</xsl:stylesheet>
