<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt" version="1.0">


<xsl:template name="makeDownPath">
<!-- 
	Create a directed (down) set of nodes starting at this node.
 -->
	<xsl:variable name="start"><node id="{@id}" dist="0"/></xsl:variable>
	<xsl:variable name="result">
		<xsl:copy-of select="$start"/>
		<xsl:call-template name="extendDownPath">
			<xsl:with-param name="nodes" select="$start"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:call-template name="dedupe">
		<xsl:with-param name="nodes" select="$result"/>
	</xsl:call-template>
</xsl:template>


<xsl:template name="makeUpPath">
<!-- 
	Create a directed (up) set of nodes starting at this node.
 -->
	<xsl:variable name="start"><node id="{@id}" dist="0"/></xsl:variable>
	<xsl:variable name="result">
		<xsl:copy-of select="$start"/>
		<xsl:call-template name="extendUpPath">
			<xsl:with-param name="nodes" select="$start"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:call-template name="dedupe">
		<xsl:with-param name="nodes" select="$result"/>
	</xsl:call-template>
</xsl:template>


<xsl:template name="extendDownPath">
	<xsl:param name="dist" select="'1'"/>
	<xsl:param name="nodes"/>
	<xsl:variable name="step">
		<xsl:call-template name="getFromNodesToThis">
			<xsl:with-param name="dist"  select="$dist"/>
			<xsl:with-param name="nodes" select="$nodes"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:if test="count(exslt:node-set($step)/node) &gt; 0">
		<xsl:copy-of select="$step"/>
		<xsl:call-template name="extendDownPath">
			<xsl:with-param name="dist"  select="number($dist) + 1"/>
			<xsl:with-param name="nodes" select="$step"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>


<xsl:template name="extendUpPath">
	<xsl:param name="dist" select="'1'"/>
	<xsl:param name="nodes"/>
	<xsl:variable name="step">
		<xsl:call-template name="getToNodesFromThis">
			<xsl:with-param name="dist"  select="$dist"/>
			<xsl:with-param name="nodes" select="$nodes"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:if test="count(exslt:node-set($step)/node) &gt; 0">
		<xsl:copy-of select="$step"/>
		<xsl:call-template name="extendUpPath">
			<xsl:with-param name="dist"  select="number($dist) + 1"/>
			<xsl:with-param name="nodes" select="$step"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>


<xsl:template name="getFromNodesToThis">
	<xsl:param name="dist" select="'1'"/>
	<xsl:param name="nodes"/>
	<xsl:variable name="bag">
		<xsl:for-each select="exslt:node-set($nodes)/node">
			<xsl:for-each select="//edge[./@to = current()/@id]">
				<node id="{@from}" dist="{$dist}"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:variable>
	<xsl:call-template name="dedupe">
		<xsl:with-param name="nodes" select="$bag"/>
	</xsl:call-template>
</xsl:template>


<xsl:template name="getToNodesFromThis">
	<xsl:param name="dist" select="'1'"/>
	<xsl:param name="nodes"/>
	<xsl:variable name="bag">
		<xsl:for-each select="exslt:node-set($nodes)/node">
			<xsl:for-each select="//edge[./@from = current()/@id]">
				<node id="{@to}" dist="{$dist}"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:variable>
	<xsl:call-template name="dedupe">
		<xsl:with-param name="nodes" select="$bag"/>
	</xsl:call-template>
</xsl:template>


<xsl:template name="dedupe">
	<xsl:param name="nodes"/>
	<xsl:for-each select="exslt:node-set($nodes)/node">
		<xsl:if test="not(preceding-sibling::node[./@id = current()/@id])">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:template>


<xsl:template name="getIntersection">
<!-- 
	"setA" and "setB" are directed sets of nodes reachable from DAG nodes A and B.
	Return the intersection of this set sorted in ascending order of the @dist attribute.
	If the nodes are from a complete lattice, the first element of the returned list will
	be the meet/join of A and B (according to the direction of the sets).  
 -->
	<xsl:param name="setA"/>
	<xsl:param name="setB"/>
	<xsl:variable name="nodeSetA" select="exslt:node-set($setA)"/>
	<xsl:variable name="nodeSetB" select="exslt:node-set($setB)"/>
	<xsl:for-each select="$nodeSetB/node">
		<xsl:sort select="@dist"/>
		<xsl:if test="$nodeSetA/node[@id = current()/@id]">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:template>


<xsl:template name="getBminusA">
<!-- 
	"setA" and "setB" are directed sets of nodes reachable from DAG nodes A and B.
 -->
	<xsl:param name="setA"/>
	<xsl:param name="setB"/>
	<xsl:variable name="nodeSetA" select="exslt:node-set($setA)"/>
	<xsl:variable name="nodeSetB" select="exslt:node-set($setB)"/>
	<xsl:for-each select="$nodeSetB/node">
		<xsl:if test="not($nodeSetA/node[@id = current()/@id])">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
