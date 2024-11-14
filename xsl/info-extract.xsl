<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="html nlp" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="claim-uri.xsl"/>
<xsl:import href="rewrite.xsl"/>

<xsl:template match="/">
<context>
	<xsl:apply-templates select="//html:a" />
</context>
</xsl:template>

<xsl:template match="html:a">
	<xsl:apply-templates select="document(@href)" mode="extract"/>
</xsl:template>

<xsl:template match="/" mode="extract">
	<xsl:apply-templates select="*" mode="claim"/>
</xsl:template>

<xsl:template match="*" mode="claim">
	<xsl:apply-templates select="*" mode="claim"/>
</xsl:template>

<xsl:template match="html:*[@class = 'claim']" mode="claim">
	<xsl:variable name="uri">
		<xsl:call-template name="getClaimURI"/>
	</xsl:variable>
	<xsl:variable name="text">
		<xsl:call-template name="getArgument"/>
	</xsl:variable>
	<object name="{generate-id()}" uri="{$uri}">
		<text><xsl:value-of select="normalize-space($text)"/></text>
		<xsl:apply-templates select="html:span[@class or @content]" mode="entity"/>
	</object>
</xsl:template>

<xsl:template match="html:span[@class]" mode="entity">
	<attribute type="{@class}" surface="{normalize-space(.)}">
		<xsl:choose>
			<xsl:when test="@content">
				<xsl:value-of select="@content"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</attribute>
</xsl:template>

<xsl:template match="html:span[@content]" mode="entity">
	<attribute type="unknown" surface="{normalize-space(.)}">
		<xsl:value-of select="@content"/>
	</attribute>
</xsl:template>

<xsl:template match="html:span[contains(@class, 'premise') or contains(@class, 'support') or contains(@class, 'conflict') or contains(@class, 'conclusion')]" mode="entity">
	<xsl:apply-templates select="html:span[@class or @content]" mode="entity"/>
</xsl:template>

</xsl:stylesheet>
