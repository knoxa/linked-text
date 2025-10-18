<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:out="http://example.com/" xmlns:graphml="http://graphml.graphdrawing.org/xmlns" version="1.0">


<!-- 
	This is for the case where Lattice XML has been transformed into GraphML for editing.
	Make a stylesheet that operates on the original Lattice XSL and applies the edits encoded in the edited GraphML.
	The edits to the GraphML are to colour nodes and edges red.
 -->

<xsl:namespace-alias stylesheet-prefix="out" result-prefix="xsl"/>

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="graphml:graphml">

<out:stylesheet>
<out:output method="xml" encoding="utf-8" indent="yes"/>

	<out:template match="lattice">
		<out:copy>
			<out:copy-of select="@*"/>
			<out:apply-templates select="concept"/>
			<out:apply-templates select="preorder"/>
		</out:copy>
	</out:template>
	
	<out:template match="preorder">
		<out:copy>
			<out:apply-templates select="//edge"/>
		</out:copy>
	</out:template>
	
	<xsl:apply-templates select="//graphml:node"/>
	<xsl:apply-templates select="//graphml:edge"/>
	
	<out:template match="concept"/>
	<out:template match="edge"/>
</out:stylesheet>
</xsl:template>


<xsl:template match="graphml:node">
	<xsl:variable name="nodeid" select="graphml:data[@key = 'd3']"/>
	<out:template match="concept[@id = '{$nodeid}']">
		<out:copy>
			<out:copy-of select="@*"/>
			<out:copy-of select="attribute"/>
			<xsl:if test="not(.//@color = '#FF0000')">
				<out:copy-of select="object"/>
			</xsl:if>
		</out:copy>
	</out:template>	
</xsl:template>


<xsl:template match="graphml:edge">
<xsl:if test="not(.//@color = '#FF0000')">
	<xsl:variable name="source" select="//graphml:node[@id = current()/@source]/graphml:data[@key = 'd3']"/>
	<xsl:variable name="target" select="//graphml:node[@id = current()/@target]/graphml:data[@key = 'd3']"/>
	<out:template match="edge[@from = '{$source}' and @to = '{$target}']">
		<out:copy-of select="."/>
	</out:template>	
</xsl:if>
</xsl:template>

</xsl:stylesheet>
 