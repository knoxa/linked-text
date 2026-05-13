<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:data="data" version="1.0">

<xsl:import href="hilite.xsl"/>

<xsl:output method="xml" encoding="UTF-8" indent="no"/>

<xsl:template match="/">
<html>
<head>
<title>Testing</title>
<style type="text/css">
span.unit {
  background: thistle;
}
span.interval {
  background: lavender;
}
span.VP {
  background: lightgreen;
}
datetime {
  background: bisque;
}
</style>
</head>
<body>
	<xsl:apply-templates select="//nlp:document"/>
</body>
</html>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'UNIT']]">
	<span class="unit"><xsl:apply-imports/></span>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'INTERVAL']]">
	<span class="interval"><xsl:apply-imports/></span>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'VP']]">
	<span class="VP"><xsl:apply-imports/></span>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'DATE']]">
	<datetime><xsl:apply-imports/></datetime>
</xsl:template>


</xsl:stylesheet>
