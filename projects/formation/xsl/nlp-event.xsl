<?xml version="1.0"?>
<xsl:stylesheet xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="nlp">

<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<!-- 
	Convert Baleen XML to events
 -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//nlp:document"/>
	<event id="#1" fm="1899-10-11" to="1899-10-11">
		<text>Start of the Second Boer War</text>
	</event>
	<event id="#2" fm="1902-05-31" to="1902-05-31">
		<text>End of the Second Boer War</text>
	</event>
	<event id="#3" fm="1914-07-28" to="1914-07-28">
		<text>Start of the First World War</text>
	</event>
	<event id="#4" fm="1918-11-11" to="1918-11-11">
		<text>End of the First World War</text>
	</event>
	<event id="#5" fm="1939-09-01" to="1939-09-01">
		<text>Start of the Second World War</text>
	</event>
	<event id="#6" fm="1945-09-02" to="1945-09-02">
		<text>End of the Second World War</text>
	</event>
</temporal>
</xsl:template>

<xsl:template match="nlp:document">
	<xsl:apply-templates select="nlp:sentence"/>
</xsl:template>

<xsl:template match="nlp:sentence">

	<xsl:variable name="text">
		<xsl:value-of select="normalize-space(substring(../nlp:text, @begin + 1, @end - @begin))"/>
	</xsl:variable>

	<xsl:variable name="hash">
		<xsl:call-template name="hashMD5">
			<xsl:with-param name="text" select="$text"/>
		</xsl:call-template>
	</xsl:variable>

	<event id="{generate-id()}">
	<xsl:apply-templates select="nlp:token[nlp:lemma[@type = 'DATE' or @penn = 'CD' or @type = 'INTERVAL']]" mode="date" />
	<xsl:apply-templates select="nlp:token[nlp:surface = 'the First World War']" mode="interval" />
	<xsl:apply-templates select="nlp:token[nlp:surface = 'the Second World War']" mode="interval" />
	<xsl:apply-templates select="nlp:token[nlp:surface = 'the Second Boer War']" mode="interval" />
	<xsl:apply-templates select="nlp:token[nlp:lemma = 'between']" mode="interval" />
		<text hash="{$hash}"><xsl:value-of select="$text"/></text>
		<xsl:apply-templates select="./nlp:token" mode="unit"/>
	</event>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'DATE']][preceding-sibling::nlp:token[1][./nlp:lemma = 'from' or ./nlp:lemma = 'form']]" mode="date">
	<xsl:attribute name="fm"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'DATE']][preceding-sibling::nlp:token[1][./nlp:lemma = 'to']]" mode="date">
	<xsl:attribute name="to"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'DATE']][not(preceding-sibling::nlp:token/nlp:lemma/@type = 'DATE')][preceding-sibling::nlp:token[1][./nlp:lemma = 'on']]" mode="date">
	<xsl:attribute name="fm"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
	<xsl:attribute name="to"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'DATE']][preceding-sibling::nlp:token/nlp:lemma/@type = 'DATE'][preceding-sibling::nlp:token[1][./nlp:lemma = 'on']]" mode="date">
	<xsl:attribute name="to"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@penn = 'CD']][not(preceding-sibling::nlp:token/nlp:lemma/@type = 'DATE')][preceding-sibling::nlp:token[1][./nlp:lemma = 'in']]" mode="date">
	<xsl:attribute name="fm"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
	<xsl:attribute name="to"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma = 'between']" mode="interval">
	<xsl:attribute name="fm"><xsl:value-of select="following::nlp:lemma[@type = 'DATE'][1]"/></xsl:attribute>
	<xsl:attribute name="to"><xsl:value-of select="following::nlp:lemma[@type = 'DATE'][2]"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@penn = 'CD']][preceding-sibling::nlp:token/nlp:lemma/@type = 'DATE'][preceding-sibling::nlp:token[1][./nlp:lemma = 'in']]" mode="date">
	<xsl:attribute name="to"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'DATE']][preceding-sibling::nlp:token[2][./nlp:lemma = 'establish']][preceding-sibling::nlp:token[1][./nlp:lemma = 'in']]" mode="date">
	<xsl:attribute name="fm"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'DATE']][preceding-sibling::nlp:token[2][./nlp:lemma = 'dissolve']][preceding-sibling::nlp:token[1][./nlp:lemma = 'in' or ./nlp:lemma = 'on']]" mode="date">
	<xsl:attribute name="to"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@penn = 'CD']][preceding-sibling::nlp:token[1][./nlp:lemma = 'until']]" mode="date">
	<xsl:attribute name="to"><xsl:value-of select="nlp:lemma"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'INTERVAL']]" mode="date">
	<xsl:apply-templates select="nlp:token" mode="interval" />
</xsl:template>

<xsl:template match="nlp:token[nlp:surface = 'the Second Boer War'][preceding-sibling::nlp:token[1][./nlp:lemma = 'during']]" mode="interval">
	<xsl:attribute name="fm"><xsl:value-of select="'1899-10-11'"/></xsl:attribute>
	<xsl:attribute name="to"><xsl:value-of select="'1902-05-31'"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:surface = 'the First World War'][preceding-sibling::nlp:token[1][./nlp:lemma = 'during' or ./nlp:lemma = 'throughout']]" mode="interval">
	<xsl:attribute name="fm"><xsl:value-of select="'1914-07-28'"/></xsl:attribute>
	<xsl:attribute name="to"><xsl:value-of select="'1918-11-11'"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:surface = 'the Second World War'][preceding-sibling::nlp:token[1][./nlp:lemma = 'during' or ./nlp:lemma = 'throughout']]" mode="interval">
	<xsl:attribute name="fm"><xsl:value-of select="'1939-09-01'"/></xsl:attribute>
	<xsl:attribute name="to"><xsl:value-of select="'1945-09-02'"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:surface = 'the First World War'][preceding-sibling::nlp:token[2][./nlp:lemma = 'end'] and preceding-sibling::nlp:token[1][./nlp:lemma = 'of']]" mode="interval">
	<xsl:attribute name="to"><xsl:value-of select="'1918-11-11'"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:surface = 'the Second World War'][preceding-sibling::nlp:token[2][./nlp:lemma = 'end'] and preceding-sibling::nlp:token[1][./nlp:lemma = 'of']]" mode="interval">
	<xsl:attribute name="to"><xsl:value-of select="'1945-09-02'"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:surface = 'the Second World War'][preceding-sibling::nlp:token[2][./nlp:lemma = 'start'] and preceding-sibling::nlp:token[1][./nlp:lemma = 'of']]" mode="interval">
	<xsl:attribute name="fm"><xsl:value-of select="'1939-09-01'"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:surface = 'the First World War'][preceding-sibling::nlp:token[2][./nlp:lemma = 'start'] and preceding-sibling::nlp:token[1][./nlp:lemma = 'of']]" mode="interval">
	<xsl:attribute name="fm"><xsl:value-of select="'1914-07-28'"/></xsl:attribute>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[@type = 'UNIT']]" mode="unit">
	<entity type="unit"><xsl:value-of select="nlp:lemma"/></entity>
</xsl:template>

<xsl:template match="nlp:token" mode="unit">
	<xsl:apply-templates select="nlp:token" mode="unit"/>
</xsl:template>

<xsl:template match="*" mode="date" />
<xsl:template match="*" mode="interval" />

</xsl:stylesheet>
