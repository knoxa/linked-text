<xsl:stylesheet  xmlns="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:y="http://www.yworks.com/xml/graphml" xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Make a graph of entities linked by the ies:isPartOf relationship

 -->

<xsl:template match="/">
<graphml>    
	<key attr.name="id" attr.type="string" for="node" id="id"/>
    <key attr.name="url" attr.type="string" for="node" id="url"/>
    <key attr.name="text" attr.type="string" for="node" id="text"/>

	<graph>
		<xsl:apply-templates select="//*[@rdf:about]" mode="node" />
		<xsl:apply-templates select="//ies:isPartOf" mode="edge" />
	</graph>
</graphml>
</xsl:template>


<xsl:template match="*[@rdf:about]" mode="node">
	<node id="{@rdf:about}">
		<data key="id"><xsl:value-of select="@rdf:about"/></data>
		<data key="text"><xsl:value-of select="./skos:prefLabel"/></data>
	</node>
</xsl:template>


<xsl:template match="ies:isPartOf" mode="edge">
	<xsl:variable name="source" select="ancestor::*[@rdf:about][1]/@rdf:about"/>
	<xsl:variable name="target">
		<xsl:choose>
			<xsl:when test="@rdf:resource">
				<xsl:value-of select="@rdf:resource"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="./*[@rdf:about][1]/@rdf:about"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<edge id="{generate-id()}" source="{$source}" target="{$target}"/>
</xsl:template>


</xsl:stylesheet>
