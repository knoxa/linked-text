<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
	Filtering events before building graph ...
 -->

<xsl:import href="../../../xsl/extract/filter-base.xsl"/>
<xsl:import href="nations.xsl"/>
<xsl:import href="classifier.xsl"/>

<xsl:template match="event[contains(text, 'ate of War') or contains(text, 'declare war') or contains(text, 'declares war') or contains(text, 'commences hostilities')]">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
		<xsl:apply-templates select="." mode="nation"/>
		<xsl:apply-templates select="." mode="type"/>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>
