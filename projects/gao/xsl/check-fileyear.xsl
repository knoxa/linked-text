<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
	  <xsl:apply-templates select="data"/>
</xsl:template>

<xsl:template match="data">
<xsl:copy>
	<xsl:apply-templates select="person"/>
</xsl:copy>
</xsl:template>

<xsl:template match="person">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates select="row[1]"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="row">
	<xsl:apply-templates select="following-sibling::row[1]" mode="check">
		<xsl:with-param name="date" select="col[@name = 'fileyear']/@value"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="row" mode="check">
	<xsl:param name="date" select="number('0')"/>
	<xsl:if test="number(col[@name = 'fileyear']/@value) - $date &gt; 1">
		<xsl:copy-of select="preceding::row[1]"/>
		<xsl:copy-of select="."/>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
