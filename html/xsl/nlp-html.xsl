<?xml version="1.0"?>
<xsl:stylesheet xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:data="data" version="1.0">

<!-- 
	View Baleen XML as a web page
 -->
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
td {
  text-align: center;
  white-space: nowrap;
}
table {
  text-align: center;
}
span.lemma {
  font-size: small;
  font-style: italic;
  color: grey;
  background: white;
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
span.person {
  background: pink;
}
span.PersonName {
  background: pink;
}
span.xName {
  background: thistle;
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
	<xsl:choose>
		<xsl:when test="//nlp:paragraph[1]">
			<xsl:apply-templates select="//nlp:paragraph">
				<xsl:sort select="@begin" data-type="number" order="ascending"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
		<xsl:apply-templates select="//nlp:sentence">
			<xsl:sort select="@begin" data-type="number" order="ascending"/>
		</xsl:apply-templates>
		</xsl:otherwise>
	</xsl:choose>
</body>
</html>
</xsl:template>



<xsl:template match="nlp:paragraph">
	<xsl:apply-templates select="nlp:sentence"/>
</xsl:template>


<xsl:template match="nlp:sentence">
	<xsl:apply-templates select="nlp:token"/>
	<div class="nl"/>
</xsl:template>


<xsl:template match="nlp:token">
	<xsl:variable name="displayLemmaLabel"><xsl:call-template name="getDisplayLemmaLabel"/></xsl:variable>
	<xsl:variable name="displayClass"><xsl:call-template name="getDisplayClass"/></xsl:variable>
	<div>
		<xsl:if test="name(ancestor::nlp:*[1]) = 'nlp:sentence'">
			<xsl:choose>
				<xsl:when test="position() = 1">
					<xsl:attribute name="class"><xsl:value-of select="'top first'"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class"><xsl:value-of select="'top'"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<table>
			<tr>
				<td>
					<xsl:variable name="surfaceClass">
					<xsl:choose>
						<xsl:when test="name(ancestor::*[1]) = 'sentence'">
							<xsl:value-of select="concat('top ',$displayClass)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$displayClass"/>
						</xsl:otherwise>
					</xsl:choose>
					</xsl:variable>
					<span class="{$surfaceClass}">
						<xsl:value-of select="nlp:surface"/>
					</span>
				</td>
			</tr>
			<tr><td><span class="lemma"><xsl:value-of select="$displayLemmaLabel"/></span></td></tr>
			<tr><td><xsl:apply-templates select="nlp:token" /></td></tr>
		</table>
		
	</div>
</xsl:template>


<xsl:template name="getDisplayLemmaLabel">
	<xsl:choose>
		<xsl:when test="./nlp:lemma[@type = 'PersonName']">
			<xsl:value-of select="./nlp:lemma[@type = 'PersonName']"/>
		</xsl:when>
		<xsl:when test="nlp:lemma/@identity = 'true'">
			<xsl:value-of select="nlp:lemma[@identity = 'true']/@type"/>
		</xsl:when>
		<xsl:when test="./nlp:lemma/@type = '*name'">
			<xsl:value-of select="'Name'"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="nlp:lemma[1]/@type"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template name="getDisplayClass">
	<xsl:choose>
		<xsl:when test="nlp:lemma/@identity = 'true'">
			<xsl:value-of select="nlp:lemma[@identity = 'true']/@type"/>
		</xsl:when>
		<xsl:when test="nlp:lemma/@type = '*name'">
			<xsl:value-of select="'Name'"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="nlp:lemma[1]/@type"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


</xsl:stylesheet>
