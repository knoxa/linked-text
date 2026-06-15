<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt" version="1.0">

<xsl:import href="../../../xsl/lattice/lattice-x.xsl"/>

<xsl:output method="xml" encoding="utf-8" />

<!-- 
<xsl:template match="/">
<context>
	<xsl:variable name="a">
		<xsl:apply-templates select="//event[text = 'Start of the Second Boer War']" mode="begin"/>
	</xsl:variable>
	<xsl:variable name="b">
		<xsl:apply-templates select="//event[text = 'End of the Second Boer War']" mode="begin"/>
	</xsl:variable>
	<xsl:message>a = <xsl:value-of select="count(exslt:node-set($a)/*)"/>, b = <xsl:value-of select="count(exslt:node-set($b)/*)"/></xsl:message>
	<xsl:variable name="wanted">
		<xsl:call-template name="getBminusA">
			<xsl:with-param name="setA" select="$a"/>
			<xsl:with-param name="setB" select="$b"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:message>wanted = <xsl:value-of select="count(exslt:node-set($wanted)/*)"/></xsl:message>
	<xsl:apply-templates select="exslt:node-set($wanted)/node" mode="copy"/>
</context>
</xsl:template>
 -->

<!-- 
 -->
<xsl:template match="/">
<context>
	<xsl:variable name="a">
		<xsl:apply-templates select="//event[text = 'Start of the First World War']" mode="end"/>
	</xsl:variable>
	<xsl:variable name="b">
		<xsl:apply-templates select="//event[text = 'End of the First World War']" mode="begin"/>
	</xsl:variable>
	<xsl:message>a = <xsl:value-of select="count(exslt:node-set($a)/*)"/>, b = <xsl:value-of select="count(exslt:node-set($b)/*)"/></xsl:message>
	<xsl:variable name="wanted">
		<xsl:call-template name="getIntersection">
			<xsl:with-param name="setA" select="$b"/>
			<xsl:with-param name="setB" select="$a"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:message>wanted = <xsl:value-of select="count(exslt:node-set($wanted)/*)"/></xsl:message>
	<xsl:apply-templates select="exslt:node-set($wanted)/node" mode="copy"/>
</context>
</xsl:template>

<xsl:template match="event" mode="begin">
	<xsl:call-template name="makeDownPath"/>
</xsl:template>

<xsl:template match="event" mode="end">
	<xsl:call-template name="makeUpPath"/>
</xsl:template>

<xsl:template match="node" mode="copy">
	<xsl:apply-templates select="//event[./@id = current()/@id]" mode="object"/>
</xsl:template>

<xsl:template match="event" mode="object">
<object name="{normalize-space(text)}">
	<xsl:apply-templates select="entity" mode="attribute"/>
</object>
</xsl:template>

<xsl:template match="entity" mode="attribute">
	<attribute><xsl:value-of select="."/></attribute>
</xsl:template>

</xsl:stylesheet>
