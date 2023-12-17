<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="text" encoding="utf-8" />

<xsl:import href="rewrite.xsl"/>
<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()" mode="rewrite">
    <xsl:apply-templates select="*" mode="rewrite"/>
</xsl:template>
 
<xsl:template match="html:*[contains(@class,'claim')][./html:span[@content]]" mode="rewrite">
	<xsl:variable name="original" select="translate(., '.', '')"/>
	<xsl:variable name="rewritten"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:variable name="hash">
		<xsl:call-template name="hashMD5">
			<xsl:with-param name="text" select="$rewritten"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="origHash"><xsl:value-of select="substring-after(@about, 'urn:string:md5:')"/></xsl:variable>
	<xsl:if test="not($hash = $origHash)">
		<!-- Make an I-node for the rewritten claim (do this in "list"?) -->
		<xsl:call-template name="aif-inode">
			<xsl:with-param name="nodeid" select="concat('&lt;', 'urn:string:md5:', $hash, '&gt;')"/>
			<xsl:with-param name="claimText" select="normalize-space($rewritten)"/>
		</xsl:call-template>
		<!-- Make an RA-node -->
		<xsl:call-template name="aif-ranode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'RW')"/>
		<xsl:with-param name="claimText" select="'interpret and infer'"/>
		<xsl:with-param name="premises">
			<!-- The immediately preceding source text is a premise ... -->
			<premise><xsl:value-of select="concat('&lt;', preceding::html:blockquote[1]/@about, '&gt;')"/></premise>
			<!-- ... as are any "rewrite rules" -->
			<xsl:for-each select="./html:span[@content]">
				<xsl:apply-templates select="ancestor::html:article[1]//html:*[@class = 'name'][. = current()/@content][1]" mode="rewritePremise"/>
			</xsl:for-each>
		</xsl:with-param>
		<!-- The conclusion is the rewritten argument -->
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', 'urn:string:md5:', $hash, '&gt;')" />
		</xsl:with-param>
		</xsl:call-template>
		<!-- Make an MA-node linking from original argument to rewritten argument -->		
		<xsl:call-template name="aif-manode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'MA')"/>
		<xsl:with-param name="claimText" select="'rewriting'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="concat('&lt;', @about, '&gt;')"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', 'urn:string:md5:', $hash, '&gt;')" />
		</xsl:with-param>
	</xsl:call-template>		
	</xsl:if>
</xsl:template>

<xsl:template match="html:*[@class = 'name']" mode="rewritePremise">
	<premise><xsl:value-of select="concat('&lt;', ../@about, '&gt;')"/></premise>
</xsl:template>

</xsl:stylesheet>
