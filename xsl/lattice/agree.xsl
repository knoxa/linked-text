<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="concept.xsl"/>

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="extent"/>
</context>
</xsl:template>

<xsl:template match="extent">
<xsl:if test="count(object) = 1">
	<object name="{object[1]}">
		<xsl:call-template name="getConceptAttributes"/>
	</object>
</xsl:if>
</xsl:template>

</xsl:stylesheet>
