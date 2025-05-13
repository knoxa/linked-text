<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt" version="1.0">

<xsl:import href="concept.xsl"/>
<xsl:import href="lattice.xsl"/>

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:variable name="meet">
		<xsl:call-template name="getMeet">
			<xsl:with-param name="nodeA" select="//extent[attribute = 'Russian']"/>
			<xsl:with-param name="nodeB" select="//extent[attribute = 'hospital ship']"/>
		</xsl:call-template>
	</xsl:variable>
	<MEET id="{$meet}"/>
	<concept>
		<xsl:apply-templates select="//extent[@id = $meet]" mode="copy"/>
	</concept>
	<xsl:variable name="join">
		<xsl:call-template name="getJoin">
			<xsl:with-param name="nodeA" select="//extent[attribute = 'mine layer']"/>
			<xsl:with-param name="nodeB" select="//extent[attribute = 'warship']"/>
		</xsl:call-template>
	</xsl:variable>
	<JOIN id="{$join}"/>
	<concept>
		<xsl:apply-templates select="//extent[@id = $join]" mode="copy"/>
	</concept>
</context>
</xsl:template>

<xsl:template match="extent" mode="copy">
<ID id="{@id}"/>
	<xsl:call-template name="getConceptAttributes"/>
	<xsl:call-template name="getConceptObjects"/>
</xsl:template>


<xsl:template match="extent"/>

</xsl:stylesheet>
