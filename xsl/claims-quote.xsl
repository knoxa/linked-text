<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">


<xsl:template match="html:blockquote" mode="quote">
	<xsl:if test="preceding-sibling::html:blockquote">
		<xsl:call-template name="aif-ranode">
			<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'Q')"/>
			<xsl:with-param name="claimText" select="'selective quote'"/>
			<xsl:with-param name="premises">
				<premise><xsl:value-of select="concat('&lt;', preceding-sibling::html:blockquote[1]/@about, '&gt;')"/></premise>
			</xsl:with-param>
			<xsl:with-param name="conclusion">
				<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
			</xsl:with-param>
		</xsl:call-template>	
	</xsl:if>
</xsl:template>


<xsl:template match="html:article[html:blockquote]" mode="quote">
	<xsl:call-template name="aif-ranode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'Q')"/>
		<xsl:with-param name="claimText" select="'source text'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="concat('&lt;', @about, '&gt;')"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', ./html:blockquote[1]/@about, '&gt;')"/>
		</xsl:with-param>
	</xsl:call-template>	
</xsl:template>


<xsl:template match="html:article[html:div/html:blockquote]" mode="quote">
	<xsl:variable name="premise" select="concat('&lt;', @about, '&gt;')"/>
	<xsl:for-each select="html:div[html:blockquote]">
		<xsl:call-template name="aif-ranode">
			<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'Q')"/>
			<xsl:with-param name="claimText" select="'source text'"/>
			<xsl:with-param name="premises">
				<premise><xsl:value-of select="$premise"/></premise>
			</xsl:with-param>
			<xsl:with-param name="conclusion">
				<xsl:value-of select="concat('&lt;', ./html:blockquote[1]/@about, '&gt;')"/>
			</xsl:with-param>
		</xsl:call-template>	
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
