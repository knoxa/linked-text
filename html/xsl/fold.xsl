<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<!-- 
 	Indent normalized XHTML to aid readability.
 	Naive XML indenting would introduce unwanted whitespace in <sup> elements.
 -->

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="html:span|html:datetime">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template> 

<xsl:template match="html:article">
	<xsl:text>&#10;</xsl:text>
	<xsl:text>&#10;</xsl:text>
	<xsl:copy>
		<xsl:text>&#10;</xsl:text>
		    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
		<xsl:text>&#10;</xsl:text>
	</xsl:copy>
</xsl:template> 

<xsl:template match="html:p">
	<xsl:copy>
		<xsl:text>&#10;</xsl:text>
		    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
		<xsl:text>&#10;</xsl:text>
	</xsl:copy>
</xsl:template> 

<xsl:template match="html:*" mode="noindent">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template> 

<xsl:template match="html:sup">
	<xsl:copy>
	    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()" mode="noindent"/>
	</xsl:copy>
</xsl:template> 

</xsl:stylesheet>
