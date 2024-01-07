<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="*[not(@about) and (contains(@class, 'claim') or contains(@class, 'premise') or contains(@class, 'conclusion') or contains(@class, 'question') or contains(@class, 'rewrite'))] | html:blockquote | html:span[not(@about) and (@class = 'person' or @class = 'child' or @class = 'parent')]">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:variable name="text">
			<xsl:choose>
				<xsl:when test="@content"><xsl:value-of select="@content"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="normalize-space(translate(., '.,', ''))"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="hash">
			<xsl:call-template name="hashMD5">
				<xsl:with-param name="text" select="$text"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- 
		<xsl:attribute name="about"><xsl:value-of select="concat('_:', $hash)"/></xsl:attribute>
		<xsl:attribute name="about"><xsl:value-of select="concat('urn:string:md5:', $hash)"/></xsl:attribute>
		 -->
		<xsl:attribute name="about"><xsl:value-of select="concat('urn:string:md5:', $hash)"/></xsl:attribute>
		<xsl:apply-templates select="*|comment()|text()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="html:article[not(@about)]">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:attribute name="about"><xsl:value-of select="concat('_:', generate-id())"/></xsl:attribute>
    	<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
