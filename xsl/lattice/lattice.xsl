<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt" version="1.0">


<xsl:template name="makeDownPath">
<!-- 
	Create a directed (down) set of nodes starting at this node.
 -->
	<node id="{@id}" dist="0"/>
	<xsl:for-each select="//edge[./@to = current()/@id]">
		<xsl:call-template name="extendDownPath"/>
	</xsl:for-each>
</xsl:template>


<xsl:template name="makeUpPath">
<!-- 
	Create a directed (up) set of nodes starting at this node.
 -->
	<node id="{@id}" dist="0"/>
	<xsl:for-each select="//edge[./@from = current()/@id]">
		<xsl:call-template name="extendUpPath"/>
	</xsl:for-each>
</xsl:template>


<xsl:template name="extendDownPath">
<!-- 
	Follow directed edges backwards, collecting nodes.
 -->
	<xsl:param name="dist" select="'1'"/>
	<node id="{@from}" dist="{$dist}"/>
	<xsl:for-each select="//edge[./@to = current()/@from]">
		<xsl:call-template name="extendDownPath">
			<xsl:with-param name="dist" select="number($dist) + 1"/>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>


<xsl:template name="extendUpPath">
<!-- 
	Follow directed edges forwards, collecting nodes.
 -->
	<xsl:param name="dist" select="'1'"/>
	<node id="{@to}" dist="{$dist}"/>
	<xsl:for-each select="//edge[./@from = current()/@to]">
		<xsl:call-template name="extendUpPath">
			<xsl:with-param name="dist" select="number($dist) + 1"/>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>


<xsl:template name="getIntersection">
<!-- 
	"setA" and "setB" are directed sets of nodes reachable from DAG nodes A and B.
	Return the intersection of this set sorted in ascending order of the @dist attribute.
	If the nodes are from a complete lattice the first element of the returned list will
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


<xsl:template name="getMeet">
	<xsl:param name="nodeA"/>
	<xsl:param name="nodeB"/>
	<xsl:variable name="setA">
		<xsl:for-each select="$nodeA">
			<xsl:call-template name="makeDownPath"/>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="setB">
		<xsl:for-each select="$nodeB">
			<xsl:call-template name="makeDownPath"/>
		</xsl:for-each>
	</xsl:variable>	
	<xsl:variable name="intersection">
		<xsl:call-template name="getIntersection">
			<xsl:with-param name="setA" select="$setA"/>
			<xsl:with-param name="setB" select="$setB"/>
		</xsl:call-template>
	</xsl:variable>
	<!-- For a complete lattice there should be only one node here with the minimum distance - could test for that ... -->
	<xsl:value-of select="exslt:node-set($intersection)/node[1]/@id"/>
</xsl:template>


<xsl:template name="getJoin">
	<xsl:param name="nodeA"/>
	<xsl:param name="nodeB"/>
	<xsl:variable name="setA">
		<xsl:for-each select="$nodeA">
			<xsl:call-template name="makeUpPath"/>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="setB">
		<xsl:for-each select="$nodeB">
			<xsl:call-template name="makeUpPath"/>
		</xsl:for-each>
	</xsl:variable>	
	<xsl:variable name="intersection">
		<xsl:call-template name="getIntersection">
			<xsl:with-param name="setA" select="$setA"/>
			<xsl:with-param name="setB" select="$setB"/>
		</xsl:call-template>
	</xsl:variable>
	<!-- For a complete lattice there should be only one node here with the minimum distance - could test for that ... -->
	<xsl:value-of select="exslt:node-set($intersection)/node[1]/@id"/>
</xsl:template>

</xsl:stylesheet>
