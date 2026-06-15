<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
<xsl:copy>
	<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
</xsl:copy>
</xsl:template>

<xsl:template match="event[entity = '2nd Battalion' ]">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="event[text = 'Start of the Second World War' ]">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="event[text = 'End of the Second World War' ]">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="event[text = 'Start of the First World War' ]">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="event[text = 'End of the First World War' ]">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="event"/>

</xsl:stylesheet>
