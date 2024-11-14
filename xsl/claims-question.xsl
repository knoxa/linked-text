<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="text" encoding="utf-8" />


<xsl:template match="/|*" mode="question">
	<xsl:apply-templates select="*" mode="question"/>
</xsl:template>


<xsl:template match="html:*[contains(@class, 'question')]" mode="question">
	<xsl:call-template name="aif-tanode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
		<xsl:with-param name="claimText" select="'questioning'"/>
		<xsl:with-param name="premises">
		<!-- 
			<premise><xsl:value-of select="concat('&lt;', preceding::*[contains(@class, 'claim')][1]/@about, '&gt;')"/></premise>
			<premise><xsl:value-of select="concat('&lt;', preceding-sibling::*[@about][1]/@about, '&gt;')"/></premise>
		 -->
			<premise><xsl:value-of select="concat('&lt;', ancestor::*[@about][1]/@about, '&gt;')"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
		</xsl:with-param>
	</xsl:call-template>	
	<xsl:apply-templates select="*" mode="question"/>
</xsl:template>

</xsl:stylesheet>
