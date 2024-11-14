<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:time="http://www.w3.org/2006/time#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" exclude-result-prefixes="time rdf rdfs skos" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Extract intervals and instants from RDF/XML

 -->

<xsl:template match="/">
<temporal>    
	<xsl:apply-templates select="//time:Instant" />
	<xsl:apply-templates select="//*[@rdf:about][time:hasBeginning or time:hasEnd]" />
</temporal>
</xsl:template>


<xsl:template match="time:Instant[@rdf:about]">
	<event uri="{@rdf:about}" fm="{normalize-space(time:*)}" to="{normalize-space(time:*[1])}" type="instant" label="{skos:prefLabel|skos:altLabel|rdfs:label[1]}"/>
</xsl:template>

<xsl:template match="time:Instant">
<xsl:if test="not(preceding::time:Instant[time:inXSDDate = current()/time:inXSDDate])">
	<event uri="{generate-id()}" fm="{normalize-space(time:*[1])}" to="{normalize-space(time:*[1])}" type="instant" label="{normalize-space(.)}"/>
</xsl:if>
</xsl:template>


<xsl:template match="*[@rdf:about][time:hasBeginning or time:hasEnd]">
	<event uri="{@rdf:about}" fm="{normalize-space(time:hasBeginning/time:Instant/time:*)}" to="{normalize-space(time:hasEnd/time:Instant/time:*)}" type="interval" label="{skos:prefLabel|rdfs:label[1]}"/>
</xsl:template>


</xsl:stylesheet>
