<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:time="http://www.w3.org/2006/time#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" exclude-result-prefixes="time rdf rdfs skos" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Extract intervals and instants from Owl Time RDF/XML

 -->

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//*[time:hasBeginning or time:hasEnd]" />
	<xsl:apply-templates select="//*[time:intervalEquals]" />
	<xsl:apply-templates select="/rdf:RDF/rdf:Description[time:inXSDDate]" />
</temporal>
</xsl:template>

<xsl:template match="*[time:hasBeginning or time:hasEnd]">
	<xsl:variable name="id"><xsl:call-template name="getId"/></xsl:variable>
	<event id="{$id}" fm="{normalize-space(time:hasBeginning/*/time:*)}" to="{normalize-space(time:hasEnd/*/time:*)}" label="{skos:prefLabel|rdfs:label[1]}"/>
</xsl:template>

<xsl:template match="*[time:intervalEquals]">
	<xsl:variable name="id"><xsl:call-template name="getId"/></xsl:variable>
	<event id="{$id}" fm="{normalize-space(time:intervalEquals/*/time:*[1])}" to="{normalize-space(time:intervalEquals/*/time:*[last()])}" label="{skos:prefLabel|rdfs:label[1]}"/>
</xsl:template>

<xsl:template match="*[time:inXSDDate]">
	<event id="{generate-id()}" fm="{normalize-space(time:*[1])}" to="{normalize-space(time:*[1])}" label="{skos:prefLabel|rdfs:label[1]}"/>
</xsl:template>


<xsl:template name="getId">
	<xsl:choose>
		<xsl:when test="@rdf:about">
			<xsl:value-of select="@rdf:about"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="generate-id()"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


</xsl:stylesheet>
