<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" indent="yes"/>
 <xsl:param name="dataset"/>

<xsl:variable name="data" select="document($dataset)"/>

<xsl:template match="context">
  <data>
  	<xsl:apply-templates select="object"/>
  </data>
</xsl:template>

<xsl:template match="object">
  <person>
  	<xsl:apply-templates select="attribute"/>
  </person>
</xsl:template>

<xsl:template match="attribute">
	<xsl:variable name="name" select="."/>
		<xsl:message><xsl:value-of select="$name"/></xsl:message>
	<xsl:apply-templates select="$data//col[@name = 'name' and normalize-space(@value) = $name]"/>
</xsl:template>

<xsl:template match="col">
	<xsl:copy-of select=".."/>
</xsl:template>

</xsl:stylesheet>
