<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:template match="context">
<context>
	<xsl:apply-templates select="//path[attribute = 'British']"/>
</context>
</xsl:template>

<xsl:template match="path">
	<xsl:variable name="tgt"><xsl:value-of select="//path[attribute = 'destroyer']/@id"/></xsl:variable>
	<path id="{@id}">
		<xsl:apply-templates select="//path[@id = $tgt]" mode="meet">
			<xsl:with-param name="path" select="."/>
		</xsl:apply-templates>
	</path>
</xsl:template>


<xsl:template match="path" mode="meet">
	<xsl:param name="path"/>
	<tgt><xsl:value-of select="@id"/></tgt>
	<xsl:for-each select="link">
		<xsl:if test="$path/link[@id = current()/@id]">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
