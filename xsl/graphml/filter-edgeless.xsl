<?xml version="1.0"?>
<xsl:stylesheet  xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<!-- Filter out graph nodes that don't have any edges -->

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="graphml:node">
	<!-- Only copy this graph node if it the source or target of at least one edge -->
	<xsl:if test="//graphml:edge[@source = current()/@id or @target = current()/@id]">
		<xsl:copy-of select="."/>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
