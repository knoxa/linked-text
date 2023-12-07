<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="text" encoding="utf-8" />

<xsl:import href="rewrite.xsl"/>
<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()" mode="rewrite">
    <xsl:apply-templates select="*" mode="rewrite"/>
</xsl:template>


<xsl:template match="html:*[@class = 'rewrite']" mode="rewrite">
	<xsl:variable name="claim" select="@about"/>
	<xsl:call-template name="aif-ranode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
		<xsl:with-param name="claimText" select="'infer from text'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="concat('&lt;', preceding::html:blockquote[1]/@about, '&gt;')"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', $claim, '&gt;')"/>
		</xsl:with-param>
	</xsl:call-template>		
</xsl:template>


<xsl:template match="html:*[@class = 'analysis']" mode="rewrite">
    <xsl:apply-templates select="html:*[@class = 'rewrite']" mode="rewrite"/>
	<!-- Don't rewrite analyst claims -->
</xsl:template>
 
<xsl:template match="html:*[contains(@class,'claim')][./html:span[@content]]" mode="rewrite">
	<xsl:variable name="original" select="translate(., '.', '')"/>
	<xsl:variable name="rewritten"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:message><xsl:value-of select="$original"/> --- <xsl:value-of select="$rewritten"/></xsl:message>
	<xsl:variable name="hash">
		<xsl:call-template name="hashMD5">
			<xsl:with-param name="text" select="$rewritten"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="origHash"><xsl:value-of select="substring-after(@about, 'urn:string:md5:')"/></xsl:variable>
	<xsl:message><xsl:value-of select="$origHash"/> --- <xsl:value-of select="$hash"/></xsl:message>
	<xsl:call-template name="aif-inode">
		<xsl:with-param name="nodeid" select="concat('&lt;', 'urn:string:md5:', $hash, '&gt;')"/>
		<xsl:with-param name="claimText" select="normalize-space($rewritten)"/>
	</xsl:call-template>
	<xsl:if test="not($hash = $origHash)">
		<xsl:call-template name="aif-ranode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'RW')"/>
		<xsl:with-param name="claimText" select="'interpet and infer'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="concat('&lt;', preceding::html:blockquote[1]/@about, '&gt;')"/></premise>
			<xsl:for-each select="./html:span[@content]">
				<xsl:apply-templates select="ancestor::html:article[1]//html:*[@class = 'name'][. = current()/@content][1]" mode="rewritePremise"/>
			</xsl:for-each>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', 'urn:string:md5:', $hash, '&gt;')" />
		</xsl:with-param>
		</xsl:call-template>
		<!-- Make an MA-node (TO DO - an RA-node for the time being) -->		
		<xsl:call-template name="aif-ranode">
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
