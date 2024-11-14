<xsl:stylesheet version="1.0" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" encoding="UTF-8" />

<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<xsl:template match="/">
	<xsl:apply-templates select="//entity" />
</xsl:template>

<xsl:template match="entity">
	<xsl:variable name="hash">
		<xsl:call-template name="hashMD5">
			<xsl:with-param name="text" select="."/>
		</xsl:call-template>
	</xsl:variable>	
	<xsl:variable name="nodeID">
		<xsl:value-of select="concat('_:', $hash)"/>
	</xsl:variable>
	<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type&gt;'"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#Concept&gt;'"/>
	<xsl:text> .&#13;</xsl:text>
	<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#broader&gt;'"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="concat('_:', @type)"/>
	<xsl:text> .&#13;</xsl:text>
	<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="concat(&quot;'&quot;, ., &quot;'&quot;)"/>
	<xsl:text> .&#13;</xsl:text>
</xsl:template>

</xsl:stylesheet>
