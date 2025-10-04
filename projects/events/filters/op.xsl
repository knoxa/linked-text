<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
	Select only events about operations
 -->

<xsl:import href="../../../xsl/extract/filter-base.xsl"/>

<xsl:template match="event[entity[@type = 'op']]">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="entity[@type = 'op']">
	<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
