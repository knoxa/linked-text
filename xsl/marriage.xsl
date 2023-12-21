<?xml version="1.0"?>
<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:graphml="http://graphml.graphdrawing.org/xmlns" xmlns:time="http://www.w3.org/2006/time#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="html">

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
		<xsl:apply-templates select="//html:*[@class = 'marriage']" mode="node"/>
		<xsl:apply-templates select="//html:*[@class = 'marriage']" mode="edge"/>
    </graphml:graph>
</graphml:graphml>
</xsl:template>

<xsl:template match="html:*[@class = 'marriage']" mode="node">
	<graphml:node id="{../@about}" typeof="time:Interval">
		<graphml:data key="text" property="rdfs:label"><xsl:value-of select=".."/></graphml:data>
	</graphml:node>
</xsl:template>


<xsl:template match="html:*[@class = 'marriage']" mode="edge">
	<xsl:variable name="source" select="../@about"/>
	<xsl:for-each select="../html:*[@class = 'person']">
		<xsl:apply-templates select="following::html:*[@class = 'marriage']" mode="link">
			<xsl:with-param name="source" select="$source"/>
			<xsl:with-param name="person" select="."/>
		</xsl:apply-templates>
	</xsl:for-each>
</xsl:template>


<xsl:template match="html:*[@class = 'marriage']" mode="link">
	<xsl:param name="source"/>
	<xsl:param name="person"/>
	<xsl:message><xsl:value-of select="$person"/></xsl:message>
	<xsl:if test="../html:*[@class = 'person'][. = $person] and not($source = ../@about)">
		<graphml:edge source="{$source}" target="{../@about}">
		</graphml:edge>
	</xsl:if>
</xsl:template>


<xsl:template match="*" mode="node"/>
<xsl:template match="*" mode="edge"/>

</xsl:stylesheet>
