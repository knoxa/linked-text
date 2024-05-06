<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="rewrite.xsl"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//html:article"/>
	<xsl:apply-templates select="//html:*[@typeof = 'rdf:Seq']"/>
</temporal>
</xsl:template>

<xsl:template match="html:article">
	<xsl:apply-templates select=".//html:*[@class = 'claim']">
		<xsl:with-param name="posn" select="position()"/>
	</xsl:apply-templates>
</xsl:template>

<!-- 
<xsl:template match="html:*[@class = 'claim'][contains(., 'consul')]">
<xsl:template match="html:*[@class = 'claim'][contains(., 'consul') or contains(., 'birth') or contains(., 'death') or contains(., 'emperor')]">
 -->

<xsl:template match="html:*[@class = 'claim']">
	<xsl:param name="posn"/>
	<event uri="{@about}">
		<text><xsl:value-of select="normalize-space(.)"/></text>
		<interval  fm="{$posn}" to="{$posn}" />
		<xsl:apply-templates select="html:span[@class]" mode="entity"/>
	</event>
</xsl:template>


<xsl:template match="html:*[@typeof = 'rdf:Seq']">
	<xsl:apply-templates select="./html:*[@class = 'claim']" mode="linkfm"/>
</xsl:template>

<xsl:template match="*" mode="linkfm">
	<xsl:apply-templates select="following-sibling::html:*[@class = 'claim'][1]" mode="linkto">
		<xsl:with-param name="uri" select="@about"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="*" mode="linkto">
	<xsl:param name="uri"/>
	<link fm="{$uri}" to="{@about}"/>
</xsl:template>

<xsl:template match="html:*"/>

<xsl:template match="html:span[@class = 'claim']" mode="entity"/>

<xsl:template match="html:span[@class]" mode="entity">
	<entity type="{@class}">
		<xsl:choose>
			<xsl:when test="@content">
				<xsl:value-of select="@content"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</entity>
</xsl:template>

</xsl:stylesheet>
