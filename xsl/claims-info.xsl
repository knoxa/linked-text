<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="text" encoding="utf-8" />

<xsl:import href="file:///D:/GitHub/eleatics/argumentation/xsl/aif.xsl"/>
<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>
<xsl:import href="rewrite.xsl"/>

<!-- Make this a named template ...  -->
<xsl:template match="html:*[contains(@class, 'claim') or contains(@class, 'premise')  or contains(@class, 'conclusion')  or contains(@class, 'question')  or contains(@class, 'rewrite')]" mode="list">
	<xsl:call-template name="makeInformationNode"/>
	<xsl:apply-templates select="*" mode="list"/>
</xsl:template>


<!-- Anything with class 'refer' is referring to another argument, so nothing to do in this case. -->
<xsl:template match="html:*[contains(@class, 'refer')]" mode="list"/>


<xsl:template match="html:blockquote" mode="list">
	<xsl:variable name="text">
		<xsl:apply-templates select="." mode="ellipsis" />
	</xsl:variable>
	<xsl:call-template name="aif-inode">
		<xsl:with-param name="nodeid" select="concat('&lt;', @about, '&gt;')"/>
		<xsl:with-param name="claimText" select="normalize-space($text)"/>
	</xsl:call-template>
	<xsl:apply-templates select="*" mode="list"/>
</xsl:template>


<xsl:template match="html:*[@class = 'ref']" mode="list">
<!-- 
	<xsl:variable name="text">
		<xsl:value-of select="normalize-space()"/>
	</xsl:variable>
	<xsl:call-template name="aif-inode">
		<xsl:with-param name="nodeid" select="concat('&lt;', ../@about, '&gt;')"/>
		<xsl:with-param name="claimText" select="$text"/>
	</xsl:call-template>
	<xsl:apply-templates select="*" mode="list"/>
 -->
</xsl:template>


<xsl:template match="/|*" mode="list">
	<xsl:apply-templates select="*" mode="list"/>
</xsl:template>

<xsl:template match="html:*" mode="ellipsis">
	<xsl:apply-templates select="*|text()" mode="ellipsis"/>
</xsl:template>

<xsl:template match="text()" mode="ellipsis">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="html:span[@class = 'ellipsis']" mode="ellipsis"/>

</xsl:stylesheet>
