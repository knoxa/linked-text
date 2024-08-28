<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:time="http://www.w3.org/2006/time#" xmlns:ies="http://ies.data.gov.uk/ies4#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="chronology/make-sortable.xsl"/>

<xsl:template match="/">
<temporal>
	<xsl:apply-templates select="//ies:State"/>
	<xsl:apply-templates select="//time:Instant"/>
	<xsl:apply-templates select="//time:intervalBefore"/>
</temporal>
</xsl:template>


<xsl:template match="ies:State">
	<event uri="{@rdf:about}" label="{rdfs:label}">
		<text><xsl:value-of select="rdfs:label"/></text>
		<xsl:apply-templates select="time:inside" mode="inside"/>
	</event>
</xsl:template>

<xsl:template match="time:Instant">
	<xsl:variable name="text" select="normalize-space(time:inXSDDate|time:inXSDMonth|time:inXSDYear[1])"/>
	<xsl:if test="not(preceding::time:inXSDDate[. = $text]) and not(preceding::time:inXSDMonth[. = $text]) and not(preceding::time:inXSDYear[. = $text])">
		<event uri="{$text}" label="{$text}">
			<text><xsl:value-of select="$text"/></text>
			<xsl:variable name="fm">
			<xsl:call-template name="getDateAsSortableInteger">
				<xsl:with-param name="text" select="$text"/>
				<xsl:with-param name="padding" select="'0000'"/>
			</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="to">
				<xsl:call-template name="getDateAsSortableInteger">
					<xsl:with-param name="text" select="$text"/>
				<xsl:with-param name="padding" select="'9999'"/>
				</xsl:call-template>
			</xsl:variable>
			
			<interval fm="{$fm}" to="{$to}"/>	
		</event>
	</xsl:if>
</xsl:template>

<xsl:template match="time:intervalBefore">
	<xsl:variable name="fm">
		<xsl:apply-templates select=".." mode="subject"/>
	</xsl:variable>
	<xsl:variable name="to">
		<xsl:apply-templates select="ies:State|time:Instant|@rdf:resource|@rdf:nodeID" mode="object"/>
	</xsl:variable>
	<link fm="{$fm}" to="{$to}"/>
</xsl:template>

<xsl:template match="time:Instant" mode="subject">
	<xsl:value-of select="normalize-space(time:inXSDDate|time:inXSDMonth|time:inXSDYear[1])"/>
</xsl:template>

<xsl:template match="time:Instant" mode="object">
	<xsl:value-of select="normalize-space(time:inXSDDate|time:inXSDMonth|time:inXSDYear[1])"/>
</xsl:template>

<xsl:template match="ies:State" mode="subject">
	<xsl:value-of select="@rdf:about"/>
</xsl:template>

<xsl:template match="ies:State" mode="object">
	<xsl:value-of select="@rdf:about"/>
</xsl:template>

<xsl:template match="@rdf:resource" mode="object">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="@rdf:nodeID" mode="object">
	<xsl:variable name="node" select="normalize-space(.)"/>
	<xsl:value-of select="normalize-space(//time:Instant[@rdf:nodeID = $node][1])"/>
</xsl:template>

<xsl:template match="*" mode="subject"/>
<xsl:template match="*" mode="object"/>

<xsl:template match="time:inside" mode="inside">
	<xsl:variable name="fm">
	<xsl:call-template name="getDateAsSortableInteger">
		<xsl:with-param name="text" select="normalize-space(time:Instant)"/>
		<xsl:with-param name="padding" select="'0000'"/>
	</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="to">
		<xsl:call-template name="getDateAsSortableInteger">
			<xsl:with-param name="text" select="normalize-space(time:Instant)"/>
		<xsl:with-param name="padding" select="'9999'"/>
		</xsl:call-template>
	</xsl:variable>	
	<interval fm="{$fm}" to="{$to}"/>	
</xsl:template>

</xsl:stylesheet>
