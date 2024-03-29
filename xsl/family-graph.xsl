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
		<xsl:apply-templates select="//html:*[@class = 'parent']" mode="node"/>
		<xsl:apply-templates select="//html:*[@class = 'child']" mode="node"/>
		<xsl:apply-templates select="//html:*[@class = 'parent']" mode="edge"/>
    </graphml:graph>
</graphml:graphml>
</xsl:template>

<xsl:template match="html:*[@class = 'parent' or @class = 'child']" mode="node">
	<xsl:if test="not(preceding::html:*[@class = 'parent' or @class = 'child'][./@about = current()/@about])">
		<graphml:node id="{@about}">
			<graphml:data key="url"><xsl:value-of select="concat('https://en.wikipedia.org/?search=', normalize-space(.))"/></graphml:data>
			<graphml:data key="text"><xsl:value-of select="."/></graphml:data>
		</graphml:node>
	</xsl:if>
</xsl:template>


<xsl:template match="html:*[@class = 'parent']" mode="edge">
	<graphml:edge source="{@about}" target="{../html:*[@class = 'child'][1]/@about}">
		<graphml:data key="entity"><xsl:value-of select=".."/></graphml:data>
	</graphml:edge>
</xsl:template>


<xsl:template match="*" mode="node"/>
<xsl:template match="*" mode="edge"/>

</xsl:stylesheet>
