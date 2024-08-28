<xsl:stylesheet  xmlns="http://graphml.graphdrawing.org/xmlns" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

Make a graph of events linked in time order. Input events must have been sorted in time order.

 -->

<xsl:template match="/">
<graphml>    
	<key attr.name="id" attr.type="string" for="node" id="id"/>
    <key attr.name="url" attr.type="string" for="node" id="url"/>
    <key attr.name="text" attr.type="string" for="node" id="text"/>
    <key attr.name="entity" attr.type="string" for="edge" id="entity"/>
	<graph>
		<xsl:apply-templates select="//event" mode="node" />
		<xsl:apply-templates select="//event" mode="edge" />
		<xsl:apply-templates select="//link" />
	</graph>
</graphml>
</xsl:template>


<xsl:template match="event" mode="node">
	<node id="{@uri}">
		<data key="id"><xsl:value-of select="@uri"/></data>
		<data key="text"><xsl:value-of select="@label"/></data>
		<data key="url"><xsl:value-of select="@uri"/></data>
	</node>
</xsl:template>


<xsl:template match="event" mode="edge">
	<xsl:variable name="eventType">
		<xsl:choose>
			<xsl:when test="interval[1]/@fm = interval[1]/@to">
				<xsl:value-of select="'instant'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'interval'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- 
		Intervals are open real intervals,  so are "before" their end instant, and we want to link to the first interval
		with start "greater than or equals" to the end of the current interval.
		
		For the purposes here, instants are treated as intervals that start and end at the same time.
	-->
	<xsl:apply-templates select="following-sibling::event[interval[1]/@fm &gt;= current()/interval[1]/@to][1]" mode="link">
		<xsl:with-param name="source" select="@uri">
			<xsl:with-param name="eventType" select="$eventType"/>
		</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="event" mode="link">
	<xsl:param name="source"/>
	<xsl:param name="eventType"/>
	<edge source="{$source}" target="{@uri}">
		<data key="entity"><xsl:value-of select="interval[1]/@datefm"/></data>
	</edge>
	<!-- 
	the same source node should also link to any intervals that start within this interval 
	 -->
	<xsl:if test="interval[1]/@fm &lt; interval[1]/@to">
		<xsl:apply-templates select="following-sibling::event[./interval[1]/@fm &gt;= current()/interval[1]/@fm][./interval[1]/@fm &lt; current()/interval[1]/@to][1]" mode="also">
			<xsl:with-param name="source" select="$source"/>
				<xsl:with-param name="limit" select="number(interval[1]/@to)"/>
		</xsl:apply-templates>	 
	</xsl:if>	 
	<!-- 
	the same source node should also link to any instants that are equal to this instant
	 -->
	<xsl:if test="interval[1]/@fm = interval[1]/@to">
		<xsl:apply-templates select="following-sibling::event[./interval[1]/@fm = current()/interval[1]/@fm][./interval[1]/@to = current()/interval[1]/@to]" mode="also">
			<xsl:with-param name="source" select="$source"/>
				<xsl:with-param name="limit" select="number(interval[1]/@to)"/>
		</xsl:apply-templates>	 
	</xsl:if>	 
</xsl:template>


<xsl:template match="event" mode="also">
	<xsl:param name="source"/>
	<xsl:param name="eventType"/>
	<xsl:param name="limit"/>	
	<edge source="{$source}" target="{@uri}">
	</edge>
	<!-- 
	the same source node should also link to any intervals that start within this interval, but before the end of the first interval linked
	 -->
	<xsl:if test="interval[1]/@fm &lt; interval[1]/@to">
		<xsl:apply-templates select="following-sibling::event[./interval[1]/@fm &gt;= current()/interval[1]/@fm][./interval[1]/@fm &lt; current()/interval[1]/@to][./interval[1]/@fm &lt; $limit][1]" mode="also">
			<xsl:with-param name="source" select="$source"/>
				<xsl:with-param name="limit" select="$limit"/>
		</xsl:apply-templates>	 
	</xsl:if>	 
</xsl:template>


<xsl:template match="link">
	<edge source="{@fm}" target="{@to}" />
</xsl:template>

</xsl:stylesheet>
