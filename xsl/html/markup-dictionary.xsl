<?xml version="1.0"?>
<xsl:stylesheet xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:data="data" version="1.0">

<xsl:output method="html" encoding="UTF-8"/>

<xsl:template match="/">
<html>
<head>
<title>Testing</title>
<style type="text/css">
div {
  float: left;
  position: relative;
  margin: 5px;
}
div.txt {
#  border-style: solid;
#  border-width: 2px;
}
div.nl {
  width: 30px;
  height: 30px;
  clear: both;
  margin-right: 100%;
}
div.top {
  height: 280px;
}
div.first {
  clear: left;
}
span {
  text-align: center;
}
div.txt {
  margin: 5px;
}
span.top {
  font-size: 20px;
}
span.NP {
  background: pink;
}
span.known {
  background: lightgreen;
}
span.VP {
  background: lightgreen;
}
span.entity {
  text-decoration: underline;
}
span.person {
  background: pink;
}
span.PersonName {
  background: pink;
}
span.unit {
  background: thistle;
}
span.description {
  font-weight: bold;
}
span.place, span.city {
  background: peachpuff;
}
span.PP {
  color: grey;
}
span.Name {
  color: red;
}
</style>
</head>
<body>
	<xsl:apply-templates select="//nlp:document"/>
</body>
</html>
</xsl:template>


<xsl:template match="nlp:document">
<article>
	<xsl:apply-templates select="nlp:sentence"/>
</article>
</xsl:template>


<xsl:template match="nlp:sentence">
<p>
	<xsl:text><xsl:value-of select="substring(../nlp:text[1], @begin + 1, @end - @begin)"/></xsl:text>
</p>
</xsl:template>


<xsl:template match="nlp:sentence[nlp:annotation]">
<p>
	<xsl:apply-templates select="nlp:annotation[1]" mode="top"/>	
	<xsl:apply-templates select="nlp:annotation"/>	
	<xsl:apply-templates select="nlp:annotation[last()]" mode="tail"/>	
</p>
</xsl:template>


<xsl:template match="nlp:annotation">
	<xsl:variable name="text" select="ancestor::nlp:document[1]/nlp:text[1]"/>
	<span class="{@type}">
		<xsl:text><xsl:value-of select="substring($text, @begin + 1, @end - @begin)"/></xsl:text>
	</span>
	<!-- text between this child and the next -->
	<xsl:apply-templates select="following-sibling::nlp:annotation[1]" mode="text-begin">
		<xsl:with-param name="start" select="@end"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="nlp:annotation" mode="text-begin">
	<xsl:param name="start" select="@begin"/>
	<xsl:variable name="text" select="ancestor::nlp:document[1]/nlp:text[1]"/>
	<xsl:if test="@begin &gt; $start">
		<xsl:text><xsl:value-of select="substring($text, $start + 1, @begin - $start)"/></xsl:text>
	</xsl:if>
</xsl:template>


<xsl:template match="nlp:annotation" mode="top">
	<xsl:variable name="text" select="ancestor::nlp:document[1]/nlp:text[1]"/>
	<xsl:variable name="start" select="ancestor::nlp:sentence[1]/@begin"/>
	<xsl:if test="@begin &gt; $start">
		<xsl:text><xsl:value-of select="substring($text, $start + 1, @begin - $start)"/></xsl:text>
	</xsl:if>
</xsl:template>


<xsl:template match="nlp:annotation" mode="tail">
	<xsl:variable name="text" select="ancestor::nlp:document[1]/nlp:text[1]"/>
	<xsl:variable name="end" select="ancestor::nlp:sentence[1]/@end"/>
	<xsl:if test="$end &gt; @end">
		<xsl:text><xsl:value-of select="substring($text, @end + 1, $end - @end)"/></xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template name="outputText">
	<xsl:param name="text"/>
	<xsl:text><xsl:value-of select="$text"/></xsl:text>
</xsl:template>

</xsl:stylesheet>
