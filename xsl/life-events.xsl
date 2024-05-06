<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

<!-- 
	Make GraphML 
 -->

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<graphml:graphml>
	<graphml:key attr.name="url"    attr.type="string" for="node" id="url"/>
    <graphml:key attr.name="text"   attr.type="string" for="node" id="text"/>
    <graphml:key attr.name="status" attr.type="string" for="node" id="status"/>
    <graphml:key attr.name="entity" attr.type="string" for="edge" id="entity"/>
    <graphml:graph>
		<xsl:apply-templates select="//graphml:node" />
		<xsl:apply-templates select="//graphml:edge" />
    </graphml:graph>
</graphml:graphml>
</xsl:template>

<xsl:template match="graphml:node">
	<graphml:node id="{concat(@id, 'B')}">
		<graphml:data key="text"><xsl:value-of select="concat('The birth of ', graphml:data[@key = 'd3'])"/></graphml:data>
	</graphml:node>
	<graphml:node id="{concat(@id, 'D')}">
		<graphml:data key="text"><xsl:value-of select="concat('The death of ', graphml:data[@key = 'd3'])"/></graphml:data>
	</graphml:node>
	<graphml:edge source="{concat(@id, 'B')}" target="{concat(@id, 'D')}">
		<graphml:data key="entity"><xsl:value-of select="graphml:data[@key = 'd3']"/></graphml:data>
	</graphml:edge>
</xsl:template>


<xsl:template match="graphml:edge">
	<graphml:edge source="{concat(@source, 'B')}" target="{concat(@target, 'B')}">
	</graphml:edge>
</xsl:template>

</xsl:stylesheet>
