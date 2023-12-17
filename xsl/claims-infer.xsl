<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:import href="rewrite.xsl"/>


<xsl:template match="/|*|@*|comment()|processing-instruction()|text()" mode="infer">
    <xsl:apply-templates select="*" mode="infer"/>
</xsl:template>


<xsl:template match="html:*[@class = 'support']" mode="infer">
	<xsl:call-template name="aif-ranode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
		<xsl:with-param name="claimText" select="'default support'"/>
		<xsl:with-param name="premises">
			<xsl:apply-templates select="../*" mode="premise"/>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:apply-templates select="../*" mode="conclusion"/>
		</xsl:with-param>
	</xsl:call-template>	
</xsl:template>


<xsl:template match="html:*[@class = 'conflict']" mode="infer">
	<xsl:call-template name="aif-canode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
		<xsl:with-param name="claimText" select="'default conflict'"/>
		<xsl:with-param name="premises">
			<xsl:apply-templates select="../*" mode="premise"/>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:apply-templates select="../*" mode="conclusion"/>
		</xsl:with-param>
	</xsl:call-template>	
</xsl:template>


<xsl:template match="html:*[contains(@class,'premise')]" mode="premise">
	<premise><xsl:value-of select="concat('&lt;', @about, '&gt;')"/></premise>
</xsl:template>


<xsl:template match="html:*[contains(@class,'conclusion')]" mode="conclusion">
	<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
</xsl:template>


<xsl:template match="*" mode="premise"/>
<xsl:template match="*" mode="conclusion"/>

</xsl:stylesheet>
