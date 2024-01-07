<xsl:stylesheet  xmlns="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:y="http://www.yworks.com/xml/graphml" xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Make a graph of entities linked in time order

 -->

<xsl:template match="/">
<graphml>    
	<key attr.name="id" attr.type="string" for="node" id="id"/>
    <key attr.name="url" attr.type="string" for="node" id="url"/>
    <key attr.name="text" attr.type="string" for="node" id="text"/>

	<graph>
		<xsl:apply-templates select="//event" mode="node" />
		<xsl:apply-templates select="//event" mode="edge" />
	</graph>
</graphml>
</xsl:template>


<xsl:template match="event" mode="node">
	<node id="{@id}">
		<data key="id"><xsl:value-of select="@id"/></data>
		<data key="text"><xsl:value-of select="@label"/></data>
	</node>
</xsl:template>


<xsl:template match="event" mode="edge">
	<xsl:apply-templates select="following-sibling::event[@fm &gt; current()/@to][1]" mode="link">
		<xsl:with-param name="source" select="@id"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="event" mode="link">
	<xsl:param name="source"/>
	<edge source="{$source}" target="{@id}" />
	<!-- 
	the same source node should also link to any intervals that start within this interval 
	 -->
	<xsl:apply-templates select="following-sibling::event[./@fm &gt;= current()/@fm][./@fm &lt;= current()/@to]" mode="also">
		<xsl:with-param name="source" select="$source"/>
	</xsl:apply-templates>	 
</xsl:template>

<xsl:template match="event" mode="also">
	<xsl:param name="source"/>
	<edge source="{$source}" target="{@id}" />
</xsl:template>

</xsl:stylesheet>
