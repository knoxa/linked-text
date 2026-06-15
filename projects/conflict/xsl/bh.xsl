<?xml version="1.0"?>
<xsl:stylesheet xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="skos" version="1.0">

<xsl:output method="xml" encoding="UTF-8"/>
<xsl:import href="label.xsl"/>

<xsl:template match="/">
<map description="KEY is battle, VALUE is battle honour">
	<xsl:apply-templates select="//skos:related"/>
</map>
</xsl:template>

<xsl:template match="skos:related">
	<xsl:variable name="key">
		<xsl:apply-templates select=".." mode="label"/>
	</xsl:variable>
	<xsl:variable name="value">
		<xsl:apply-templates select="*[1]" mode="label"/>
	</xsl:variable>
	<entry key="{$key}" value="{$value}"/>
</xsl:template>

</xsl:stylesheet>
