<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:time="http://www.w3.org/2006/time#" xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="chronology/make-sortable.xsl"/>

<xsl:template match="/">
<map>
	<xsl:apply-templates select="//rdf:Description[ies:isPartof][skos:broader]"/>
</map>
</xsl:template>


<xsl:template match="rdf:Description">
	<xsl:apply-templates select="ies:isPartof">
		<xsl:with-param name="key" select="rdfs:label[1]"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="ies:isPartof[@rdf:resource]">
	<xsl:param name="key"/>
	<entry>
		<xsl:attribute name="key"><xsl:value-of select="$key"/></xsl:attribute>
		<xsl:attribute name="value"><xsl:value-of select="//*[@rdf:about = current()/@rdf:resource]/rdfs:label[1]"/></xsl:attribute>
	</entry>
</xsl:template>

<xsl:template match="ies:isPartof[rdf:Description]">
	<xsl:param name="key"/>
	<entry>
		<xsl:attribute name="key"><xsl:value-of select="$key"/></xsl:attribute>
	<xsl:attribute name="value"><xsl:value-of select="rdf:Description/rdfs:label[1]"/></xsl:attribute>
	</entry>
</xsl:template>

<xsl:template match="skos:broader"/>

</xsl:stylesheet>
