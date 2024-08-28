<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="text" encoding="utf-8" />

<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/rdfa-ntriples.xsl"/>

<xsl:template match="/">
	<xsl:apply-imports/>
	<xsl:apply-templates select="//*[@typeof = 'ies:State']" mode="label"/>
</xsl:template>

<xsl:template match="*" mode="label">
	<xsl:call-template name="callExpandIRI">
		<xsl:with-param name="element" select="."/>
	</xsl:call-template>
	<xsl:text> </xsl:text>
	<xsl:value-of select="concat('&lt;', 'http://www.w3.org/2000/01/rdf-schema#label', '&gt;')"/>
	<xsl:text> </xsl:text>
	<xsl:text>&quot;</xsl:text>
	<xsl:call-template name="escapeQuotes">
		<xsl:with-param name="text" select="normalize-space(.)"/>
	</xsl:call-template>
	<xsl:text>&quot;</xsl:text>
	<xsl:text> .&#13;</xsl:text>
</xsl:template>

</xsl:stylesheet>
