<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="person">
<xsl:copy>
	<xsl:copy-of select="@*"/>
	<xsl:if test="not(row[contains(col[@name = 'sheet']/@value, '99.')])">
		<xsl:copy-of select="row"/>
	</xsl:if>
	<xsl:apply-templates select="row"/>
</xsl:copy>
</xsl:template>

<xsl:template match="row[not(contains(col[@name = 'sheet']/@value, '99.'))]" />


</xsl:stylesheet>
