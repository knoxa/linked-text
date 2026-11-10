<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
	  <xsl:apply-templates select="data"/>
</xsl:template>

<xsl:template match="data">
<context>
	<xsl:apply-templates select="person"/>
</context>
</xsl:template>

<xsl:template match="person">
	<object name="{@sort}">
		<xsl:apply-templates select="row"/>
		<attribute><xsl:value-of select="@sort"/></attribute>
	</object>
</xsl:template>

<xsl:template match="row">
		<xsl:apply-templates select="col[@name = 'reg_date']"/>
		<xsl:apply-templates select="col[@name = 'reg_rank']"/>
		<!-- 
			<object name="{col[@name = 'idkey']/@value}">
		<xsl:apply-templates select="col[@name = 'given']"/>
		<xsl:apply-templates select="col[@name = 'middlenames']"/>
		<xsl:apply-templates select="col[@name = 'surname']"/>
		<xsl:apply-templates select="col[@name = 'fileyear']"/>
		 -->
</xsl:template>

<xsl:template match="col">
	<xsl:if test="string-length(@value) &gt; 0">
		<attribute><xsl:value-of select="@value"/></attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
