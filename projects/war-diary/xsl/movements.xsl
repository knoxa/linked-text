<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:html="http://www.w3.org/1999/xhtml" xmlns:skos="http://www.w3.org/2004/02/skos/core#" exclude-result-prefixes="html" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//html:p[@class = 'tnaref']" />
</temporal>
</xsl:template>

<xsl:template match="html:p[@class = 'tnaref'][. = 'TNA: WO 95/1487/5, p 255']">
	<!-- 4 Div movement table, Aug-Sep 1914  -->
	<skos:notation><xsl:value-of select="."/></skos:notation>
	<xsl:apply-templates select="ancestor::html:article//html:tr" />
</xsl:template>

<xsl:template match="html:p[@class = 'tnaref'][. = 'TNA: WO 95/1439/1/2, p 61']">
	<!-- 4 Div movement table, Sep-Oct 1914  -->
	<skos:notation><xsl:value-of select="."/></skos:notation>
	<xsl:apply-templates select="ancestor::html:article//html:tr" />
	<xsl:apply-templates select="ancestor::html:article//html:tr" mode="transit" />
</xsl:template>

<xsl:template match="html:tr[html:td/html:time]">
<!-- Time of event is in the "Date and Time" column  -->
	<xsl:apply-templates select="html:td[1]" mode="time"/>
</xsl:template>

<xsl:template match="html:tr" mode="transit">
<!-- 
	The "Notes" column may include 'in transit' events - things that happen between
	departure and arrival events.
 -->
	<xsl:apply-templates select="html:td[3]" mode="transit"/>
</xsl:template>

<xsl:template match="html:td[html:span[@class = 'place']]" mode="transit">
<!-- 
	We have an 'in transit' event that mentions a place ...
 -->
	<xsl:variable name="node" select="concat('_:', generate-id())"/>
	<event uri="{$node}">
		<text><xsl:value-of select="normalize-space(.)"/></text>
		<xsl:apply-templates select="*" mode="place"/>
	</event>
	<xsl:variable name="place" select=".//html:span[@class = 'place'][1]"/>
	<xsl:for-each select="../html:td[2]">
		<xsl:variable name="fmnode">
			<xsl:call-template name="getLinkFrom"/>
		</xsl:variable>
		<xsl:variable name="tonode">
			<xsl:call-template name="getLinkTo"/>
		</xsl:variable>
	<link fm="{$fmnode}" to="{$node}"/>
	<link fm="{$node}" to="{$tonode}"/>
	</xsl:for-each>
</xsl:template>

<xsl:template match="html:td" mode="time">
<!-- 
	Get datetime stamp for this event (or events) and the ordinal number (assuming events appear in the
	document in date order). Then create the events ...
 -->
	<xsl:apply-templates select="following::html:td[1]" mode="event">
		<xsl:with-param name="fmpos" select="count(preceding::html:time) + 1"/>
		<xsl:with-param name="topos" select="count(preceding::html:time) + count(./html:time)"/>
		<xsl:with-param name="fmattr" select="./html:time[1]/@datetime"/>
		<xsl:with-param name="toattr" select="./html:time[last()]/@datetime"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="html:td[html:span[@class = 'place']]" mode="event">
<!-- 
	Output an event or events that mention at least one place
 -->
	<xsl:param name="fmattr"/>
	<xsl:param name="toattr"/>
	<xsl:param name="fmpos"/>
	<xsl:param name="topos"/>
	<xsl:choose>
		<xsl:when test="html:span[@class = 'event']">
		<!-- 
			separate departure and arrival events in the same table cell, split them up ...
		 -->
			<xsl:apply-templates select="html:span[@class = 'event']">
				<xsl:with-param name="pos" select="$fmpos"/>
				<xsl:with-param name="fmattr" select="$fmattr"/>
				<xsl:with-param name="toattr" select="$toattr"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
		<!-- 
			Just one event (doesn't matter what), record it ...
		 -->
			<event uri="{concat('_:', generate-id())}" fm="{$fmattr}" to="{$toattr}">
				<text><xsl:value-of select="normalize-space(.)"/></text>
				<interval fm="{$fmpos}" to="{$topos}"/>
				<xsl:apply-templates select="*" mode="place"/>
			</event>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="html:span[@class = 'event']">
	<!-- 
		One of two events (either arrival or departure) linked to the same date. Make them sequential by adding
		the position of the event (assuming they appear in the document in time order) as a decimal place on the interval number. 
	 -->
	<xsl:param name="fmattr"/>
	<xsl:param name="toattr"/>
	<xsl:param name="pos"/>
	<xsl:variable name="thispos"><xsl:value-of select="concat($pos, '.', position())"/></xsl:variable>
	<event uri="{concat('_:', generate-id())}" fm="{$fmattr}" to="{$toattr}">
		<text><xsl:value-of select="normalize-space(.)"/></text>
		<interval fm="{$thispos}" to="{$thispos}"/>
		<xsl:apply-templates select="*" mode="place"/>
	</event>
</xsl:template>


<xsl:template match="html:*" mode="place">
	<xsl:apply-templates select="*" mode="place"/>
</xsl:template>

<xsl:template match="html:span" mode="place">
	<entity type="place"><xsl:value-of select="normalize-space(.)"/></entity>
</xsl:template>

<xsl:template match="html:tr"/>
<xsl:template match="html:p"/>
<xsl:template match="html:span"/>
<xsl:template match="html:td" mode="event"/>
<xsl:template match="html:td" mode="transit"/>

<xsl:template name="getLinkTo">
	<!-- 
		If the text say 'arrived' then the transit event was before this event, otherwise its before the next event that mentions a place.
	 -->
	<xsl:choose>
		<xsl:when test="html:span[@class = 'place'] and contains(., 'arrived')">
			<xsl:value-of select="concat('_:', generate-id())"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="following::html:tr[html:td[2]/html:span[@class ='place']][1]/html:td[2]">
				<xsl:call-template name="getLinkTo"/>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="getLinkFrom">
	<!-- 
		If the text say 'marched' then the transit event was after this event, otherwise its after the previous event that mentions a place.
	 -->
	<xsl:choose>
		<xsl:when test="contains(., 'marched')">
			<xsl:value-of select="concat('_:', generate-id())"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat('_:', generate-id(preceding::html:tr[html:td[2]/html:span[@class ='place']][1]/html:td[2]))"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
