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
	<xsl:if test="not(preceding::event[./@id = current()/@id])">
	<!-- need to check because same node may appear in more than one timeline -->
		<xsl:copy-of select="."/>
	</xsl:if>
</xsl:template>


<xsl:template match="event" mode="edge">

	<!--
		Find the next interval, ignoring those that have the same start and end as this interval.
	-->
	<xsl:variable name="after"  select="following-sibling::event[interval/@fm &gt;= current()/interval/@to and not(interval/@fm = current()/interval/@fm and interval/@to = current()/interval/@to)][1]" />
	
	<!-- 
		Link to next interval and any others that start at the same instant
	 -->
	 
	<xsl:apply-templates select="following-sibling::event[interval/@fm = $after/interval/@fm]" mode="linkFrom">
		<xsl:with-param name="source" select="@id"/>
	</xsl:apply-templates>

	<!-- 
		Link also to the first interval that starts within the bounds of the next interval ...
	 -->
	 
	<xsl:apply-templates select="following-sibling::event[interval/@fm &gt; $after/interval/@fm and interval/@fm &lt; $after/interval/@to][1]" mode="linkAlso">
		<xsl:with-param name="source" select="@id"/>
		<xsl:with-param name="limit" select="$after/interval/@to"/>
	</xsl:apply-templates>

	<!-- 
		If this is an instant, link to intervals that start at the same instant - but not $after, which was linked above.
	 -->
	
	<xsl:if test="interval/@fm = interval/@to">
		<xsl:apply-templates select="following-sibling::event[interval/@fm != interval/@to and interval/@fm = current()/interval/@fm and not(interval/@to = $after/interval/@to)]" mode="linkFrom">
			<xsl:with-param name="source" select="@id"/>
		</xsl:apply-templates>
	</xsl:if>

</xsl:template>


<xsl:template match="event" mode="linkAlso">

	<xsl:param name="limit" select="interval/@to"/>
	<xsl:param name="source"/>	
	
	<xsl:apply-templates select="." mode="linkFrom">
		<xsl:with-param name="source" select="$source"/>
	</xsl:apply-templates>
	
	<!-- 
	<xsl:apply-templates select="following-sibling::event[interval/@fm = current()/interval/@fm and interval/@to = current()/interval/@to and not(interval/@fm = interval/@to)]" mode="linkFrom">
		<xsl:with-param name="source" select="@id"/>
	</xsl:apply-templates>
	 -->
	
	<!--  link (recursively) to a span that starts within this span, and before the end of its containing span -->
	<xsl:variable name="newLimit">
		<xsl:choose>
			<xsl:when test="$limit &gt;= interval/@to">
				<xsl:value-of select="interval/@to"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$limit"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:apply-templates select="following-sibling::event[interval/@fm &gt; current()/interval/@fm and interval/@fm &lt; $newLimit][1]" mode="linkAlso">
		<xsl:with-param name="source" select="$source"/>
		<xsl:with-param name="limit" select="$newLimit"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="event" mode="linkFrom">
	<xsl:param name="source"/>
	<xsl:apply-templates select="." mode="makelink">
		<xsl:with-param name="source" select="$source"/>
		<xsl:with-param name="target" select="@id"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="event" mode="makelink">
	<xsl:param name="source"/>
	<xsl:param name="target"/>
	<edge from="{$source}" to="{$target}">
		<xsl:apply-templates select="ancestor::timeline[1]"/>
	</edge>
</xsl:template>


<xsl:template match="timeline">
	<xsl:attribute name="reason"><xsl:value-of select="@name"/></xsl:attribute>
</xsl:template>


<xsl:template match="edge" mode="edge">
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
		<edge from="{@id}" to="{@id}" reason="{$reason}"/>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
