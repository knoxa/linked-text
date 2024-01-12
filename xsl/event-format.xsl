<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:time="http://www.w3.org/2006/time#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" exclude-result-prefixes="time rdf rdfs skos" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Extract intervals and instants from RDF/XML

 -->

<xsl:template match="/">
<temporal>    
	<xsl:apply-templates select="//time:Instant[@rdf:about]" />
	<xsl:apply-templates select="//*[@rdf:about][time:hasBeginning or time:hasEnd]" />
</temporal>
</xsl:template>


<xsl:template match="time:Instant[@rdf:about]">
	<event uri="{@rdf:about}" fm="{normalize-space(time:inXSDDate[1])}" to="{normalize-space(time:inXSDDate[1])}" type="instant" label="{skos:prefLabel|rdfs:label[1]}"/>
</xsl:template>


<xsl:template match="*[@rdf:about][time:hasBeginning or time:hasEnd]">
	<event uri="{@rdf:about}" fm="{normalize-space(time:hasBeginning)}" to="{normalize-space(time:hasEnd)}" type="interval" label="{skos:prefLabel|rdfs:label[1]}"/>
</xsl:template>


</xsl:stylesheet>
