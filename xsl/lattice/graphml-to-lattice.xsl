<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:graphml="http://graphml.graphdrawing.org/xmlns" version="1.0">

<xsl:namespace-alias stylesheet-prefix="out" result-prefix="xsl"/>

<xsl:output method="xml" encoding="utf-8" indent="yes"/>


<xsl:template match="graphml:graphml">
<lattice>
	<xsl:apply-templates select="//graphml:node"/>
	<preorder>
		<xsl:apply-templates select="//graphml:edge"/>
	</preorder>
</lattice>
</xsl:template>


<xsl:template match="graphml:node">
	<xsl:variable name="nodeid" select="graphml:data[@key = 'd3']"/>
	<extent id="{$nodeid}"/>
</xsl:template>


<xsl:template match="graphml:edge">
	<xsl:variable name="source" select="//graphml:node[@id = current()/@source]/graphml:data[@key = 'd3']"/>
	<xsl:variable name="target" select="//graphml:node[@id = current()/@target]/graphml:data[@key = 'd3']"/>
	<edge from="{$source}" to="{$target}"/>
</xsl:template>

</xsl:stylesheet>
 