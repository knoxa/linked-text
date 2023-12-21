<?xml version="1.0"?>
<xsl:stylesheet xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- 
	Clean up family tree ... 
 -->

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>


<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="graphml:node[graphml:data[@key = 'text'] = '?']">
	<xsl:message><xsl:value-of select="@id"/> - need to check node - <xsl:value-of select="graphml:data[@key = 'text'][1]"/> - <xsl:value-of select="//graphml:edge[./@source = current()/@id][1]/@target"/></xsl:message>
	
	<xsl:copy>
		<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
		<xsl:variable name="children" select="count(//graphml:edge[./@source = current()/@id])"/>
		<xsl:choose>
			<xsl:when test="$children = 1">
				<xsl:apply-templates select="//graphml:edge[./@target = current()/@id]" mode="findstart">
					<xsl:with-param name="target" select="//graphml:edge[./@source = current()/@id][1]/@target"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$children = 2">
				<xsl:apply-templates select="//graphml:node" mode="findparent">
					<xsl:with-param name="child1" select="//graphml:edge[./@source = current()/@id][1]/@target"/>
					<xsl:with-param name="child2" select="//graphml:edge[./@source = current()/@id][2]/@target"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>ERROR: An unknown node has <xsl:value-of select="$children"/> children.</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:copy>
</xsl:template>


<xsl:template match="graphml:edge" mode="findstart">
	<xsl:param name="target"/>	
	<xsl:message>Starting at: <xsl:value-of select="//graphml:node[./@id = current()/@source][1]/graphml:data[@key = 'text'][1]"/> - <xsl:value-of select="$target"/></xsl:message>

 	<xsl:apply-templates select="//graphml:edge[./@source = current()/@source]" mode="findpaths">
		<xsl:with-param name="target" select="$target"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="graphml:edge" mode="findpaths">
	<xsl:param name="target"/>	
	<xsl:message>...step  <xsl:value-of select="$target"/> - <xsl:value-of select="@target"/> - <xsl:value-of select="//graphml:node[./@id = current()/@target][1]/graphml:data[@key = 'text'][1]"/></xsl:message>
	<xsl:if test="@target = $target">
	</xsl:if>
	<xsl:choose>
		<xsl:when test="@target = $target">
			<graphml:data key="status"><xsl:value-of select="'unwanted'"/></graphml:data>
		</xsl:when>
		<xsl:when test="//graphml:node[./@id = current()/@target][1]/graphml:data[@key = 'text'][1] = '?'">
			<xsl:message>stop at unknown node</xsl:message>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="//graphml:edge[./@source = current()/@target]" mode="findpaths">
				<xsl:with-param name="target" select="$target"/>
			</xsl:apply-templates>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="graphml:node" mode="findparent">
	<xsl:param name="child1"/>
	<xsl:param name="child2"/>
	<xsl:if test="//graphml:edge[./@source = current()/@id and ./@target = $child1] and //graphml:edge[./@source = current()/@id and ./@target = $child2]">
			<graphml:data key="status"><xsl:value-of select="'unwanted'"/></graphml:data>
	</xsl:if>
</xsl:template>

<xsl:template match="graphml:node[graphml:data[@key = 'text'][1] = '?']" mode="findparent">
</xsl:template>


<!-- filter out duplicate edges -->
<xsl:template match="graphml:edge[preceding::graphml:edge[./@source = current()/@source and ./@target = current()/@target]]">
	<xsl:message>removing duplicate edge</xsl:message>
</xsl:template>

</xsl:stylesheet>
