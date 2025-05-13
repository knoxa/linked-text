<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
	Filtering events before building graph ...
 -->

<xsl:import href="../../../xsl/extract/filter-base.xsl"/>
<xsl:import href="nations.xsl"/>
<xsl:import href="classifier.xsl"/>


<xsl:template match="event[contains(text, 'submarine')]">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template>
  
<xsl:template match="event[contains(text, 'ship')]">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template>
  
<xsl:template match="event[entity/@type = 'vessel']">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="entity[@type = 'notation']">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="entity[@type = 'vessel']">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="entity[@type = 'person']">
	<xsl:copy-of select="."/>
</xsl:template>


</xsl:stylesheet>
