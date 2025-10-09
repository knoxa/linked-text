<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

	Make a graph of events linked in time order. Input events must have been sorted in time order.
	If the input is partitioned, edges will only be made between nodes in the same partition.

 -->

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="temporal">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates select="//event" mode="node"/>
		<xsl:apply-templates select="*" mode="edge"/>
		<xsl:apply-templates select="//partition" mode="state"/>
	</xsl:copy>
</xsl:template>


<xsl:template match="event" mode="node">
	<xsl:if test="not(preceding::event[./@uri = current()/@uri])">
	<!-- need to check because same node may appear in more than one partition -->
		<xsl:copy-of select="."/>
	</xsl:if>
</xsl:template>


<xsl:template match="event" mode="edge">

	<!-- Find the next interval (in the sort order) that is after this one -->
	<xsl:variable name="after" select="following-sibling::event[interval/@fm &gt;= current()/interval/@to][1]" />

	<!-- 
		Set "limit" to the end of the first following interval that doesn't itself contain an interval.
		Need to search recursively, starting with "after" and descending recursively through the first contained interval. 
	-->
	<xsl:variable name="limit">
		<xsl:apply-templates select="$after" mode="limit"/>
	</xsl:variable>
	
	<!-- 
		Link to all the all intervals that start between the start of "after" and the limit.
		If "after" doesn't have any nested intervals, the limit will be the end of "after". In this case, the interval must start before the end of "after" if "after" isn't an instant.
	 -->
	<xsl:apply-templates select="following-sibling::event[interval/@fm &gt;= $after/interval/@fm and interval/@fm &lt;= number($limit) and (interval/@fm &lt; $after/interval/@to or $after/interval/@fm = $after/interval/@to)]" mode="linkFrom">
		<xsl:with-param name="source" select="@uri"/>
	</xsl:apply-templates>
	
</xsl:template>


<xsl:template match="event" mode="limit">

	<!--  get first contained interval -->
	<xsl:variable name="nested" select="following-sibling::event[interval/@fm &gt; current()/interval/@fm and interval/@to &lt;= current()/interval/@to][1]" />
	
	<xsl:choose>
		<xsl:when test="$nested">
			<!-- If it exists, recursively call this same template with the contained interval -->
			<xsl:apply-templates select="$nested" mode="limit"/>
		</xsl:when>
		<xsl:otherwise>
			<!-- No child interval, end of recursion, report the end of this one  -->
			<xsl:text><xsl:value-of select="interval[1]/@to"/></xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="event" mode="linkFrom">
	<xsl:param name="source"/>
	<link fm="{$source}" to="{@uri}">
		<!-- Add "link reason" to this link if the event is in a partion  -->
		<xsl:apply-templates select="ancestor::partition[1]"/>
	</link>
</xsl:template>


<xsl:template match="partition">
	<xsl:attribute name="reason"><xsl:value-of select="@name"/></xsl:attribute>
</xsl:template>


<xsl:template match="link" mode="edge">
	<xsl:copy-of select="."/>
</xsl:template>


<xsl:template match="partition" mode="edge">
	<xsl:apply-templates select="*" mode="edge"/>
</xsl:template>


<xsl:template match="partition" mode="state">
	<!-- 
		Make the last event in a partition link to itself.
		If the nodes are about changes in the state of an entity, then the links are the entity.
	 -->
	<xsl:variable name="reason" select="@name"/>
	<xsl:for-each select="./event[last()]">
		<link fm="{@uri}" to="{@uri}" reason="{$reason}"/>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
