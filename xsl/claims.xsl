<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="text" encoding="utf-8" />

<xsl:import href="file:///D:/GitHub/eleatics/argumentation/xsl/aif.xsl"/>
<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<xsl:import href="claims-info.xsl"/>
<xsl:import href="claims-infer.xsl"/>
<xsl:import href="claims-refer.xsl"/>
<xsl:import href="claims-quote.xsl"/>
<xsl:import href="claims-question.xsl"/>
<xsl:import href="claims-rewrite.xsl"/>

<xsl:template match="/">
<!-- 
	<xsl:apply-templates select="//html:article[@about = 'urn:cts:latinLit:phi1348.abo012.perseus-eng1:62']"/>
 -->
	<xsl:apply-templates select="//html:article[@about = 'urn:cts:latinLit:phi1351.phi005.perseus-eng1:1.33']"/>
</xsl:template>

<xsl:template match="html:article">
	<xsl:apply-templates select="." mode="list"/>
	<xsl:apply-templates select=".//html:blockquote" mode="list"/>
	<xsl:apply-templates select="." mode="quote"/>
	<xsl:apply-templates select=".//html:blockquote" mode="quote"/>
	<xsl:apply-templates select=".//html:div/html:ul/html:li"/>
	<xsl:apply-templates select=".//html:*[@typeof = 'rdf:Alt']" />
	<xsl:apply-templates select=".//html:*[contains(@class, 'wrong')]" mode="wrong"/>
	<!-- 
	 -->
	<xsl:apply-templates select=".//html:*[contains(@class, 'claim') or contains(@class, 'premise') or contains(@class, 'conclusion')]" mode="infer"/>
	<xsl:apply-templates select="." mode="rewrite"/>
	<xsl:apply-templates select="." mode="question"/>
</xsl:template>

<xsl:template match="*[@class = 'premise']" mode="premise">
	<premise><xsl:value-of select="concat('&lt;', @about, '&gt;')"/></premise>
</xsl:template>


<xsl:template match="*[@class = 'conclusion']" mode="conclusion">
	<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
</xsl:template>


<xsl:template match="*" mode="premise"/>
<xsl:template match="*" mode="conclusion"/>


<xsl:template match="*[@typeof = 'rdf:Alt']">
	<xsl:for-each select="./*[contains(@class, 'claim')]">
		<xsl:apply-templates select="preceding-sibling::*[contains(@class, 'claim')]" mode="contradict">
			<xsl:with-param name="premise" select="@about"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="following-sibling::*[contains(@class, 'claim')]" mode="contradict">
			<xsl:with-param name="premise" select="@about"/>
		</xsl:apply-templates>
	</xsl:for-each>
</xsl:template>


<xsl:template match="*[contains(@class, 'claim')]" mode="contradict">
	<xsl:param name="premise"/>
	<xsl:call-template name="aif-canode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
		<xsl:with-param name="claimText" select="'contradiction'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="concat('&lt;',$premise, '&gt;')"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template match="html:*" mode="wrong">
	<xsl:variable name="claim-uri" select="concat('_:', generate-id(), 'P')"/>
	<xsl:call-template name="aif-inode">
		<xsl:with-param name="nodeid" select="$claim-uri"/>
		<xsl:with-param name="claimText" select="'Me: This is wrong!'"/>
	</xsl:call-template>
	<xsl:call-template name="aif-canode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id(), 'X')"/>
		<xsl:with-param name="claimText" select="'a mistake'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="$claim-uri"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', @about, '&gt;')"/>
		</xsl:with-param>
	</xsl:call-template>
	
</xsl:template>


</xsl:stylesheet>
