<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:time="http://www.w3.org/2006/time#" xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
	  <xsl:apply-templates select="temporal"/>
</xsl:template>


<xsl:template match="temporal">
<xsl:copy>
	<xsl:apply-templates select="event">
		<xsl:sort select="@fm" data-type="text" order="ascending"/>
		<xsl:sort select="@to" data-type="text" order="descending"/>
	</xsl:apply-templates>
</xsl:copy>
</xsl:template>

<xsl:template match="event">

<xsl:choose>
<xsl:when test="number(translate(@fm, '-', '')) &lt; number(translate(@to, '-', ''))">
<xsl:message><xsl:value-of select="@fm"/> : <xsl:value-of select="@to"/></xsl:message>
</xsl:when>
<xsl:otherwise>
</xsl:otherwise>
</xsl:choose>

	<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
