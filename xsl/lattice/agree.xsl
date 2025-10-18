<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="concept.xsl"/>

<xsl:output method="xml" encoding="utf-8" />

<!-- 
	This is for the case where a set of attributes assigned to an object represents a hypothesis about that object.
	If we have hypotheses from several agents, we can make a disjoint union and apply FCA. Where agents agree
	about a hypothesis, there will be a concept with objects from both. Full agreement of N agents results in
	concepts with N objects. We can find these and output an 'agreed' context.
 -->

<xsl:param name="numAgents" select="2"/>

<xsl:template match="lattice">
<context>
	<xsl:apply-templates select="concept"/>
</context>
</xsl:template>

<xsl:template match="concept">
<xsl:if test="count(object) = $numAgents">
	<object name="{generate-id()}">
		<xsl:call-template name="getConceptAttributes"/>
	</object>
</xsl:if>
</xsl:template>

</xsl:stylesheet>
