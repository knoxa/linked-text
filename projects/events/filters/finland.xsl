<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
	Filtering events before building graph ...
 -->

<xsl:import href="../../../xsl/extract/filter-base.xsl"/>

<xsl:template match="event[(contains(text, 'Finland') and not(contains(text, 'Gulf of Finland'))) or contains(text, 'Finnish')]">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	    <entity type="polity">Finland</entity>
	</xsl:copy>
</xsl:template>

<xsl:template match="entity">
	<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
