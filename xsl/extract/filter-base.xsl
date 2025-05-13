<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
	Filtering events before building graph ...
	Import this stylesheet into one that defines a filter. Events are filtered out by default, so
	match ones you want to keep in the filter stylesheet.
 -->

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>
 
 <xsl:template match="text">
 	<xsl:copy>
 		<xsl:value-of select="normalize-space(.)"/>
 	</xsl:copy>
 </xsl:template>

<xsl:template match="event"/>

<xsl:template match="entity"/>

</xsl:stylesheet>
