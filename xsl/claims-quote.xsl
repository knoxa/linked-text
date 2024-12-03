<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<!-- 
	Make RA-Nodes that have blockquote claims as conclusions. The premise is either a preceding sibling blockquote element (where the quotation is 
	assumed to be part of the preceding quotation), or the passage identified by containing article element. Note that the article element doesn't have
	to be the immediate parent. This allows for arguments within an article to be grouped by div elements if desired.
 -->


<xsl:template match="html:blockquote[contains(@class, 'aside')]" mode="quote">
	<!--  do nothing  -->
</xsl:template>

<xsl:template match="html:blockquote" mode="quote">
	<xsl:choose>
	<!-- 
		Make this ancestor::html:blockquote? i.e. require that quotes from quotes are nested ...
	 -->
		<xsl:when test="preceding-sibling::html:blockquote">
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
		</xsl:when>
		<xsl:otherwise>
		<!-- 
			<xsl:call-template name="aif-ranode">
				<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'Q1')"/>
				<xsl:with-param name="claimText" select="'source quote'"/>
				<xsl:with-param name="premises">
					<premise><xsl:value-of select="concat('&lt;', ancestor::html:*[@about][1]/@about, '&gt;')"/></premise>
				</xsl:with-param>
				<xsl:with-param name="conclusion">
					<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
				</xsl:with-param>
			</xsl:call-template>	
		 -->
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="*" mode="quote">
	<xsl:apply-templates select="*" mode="quote"/>
</xsl:template>

</xsl:stylesheet>
