<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" />

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<!-- 
 -->

<xsl:template match="html:p[@typeof = 'ies:State']|html:span[@typeof = 'ies:State']"/>

<xsl:template match="html:p[@typeof = 'ies:State'][descendant-or-self::*/@resource = '#1Bn' or descendant-or-self::*/@resource = '#2Bn']">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="html:p[@typeof = 'ies:State'][.//@about = '#1Bn' or .//@about = '#2Bn']">
	<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
