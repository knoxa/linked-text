<?xml version="1.0"?>
<xsl:stylesheet xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
	Filter out duplicate edges
 -->

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>


<!-- 
	Remove unwanted edges from the graph
 -->
<xsl:template match="graphml:edge[@source = @target]">
	<!--  a self edge - do nothing  -->
</xsl:template>

<xsl:template match="graphml:edge">
	<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
