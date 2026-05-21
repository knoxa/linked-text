<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<!--
	Add an 'interval' element to each event. This has 'fm' and 'to' attributes that are integers. Bigger numbers represent
	later times. An instant is an interval where 'fm' is the same as 'to'.
-->

<xsl:template match="/|*|@*|comment()|processing-instruction()|text()">
	<xsl:copy>
		<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
	</xsl:copy>
</xsl:template>


<xsl:template match="event[@fm][@to]">
	<!-- 
		Construct interval element. The @fm and @to attributes on 'event' are dates of the form:
		YYYY-MM-DD, YYYY-MM or YYYY (XSDDate, XSDMonth or XSDYear).
		The @fm and @to elements on 'interval' must be 8 digit integers, so padding characters are added when the date is XSDMonth or XSDYear.
		Depending on the interpretation, @to (or @from) a month (or year) might mean to the beginning of the month, or to the end of the month.
		Different padding can be used for different interpretations. 
	 -->
	<xsl:copy>
		<xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
		
		<xsl:variable name="fm">
		<xsl:call-template name="getDateAsSortableInteger">
			<xsl:with-param name="text" select="@fm"/>
			<xsl:with-param name="padding" select="'0000'"/>
		</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="to">
			<xsl:call-template name="getDateAsSortableInteger">
				<xsl:with-param name="text" select="@to"/>
			<xsl:with-param name="padding" select="'9999'"/>
			</xsl:call-template>
		</xsl:variable>
		
		<interval fm="{$fm}" to="{$to}"/>	
		
	</xsl:copy>
</xsl:template>

<xsl:template match="event[interval]">
	<!--  Just copy through if event already has an interval element -->
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template name="getDateAsSortableInteger">
	<!-- 
		Taking the '-' characters out of a YYYY-MM-DD format date gives an 8 digit number that preserves the date order. 
		However, we might get 'YYYY-MM', or just 'YYYY', so we append the supplied padding (which should be either '0000' or '9999') 
		and take the first 8 digits. We then always have 8 digit numbers to compare.
	 -->
	 <xsl:param name="text"/>
	 <xsl:param name="padding" select="'0000'"/>
	<xsl:variable name="temp" select="concat(translate(normalize-space($text), '-:', ''), $padding)"/>
	<xsl:value-of select="number(substring($temp, 0, 9))"/>
</xsl:template>

<xsl:template name="getDatetimeAsSortableInteger">
	<!-- 
		Taking the '-', space and ':' characters out of a YYYY-MM-DD HH:MM format datetime gives a 12 digit number that preserves the datetime order. 
		However, we might get 'YYYY-MM-DD', so we append '0000' as padding and take the first 12 digits. We then always have 12 digit numbers to compare.
	 -->
	<xsl:param name="text"/>
	<xsl:variable name="temp" select="concat(translate(normalize-space($text), '-: ', ''), '0000')"/>
	<xsl:value-of select="number(substring($temp, 0, 13))"/>
</xsl:template>


</xsl:stylesheet>
