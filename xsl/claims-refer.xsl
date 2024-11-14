<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="text" encoding="utf-8" />


<xsl:template match="html:li[html:span[@class = 'claim']]">
	<xsl:apply-templates select="." mode="so" />
</xsl:template>

<!-- 
<xsl:template match="html:li[html:span[.//html:span]]">
<xsl:message>TO DO: <xsl:value-of select="@about"/></xsl:message>
</xsl:template>
 -->

<xsl:template match="html:li[contains(@class, 'aside')]">
	<!--  do nothing  -->
</xsl:template>

<xsl:template match="html:li">
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


<xsl:template match="html:li" mode="so">
	<xsl:for-each select="./html:span[@about]">
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
		<xsl:apply-templates select="../html:ul[1]/html:li[@about]" mode="so-conclusion">
			<xsl:with-param name="premise"><xsl:value-of select="$claim"/></xsl:with-param>
		</xsl:apply-templates>
	</xsl:for-each>
</xsl:template>


<xsl:template match="html:li" mode="so-conclusion">
	<xsl:param name="premise"/>
	<xsl:call-template name="aif-ranode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
		<xsl:with-param name="claimText" select="'anaphor resolved'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="concat('&lt;', $premise, '&gt;')"/></premise>
			<premise><xsl:value-of select="concat('&lt;', preceding::html:blockquote[1]/@about, '&gt;')"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
		</xsl:with-param>
	</xsl:call-template>	
</xsl:template>


</xsl:stylesheet>
