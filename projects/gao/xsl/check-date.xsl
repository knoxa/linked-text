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

<xsl:template match="row[string-length(col[@name = 'reg_rank']/@value) &gt; 0 and string-length(col[@name = 'reg_date']/@value)]">
	<xsl:apply-templates select="following-sibling::row[./col[@name = 'reg_rank']/@value = current()/col[@name = 'reg_rank']/@value and ./col[@name = 'reg_date']/@value != current()/col[@name = 'reg_date']/@value][1]" mode="check">
		<xsl:with-param name="date" select="col[@name = 'reg_date']/@value"/>
		<xsl:with-param name="idkey" select="col[@name = 'idkey']/@value"/>
		<xsl:with-param name="year" select="col[@name = 'fileyear']/@value"/>
		<xsl:with-param name="prev" select="."/>
	</xsl:apply-templates>
	<xsl:apply-templates select="following-sibling::row[number(./col[@name = 'rank_lvl']/@value) &gt; number(current()/col[@name = 'rank_lvl']/@value)][1]" />
</xsl:template>

<xsl:template match="row[string-length(col[@name = 'reg_rank']/@value) &gt; 0 and string-length(col[@name = 'reg_date']/@value)]" mode="check">
	<xsl:param name="date"/>
	<xsl:param name="idkey"/>
	<xsl:param name="year"/>
	<xsl:param name="prev"/>
	<argument>
	<claim>Different dates for <xsl:value-of select="col[@name = 'reg_rank']/@value"/>, <xsl:value-of select="$date"/> and <xsl:value-of select="col[@name = 'reg_date']/@value"/>, between records <xsl:value-of select="$idkey"/> (<xsl:value-of select="$year"/>) and <xsl:value-of select="col[@name = 'idkey']/@value"/> (<xsl:value-of select="col[@name = 'fileyear']/@value"/>).</claim>
		<xsl:copy-of select="$prev"/>
		<xsl:copy-of select="."/>
	</argument>
</xsl:template>

<xsl:template match="row" />
<xsl:template match="row" mode="check" />

</xsl:stylesheet>
