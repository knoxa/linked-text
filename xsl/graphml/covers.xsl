<?xml version="1.0"?>
<xsl:stylesheet xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<xsl:param name="maxpath" select="'10'"/>

<!--
	The input must be a directed acyclic graph representing a partially order set. This stylesheet removes any edges from the graph that 
	aren't covering relations.
 -->

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>


<!-- 
	Remove unwanted edges ...
 -->
<xsl:template match="graphml:edge">
			<!-- 
				delete this edge if there is also a path (two or more edges) between this source and target
			 -->
			 <xsl:variable name="path">
				 <xsl:apply-templates select="//graphml:edge[./@source != current()/@source and ./@target = current()/@target]" mode="trace">
				 	<xsl:with-param name="source" select="@source"/>
				 	<xsl:with-param name="count"  select="number(0)"/>
				 </xsl:apply-templates>
			 </xsl:variable>
			 <xsl:choose>
				 <xsl:when test="contains($path, 'FOUND')">
				 	<!-- path found - do nothing -->
				 </xsl:when>
				 <xsl:otherwise>
				 	<!-- keep this edge -->
					<xsl:copy-of select="."/>
				 </xsl:otherwise>
			 </xsl:choose>
</xsl:template>


<!-- 
	Search recursively back through incoming links to find the source node specified
 -->
<xsl:template match="graphml:edge" mode="trace">
	<xsl:param name="source"/>
	<xsl:param name="count"/>
	<xsl:choose>
		<xsl:when test="./@source = $source">
			<xsl:value-of select="'FOUND'"/>
		</xsl:when>
		<xsl:when test="$count &gt; $maxpath">
			<xsl:value-of select="'TIMEOUT'"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="//graphml:edge[./@target = current()/@source]" mode="trace">
			 	<xsl:with-param name="source" select="$source"/>
			 	<xsl:with-param name="count"  select="$count + 1"/>
			</xsl:apply-templates>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
