<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:time="http://www.w3.org/2006/time#" xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0">

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
	<xsl:variable name="instant">
		<xsl:apply-templates select="time:inXSDDate[1]" mode="comparable" />
	</xsl:variable>
	<event id="{@rdf:about}" fm="{$instant}" to="{$instant}" type="instant" label="{skos:prefLabel|rdfs:label[1]}" />
</xsl:template>



<xsl:template match="*[@rdf:about][time:hasBeginning or time:hasEnd]">
	<xsl:variable name="fm">
		<xsl:apply-templates select="time:hasBeginning" mode="comparable" />
	</xsl:variable>
	<xsl:variable name="to">
		<xsl:apply-templates select="time:hasEnd" mode="comparable" />
	</xsl:variable>
	<event id="{@rdf:about}" fm="{$fm}" to="{$to}" type="interval" label="{skos:prefLabel|rdfs:label[1]}" />
</xsl:template>


<xsl:template match="*" mode="comparable">
	<!-- 
		Taking the '-' characters out of a YYYY-MM-DD format date gives an 8 digit number that preserves the date order. 
		However, we might get 'YYYY-MM', or just 'YYYY', so we append '0000' and take the first 8 digits. We then always have
		8 digit numbers to compare.
	 -->
	<xsl:variable name="temp" select="concat(translate(normalize-space(.), '-', ''), '0000')"/>
	<xsl:value-of select="number(substring($temp, 0, 9))"/>
</xsl:template>

</xsl:stylesheet>
