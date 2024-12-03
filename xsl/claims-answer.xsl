<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:exsl="http://exslt.org/common" version="1.0">

<xsl:output method="text" encoding="utf-8" />


<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/rdfa-ntriples.xsl"/>

<xsl:template match="/|*" mode="answer">
	<xsl:apply-templates select="*" mode="answer"/>
</xsl:template>

<xsl:template match="html:article[@class = 'answer-list']" mode="answer">
	<xsl:apply-templates select="html:div" mode="make-answer">
		<xsl:with-param name="premise" select="concat('&lt;', @about, '&gt;')"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="html:div" mode="make-answer">
	<xsl:param name="premise"/>
	<xsl:call-template name="aif-tanode">
		<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
		<xsl:with-param name="claimText" select="'answering'"/>
		<xsl:with-param name="premises">
			<premise><xsl:value-of select="$premise"/></premise>
		</xsl:with-param>
		<xsl:with-param name="conclusion">
			<xsl:value-of select="concat('&lt;', html:*[@about][1]/@about, '&gt;')"/>
		</xsl:with-param>
	</xsl:call-template>	
</xsl:template>


<xsl:template match="html:*[@class = 'answer']" mode="answer">
<xsl:variable name="premise" select="concat('&lt;', @about, '&gt;')"/>
	<xsl:variable name="typelist">
		<xsl:call-template name="getTypeList">
			<xsl:with-param name="text" select="@resource"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:for-each select="exsl:node-set($typelist)/type">
		<xsl:call-template name="aif-tanode">
			<xsl:with-param name="nodeid" select="concat('_:', generate-id())"/>
			<xsl:with-param name="claimText" select="'answering'"/>
			<xsl:with-param name="premises">
				<premise><xsl:value-of select="$premise"/></premise>
			</xsl:with-param>
			<xsl:with-param name="conclusion">
				<xsl:value-of select="."/>
			</xsl:with-param>
		</xsl:call-template>	
	</xsl:for-each>	
</xsl:template>

</xsl:stylesheet>
