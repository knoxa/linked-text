<xsl:stylesheet  xmlns="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Make a graph of events linked in time order

 -->

<xsl:template match="/">
<graphml>    
	<key attr.name="id" attr.type="string" for="node" id="id"/>
    <key attr.name="url" attr.type="string" for="node" id="url"/>
    <key attr.name="text" attr.type="string" for="node" id="text"/>

	<graph>
		<xsl:apply-templates select="//event" mode="node" />
		<xsl:apply-templates select="//event" mode="edge" />
		<xsl:apply-templates select="//link" />
	</graph>
</graphml>
</xsl:template>


<xsl:template match="event" mode="node">
	<node id="{@uri}">
		<data key="id"><xsl:value-of select="@uri"/></data>
		<data key="text"><xsl:value-of select="text"/></data>
		<data key="url"><xsl:value-of select="@uri"/></data>
	</node>
</xsl:template>


<xsl:template match="event" mode="edge">
	<xsl:apply-templates select="following-sibling::event[interval[1]/@fm &gt; current()/interval[1]/@to][1]" mode="link">
		<xsl:with-param name="source" select="@uri"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="event" mode="link">
	<xsl:param name="source"/>
	<edge source="{$source}" target="{@uri}" />
	<!-- 
	the same source node should also link to any intervals that start within this interval 
	 -->
	<xsl:apply-templates select="following-sibling::event[./interval[1]/@fm &gt;= current()/interval[1]/@fm][./interval[1]/@fm &lt;= current()/interval[1]/@to]" mode="also">
		<xsl:with-param name="source" select="$source"/>
	</xsl:apply-templates>	 
</xsl:template>

<xsl:template match="event" mode="also">
	<xsl:param name="source"/>
	<edge source="{$source}" target="{@uri}" />
</xsl:template>


<xsl:template match="link">
	<edge source="{@fm}" target="{@to}" />
</xsl:template>

</xsl:stylesheet>
