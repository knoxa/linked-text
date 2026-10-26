<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="person">
	<xsl:variable name="name"><xsl:apply-templates select="row[1]" mode="name"/></xsl:variable>
	<xsl:message><xsl:value-of select="$name"/></xsl:message>
	<xsl:copy>
		<xsl:attribute name="sort">
			<xsl:value-of select="$name"/>
		</xsl:attribute>
		<xsl:attribute name="rows">
			<xsl:value-of select="count(row)"/>
		</xsl:attribute>
    	<xsl:apply-templates select="row">
			<xsl:sort select="col[@name = 'fileyear']/@value" order="ascending"/>
			<xsl:sort select="col[@name = 'reg_date']/@value" order="ascending"/>
    	</xsl:apply-templates>	
	</xsl:copy>
</xsl:template>

<xsl:template match="row" mode="name">
	<xsl:choose>
		<xsl:when test="string-length(col[@name = 'given']/@value) = 0 and following-sibling::row[string-length(col[@name = 'given']/@value) &gt; 0]">
			<xsl:apply-templates select="following-sibling::row[string-length(col[@name = 'given']/@value) &gt; 0][1]" mode="name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="normalize-space(concat(col[@name = 'surname']/@value, ', ', col[@name = 'given']/@value, ' ', col[@name = 'middlenames']/@value))"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
