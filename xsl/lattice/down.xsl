<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" />

<!-- 
	Find concepts with no outgoing edges.
	Assume each of these represents an entity and make an object representing that entity.
	All attributes at this concept and "below" become attributes on this entity object.
 -->
 
 <xsl:import href="concept.xsl"/>
 
 <xsl:param name="prefix" select="'X'"/>

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="//concept" mode="terminal"/>
</context>
</xsl:template>

<xsl:template match="concept" mode="terminal">
	<xsl:if test="not(//edge[@from = current()/@id])">
		<object name="{concat($prefix,@id)}">
			<xsl:call-template name="getAttributesBelow"/>
		</object>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
