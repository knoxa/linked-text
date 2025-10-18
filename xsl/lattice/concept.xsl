<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


<xsl:template name="getConceptAttributes">
<!--
	The concept is associated with attributes for this node in the lattice and all 'above'
-->
	<xsl:copy-of select=".//attribute"/>
	<xsl:for-each select="//edge[./@from = current()/@id]">
		<xsl:for-each select="//concept[./@id = current()/@to]">
			<xsl:call-template name="getConceptAttributes"/>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>


<xsl:template name="getConceptObjects">
<!--
	The concept is associated with objects for this node in the lattice and all 'below'
-->
	<xsl:copy-of select=".//object"/>
	<xsl:for-each select="//edge[./@to = current()/@id]">
		<xsl:for-each select="//concept[./@id = current()/@from]">
			<xsl:call-template name="getConceptObjects"/>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>


<xsl:template name="getAttributesBelow">
<!--
	
-->
	<xsl:copy-of select=".//attribute"/>
	<xsl:for-each select="//edge[./@to = current()/@id]">
		<xsl:for-each select="//concept[./@id = current()/@from]">
			<xsl:call-template name="getAttributesBelow"/>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
