<?xml version="1.0"?>
<xsl:stylesheet xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="skos rdf" version="1.0">

<xsl:template match="*" mode="label">
	<xsl:choose>
		<xsl:when test="skos:prefLabel">
			<xsl:value-of select="skos:prefLabel"/>
		</xsl:when>
		<xsl:when test="skos:altLabel">
			<xsl:value-of select="skos:altLabel"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="'_UNK_'"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
