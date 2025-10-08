<xsl:stylesheet  xmlns="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 
Create GraphML from ordered events
 -->

<xsl:template match="/">
<graphml>    
	<key attr.name="id" attr.type="string" for="node" id="id"/>
    <key attr.name="url" attr.type="string" for="node" id="url"/>
    <key attr.name="text" attr.type="string" for="node" id="text"/>
    <key attr.name="reason" attr.type="string" for="edge" id="reason"/>
	<graph>
		<xsl:apply-templates select="//event" mode="node" />
		<xsl:apply-templates select="//link" />
	</graph>
</graphml>
</xsl:template>


<xsl:template match="event" mode="node">
	<node id="{@uri}">
		<data key="id"><xsl:value-of select="@uri"/></data>
		<data key="text"><xsl:call-template name="getLabel"/></data>
		<data key="url"><xsl:value-of select="@uri"/></data>
		<xsl:apply-templates select="entity"/>
	</node>
</xsl:template>


<xsl:template match="link">
	<edge source="{@fm}" target="{@to}" >
		<xsl:apply-templates select="@reason" mode="edge"/>
	</edge>
</xsl:template>


<xsl:template match="@reason" mode="edge">
	<data key="reason"><xsl:value-of select="."/></data>
</xsl:template>

<xsl:template name="getLabel">
	<xsl:choose>
		<xsl:when test="@label">
			<xsl:value-of select="@label"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="text"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
