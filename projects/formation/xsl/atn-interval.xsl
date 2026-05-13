<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://knoxa.github.io/xml/flag" xmlns:nlp="http://uk.gov.dstl/baleen/parse" xmlns:flag="http://knoxa.github.io/xml/flag" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="/D:/GitHub/xslt-parsers/ATN/xsl\net-import.xsl"/>

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 
<xsl:template match="nlp:token" mode="parse">

	<xsl:call-template name="networkParseResults">
		<xsl:with-param name="parseRTF">
		<xsl:apply-templates select="." mode="adposition"/>
		</xsl:with-param>
	</xsl:call-template>

</xsl:template>


<xsl:template match="nlp:token[nlp:lemma = 'during' or nlp:lemma = 'throughout' or nlp:lemma = 'in']" mode="adposition">
	<xsl:apply-templates select="following-sibling::nlp:token[1]" mode="interval">
		<xsl:with-param name="lemma" select="nlp:lemma"/>	
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma = 'start' or nlp:lemma = 'end']" mode="adposition">
	<xsl:apply-templates select="following-sibling::nlp:token[1]" mode="of-interval">
		<xsl:with-param name="lemma" select="nlp:lemma"/>	
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma = 'be']" mode="adposition">
	<xsl:apply-templates select="following-sibling::nlp:token[1]" mode="vp"/>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma = 'of']" mode="of-interval">
	<xsl:param name="lemma"/>
	<xsl:apply-templates select="following-sibling::nlp:token[1]" mode="interval">
		<xsl:with-param name="lemma" select="$lemma"/>	
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma/@type = 'Noun']" mode="vp">
	<xsl:apply-templates select="following-sibling::nlp:token[1]" mode="of">
		<xsl:with-param name="lemma" select="nlp:lemma"/>	
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[1][@type = 'Noun' or @type = 'NP' or @type = 'CD']]" mode="interval">
	<xsl:param name="lemma"/>
	<flag:finish pos="{@end}">
		<flag:lemma type="INTERVAL"><xsl:value-of select="$lemma"/></flag:lemma>
	</flag:finish>
</xsl:template>

<xsl:template match="nlp:token[nlp:lemma[1][@type = 'Adposition']]" mode="of">
	<xsl:param name="lemma"/>
	<flag:finish pos="{@end}">
		<flag:lemma type="VP"><xsl:value-of select="$lemma"/></flag:lemma>
	</flag:finish>
</xsl:template>

<xsl:template match="nlp:token" mode="adposition"/>
<xsl:template match="nlp:token" mode="interval"/>
<xsl:template match="nlp:token" mode="of"/>
<xsl:template match="nlp:token" mode="of-interval"/>
<xsl:template match="nlp:token" mode="vp"/>

</xsl:stylesheet>
