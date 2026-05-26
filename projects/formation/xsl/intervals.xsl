<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
<xsl:copy>
	<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
</xsl:copy>
</xsl:template>

<xsl:template match="event[not(preceding-sibling::event[./interval/@fm = current()/interval/@fm and ./interval/@to = current()/interval/@to])]">
	<event uri="{generate-id()}" fm="{@fm}" to="{@to}">
		<text>
			<xsl:choose>
				<xsl:when test="@fm = @to"><xsl:value-of select="@fm"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat(@fm, ' - ', @to)"/></xsl:otherwise>
			</xsl:choose>
		</text>
		<xsl:copy-of select="interval"/>
	</event>
</xsl:template>

<xsl:template match="event"/>

</xsl:stylesheet>
