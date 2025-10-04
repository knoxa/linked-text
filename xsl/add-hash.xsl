<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:import href="https://raw.githubusercontent.com/dstl/eleatics/refs/heads/master/xsl-utils/stringhash.xsl"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="html:p[@class = 'report']">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:variable name="text">
			<xsl:value-of select="."/>
		</xsl:variable>
		<xsl:variable name="hash">
			<xsl:call-template name="hashMD5">
				<xsl:with-param name="text" select="$text"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:attribute name="about"><xsl:value-of select="concat('urn:eleatics:md5:', $hash)"/></xsl:attribute>
		<xsl:apply-templates select="*|comment()|text()"/>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
