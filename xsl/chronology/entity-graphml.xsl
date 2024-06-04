<?xml version="1.0"?>
<xsl:stylesheet xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<!-- 
	Make GraphML. Nodes are events, edges are links between events related to a common entity. The assumption is that events
	are sorted in (increasing) time order. A link is made between an event and the next that contains the same entity.
	Edges in the graph are labelled with the name of the entity.
 -->

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<graphml:graphml>
    <graphml:key attr.name="text"   attr.type="string" for="node" id="text"/>
    <graphml:key attr.name="date"   attr.type="string" for="node" id="date"/>
    <graphml:key attr.name="tag"    attr.type="string" for="node" id="tag"/>
    <graphml:key attr.name="url"    attr.type="string" for="node" id="url"/>
    <graphml:key attr.name="source" attr.type="string" for="node" id="source"/>
    <graphml:key attr.name="entity" attr.type="string" for="edge" id="entity"/>
    <graphml:graph>
		<xsl:apply-templates select="//event" mode="node"/>
		<xsl:apply-templates select="//event" mode="edge"/>
    </graphml:graph>
</graphml:graphml>
</xsl:template>

<xsl:template match="event" mode="node">
	<graphml:node id="{@uri}">
		<xsl:apply-templates select="@source"/>
		<graphml:data key="text"><xsl:value-of select="normalize-space(text)"/></graphml:data>
		<graphml:data key="date"><xsl:value-of select="@date"/></graphml:data>
		<graphml:data key="tag"><xsl:value-of select="tag[1]"/></graphml:data>
		<graphml:data key="url"><xsl:value-of select="@uri"/></graphml:data>
	</graphml:node>
</xsl:template>


<xsl:template match="event" mode="edge">
	<xsl:apply-templates select="entity" mode="edge"/>
</xsl:template>


<xsl:template match="entity" mode="edge">
	<!-- link to the next event that contains the entity, if we haven't already -->
	<xsl:if test="not(preceding-sibling::entity[. = current()])">
		<xsl:apply-templates select="../following::entity[. = current()][1]" mode="link">
			<xsl:with-param name="source" select="../@uri"/>
		</xsl:apply-templates>
		<!-- If there is no subsequent entity, then this event links to itself -->
		<xsl:if test="not(../following::entity[. = current()][1])">
			<graphml:edge source="{../@uri}" target="{../@uri}">
				<graphml:data key="entity"><xsl:value-of select="."/></graphml:data>
			</graphml:edge>
		</xsl:if>
	</xsl:if>
</xsl:template>


<xsl:template match="entity" mode="link">
	<xsl:param name="source"/>
	<graphml:edge source="{$source}" target="{../@uri}">
		<graphml:data key="entity"><xsl:value-of select="."/></graphml:data>
	</graphml:edge>
</xsl:template>


<xsl:template match="@source">
	<graphml:data key="source"><xsl:value-of select="."/></graphml:data>
</xsl:template>


</xsl:stylesheet>
