<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:ies="http://ies.data.gov.uk/ies4#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="rewrite.xsl"/>
<xsl:import href="claim-uri.xsl"/>

<xsl:template match="/">
<context>
	<xsl:apply-templates select="//html:article"/>
</context>
</xsl:template>

<xsl:template match="html:*">
	<xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="html:*[@class = 'claim' or @class = 'premise' or @class = 'conclusion']">
	<xsl:apply-templates select="." mode="filter"/>
	<xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="html:*[html:*[@class = 'conclusion']]">
<!-- This element has a 'conclusion' as a child, so is a rule. We want to make objects out of its premises and conclusions, so keep going ... -->
	<xsl:apply-templates select="*"/>
</xsl:template>

<!-- 
<xsl:template match="html:*" mode="filter">
	<xsl:if test="contains(., 'en route')">
		<xsl:apply-templates select="." mode="object"/>
	</xsl:if>
	<xsl:if test="contains(., 'border') or contains(., 'has a coast')">
		<xsl:apply-templates select="." mode="object"/>
	</xsl:if>
</xsl:template>
 -->
<xsl:template match="html:*" mode="filter">
	<xsl:apply-templates select="." mode="object"/>
</xsl:template>

<xsl:template match="html:*" mode="object">
	<xsl:param name="posn"/>
	<xsl:variable name="uri">
		<xsl:call-template name="getClaimURI"/>
	</xsl:variable>
	<object name="{generate-id()}" uri="{$uri}">
		<text><xsl:value-of select="normalize-space(.)"/></text>
		<xsl:apply-templates select="html:span[@class or @content]" mode="entity"/>
		<!-- 
		<xsl:apply-templates select="." mode="dictionary"/>
		 -->
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


<xsl:template match="*" mode="dictionary">
	<xsl:choose>
		<xsl:when test="contains(., 'a city')">
			<attribute type="class">city</attribute>
		</xsl:when>
		<xsl:when test="contains(., 'a town')">
			<attribute type="class">town</attribute>
		</xsl:when>
		<xsl:when test="contains(., 'a province')">
			<attribute type="class">province</attribute>
		</xsl:when>
		<xsl:when test="contains(., 'are consuls')">
			<attribute type="class">consul</attribute>
		</xsl:when>
		<xsl:when test="contains(., 'en route')">
			<attribute type="class">route</attribute>
		</xsl:when>
		<xsl:when test="contains(., 'border')">
			<attribute type="class">border</attribute>
		</xsl:when>
		<xsl:when test="contains(., 'has a coast')">
			<attribute type="class">border</attribute>
		</xsl:when>
		<xsl:otherwise/>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
