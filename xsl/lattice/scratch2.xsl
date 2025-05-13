<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt" version="1.0">

<xsl:import href="concept.xsl"/>
<xsl:import href="lattice.xsl"/>

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="//extent"/>
</context>
</xsl:template>

<xsl:template match="extent[attribute = 'cruiser']">
	<xsl:variable name="fromHere">
		<xsl:call-template name="makeDownPath"/>
	</xsl:variable>
	<xsl:variable name="fromThere">
		<xsl:for-each select="//extent[attribute = 'German']">
			<xsl:call-template name="makeDownPath"/>
		</xsl:for-each>
	</xsl:variable>
	<path id="{@id}">
		<xsl:copy-of select="attribute"/>
		<xsl:copy-of select="$fromHere"/>
	</path>
	<xsl:variable name="meet">
		<xsl:call-template name="getMeet">
			<xsl:with-param name="setA" select="$fromHere"/>
			<xsl:with-param name="setB" select="$fromThere"/>
		</xsl:call-template>
	</xsl:variable>
	<MEET id="{$meet}"/>
	<xsl:apply-templates select="//extent[@id = $meet]" mode="copy"/>
</xsl:template>


<xsl:template match="extent" mode="copy">
	<xsl:copy-of select="."/>
	<xsl:call-template name="getConceptAttributes"/>
	<xsl:call-template name="getConceptObjects"/>
</xsl:template>


<xsl:template match="extent"/>

</xsl:stylesheet>
