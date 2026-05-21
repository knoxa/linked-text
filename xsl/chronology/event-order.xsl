<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<!-- 

	Make a graph of events linked in time order. Input events must have been sorted in time order.
	If the input is grouped into timelines, edges will only be made between nodes in the same timeline.

 -->

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="temporal">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates select="//event" mode="node"/>
		<xsl:apply-templates select="*" mode="edge"/>
		<xsl:apply-templates select="//timeline" mode="state"/>
	</xsl:copy>
</xsl:template>


<xsl:template match="event" mode="node">
	<xsl:if test="not(preceding::event[./@uri = current()/@uri])">
	<!-- need to check because same node may appear in more than one timeline -->
		<xsl:copy-of select="."/>
	</xsl:if>
</xsl:template>


<xsl:template match="event" mode="edge">

	<!--
		Find the next and previous intervals, ignoring those that have the same start and end as this interval.
	-->
	<xsl:variable name="after"  select="following-sibling::event[interval/@fm &gt;= current()/interval/@to and not(interval/@fm = current()/interval/@fm and interval/@to = current()/interval/@to)][1]" />
	<xsl:variable name="before" select="preceding-sibling::event[interval/@to &lt;= current()/interval/@fm and not(interval/@fm = current()/interval/@fm and interval/@to = current()/interval/@to)][1]" />
	
	<!-- 
		Link to next interval (and any of the the same span)
	 -->
	<xsl:apply-templates select="following-sibling::event[interval/@fm = $after/interval/@fm and interval/@to = $after/interval/@to]" mode="linkFrom">
		<xsl:with-param name="source" select="@uri"/>
	</xsl:apply-templates>

	<!-- 
		Link to previous interval (and any of the same span).
		This will create some duplicate edges - so need to apply 'filter-duplicate-edge.xsl' to the results of this transform.
	 -->
	<xsl:apply-templates select="preceding-sibling::event[interval/@fm = $before/interval/@fm and interval/@to = $before/interval/@to]" mode="linkTo">
		<xsl:with-param name="target" select="@uri"/>
	</xsl:apply-templates>

</xsl:template>


<xsl:template match="event" mode="linkFrom">
	<xsl:param name="source"/>
	<xsl:apply-templates select="." mode="makelink">
		<xsl:with-param name="source" select="$source"/>
		<xsl:with-param name="target" select="@uri"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="event" mode="linkTo">
	<xsl:param name="target"/>
	<xsl:apply-templates select="." mode="makelink">
		<xsl:with-param name="source" select="@uri"/>
		<xsl:with-param name="target" select="$target"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="event" mode="makelink">
	<xsl:param name="source"/>
	<xsl:param name="target"/>
	<link fm="{$source}" to="{$target}">
		<xsl:apply-templates select="ancestor::timeline[1]"/>
	</link>
</xsl:template>


<xsl:template match="timeline">
	<xsl:attribute name="reason"><xsl:value-of select="@name"/></xsl:attribute>
</xsl:template>


<xsl:template match="link" mode="edge">
	<xsl:copy-of select="."/>
</xsl:template>


<xsl:template match="timeline" mode="edge">
	<xsl:apply-templates select="*" mode="edge"/>
</xsl:template>


<xsl:template match="timeline" mode="state">
	<!-- 
		Make the last event in a timeline link to itself.
		If the nodes are about changes in the state of an entity, then the links are the entity.
	 -->
	<xsl:variable name="reason" select="@name"/>
	<xsl:for-each select="./event[last()]">
		<link fm="{@uri}" to="{@uri}" reason="{$reason}"/>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
