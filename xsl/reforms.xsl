<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:time="http://www.w3.org/2006/time#" xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="chronology/make-sortable.xsl"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="*"/>
</temporal>
</xsl:template>

<xsl:template match="*">
	<xsl:apply-templates select="*"/>
</xsl:template>


<xsl:template match="html:*[@typeof = 'time:Instant']">
	<xsl:variable name="text" select="normalize-space(.)"/>
	<xsl:variable name="label">
		<xsl:apply-templates select=".//html:*[@property = 'skos:prefLabel']" mode="label"/>
	</xsl:variable>
	<xsl:variable name="date" select=".//html:*[@property = 'time:inXSDDate' or @property = 'time:inXSDMonth' or @property = 'time:inXSDYear'][1]/@content"/>
	<!-- 
	<event uri="{@about}" fm="{$date}" to="{$date}" label="{$text}">
	 -->
	<event uri="{@about}" fm="{$date}" to="{$date}" label="{$label}">
		<text><xsl:value-of select="$text"/></text>
		<xsl:variable name="fm">
		<xsl:call-template name="getDateAsSortableInteger">
			<xsl:with-param name="text" select="$date"/>
			<xsl:with-param name="padding" select="'0000'"/>
		</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="to">
			<xsl:call-template name="getDateAsSortableInteger">
				<xsl:with-param name="text" select="$date"/>
			<xsl:with-param name="padding" select="'9999'"/>
			</xsl:call-template>
		</xsl:variable>
		
		<interval fm="{$fm}" to="{$to}"/>	
	</event>
</xsl:template>

<xsl:template match="html:*" mode="label">
	<xsl:choose>
		<xsl:when test="@content">
			<xsl:value-of select="@content"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
