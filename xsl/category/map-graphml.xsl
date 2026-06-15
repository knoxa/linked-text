<xsl:stylesheet  xmlns="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Make a graph of events linked in time order. Input events must have been sorted in time order.

 -->

<xsl:template match="/">
<graphml>    
	<key attr.name="id" attr.type="string" for="node" id="id"/>
    <key attr.name="text" attr.type="string" for="node" id="text"/>
	<graph>
		<xsl:apply-templates select="//@*" mode="node" />
		<xsl:apply-templates select="//entry" mode="edge" />
	</graph>
</graphml>
</xsl:template>


<xsl:template match="@*" mode="node">
	<node id="{.}">
		<data key="id"><xsl:value-of select="."/></data>
		<data key="text"><xsl:value-of select="."/></data>
	</node>
</xsl:template>

<xsl:template match="@*[preceding::@*[. = current()]]" mode="node"/>

<xsl:template match="entry" mode="edge">
	<edge source="{@key}" target="{@value}" />
</xsl:template>

<xsl:template match="entry[preceding::entry[@key = current()/@key][@value = current()/@value]]" mode="edge"/>

</xsl:stylesheet>
