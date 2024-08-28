<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:import href="file:///D:/GitHub/eleatics/argumentation/xsl/aif.xsl"/>

<!--
	Get the text context of the current element, taking account of @content elements where specified.
-->
<xsl:template name="getArgument">
	<xsl:apply-templates select="." mode="text"/>
</xsl:template>

<xsl:template match="html:*[@content]" mode="text">
	<xsl:value-of select="@content"/>
</xsl:template>

<xsl:template match="*" mode="text">
	<xsl:apply-templates select="*|text()" mode="text"/>
</xsl:template>

<xsl:template match="text()" mode="text">
	<xsl:value-of select="translate(., '.', '')"/>
</xsl:template>



<xsl:template name="makeInformationNode">
	<xsl:variable name="text">
		<xsl:choose>
			<xsl:when test="@content"><xsl:value-of select="@content"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="normalize-space(translate(., '.,', ''))"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:call-template name="aif-inode">
		<xsl:with-param name="nodeid" select="concat('&lt;', @about, '&gt;')"/>
		<xsl:with-param name="claimText" select="$text"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
