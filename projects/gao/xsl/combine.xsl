<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" indent="yes"/>
<xsl:param name="dataset-date"/>
<xsl:param name="dataset-rank"/>
<xsl:param name="dataset-repeat"/>
<xsl:param name="dataset-hole"/>

<xsl:variable name="date" select="document($dataset-date)"/>
<xsl:variable name="rank" select="document($dataset-rank)"/>
<xsl:variable name="repeat" select="document($dataset-repeat)"/>
<xsl:variable name="hole" select="document($dataset-hole)"/>


<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="html:article">
<xsl:copy>
	<xsl:copy-of select="@*"/>
	<xsl:copy-of select="*"/>
	<xsl:apply-templates select="$date//person[@sort = current()/html:h4]"/>
	<xsl:apply-templates select="$rank//person[@sort = current()/html:h4]"/>
	<xsl:apply-templates select="$repeat//person[@sort = current()/html:h4]"/>
	<xsl:apply-templates select="$hole//person[@sort = current()/html:h4]"/>
</xsl:copy>
</xsl:template>

<xsl:template match="person">
	<html:div class="comment">
		<xsl:apply-templates select=".//claim"/>
	</html:div>
</xsl:template>

<xsl:template match="claim">
	<html:p class="claim"><xsl:value-of select="."/></html:p>
</xsl:template>

</xsl:stylesheet>
