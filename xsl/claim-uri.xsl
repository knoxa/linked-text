<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<xsl:template name="getClaimURI">
<!-- 
	The URI of a claim is given by the @about attribute if set, or a URN constructed from the eleatics string hash if not.
-->
	<xsl:choose>
		<xsl:when test="@about and not(starts-with(@about, '_:'))">
			<xsl:value-of select="@about"/>
		</xsl:when>
		<!-- 
			TO DO: Need to extend this to test for blank nodes, and shortened URI's that reference a namespace ....
		 -->
		<xsl:otherwise>
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
			<xsl:value-of select="concat('urn:eleatics:md5:', $hash)"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
