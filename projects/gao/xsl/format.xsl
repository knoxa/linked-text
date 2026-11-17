<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

<xsl:template match="/">
  <html:html>
  	<html:head>
  		<html:title>Results</html:title>
  		<html:style type="text/css">
		p.claim {
			fill:lightgrey;
			font-style: italic;
		}
	</html:style>
  		
  	</html:head>
  	<html:body>
	  	<xsl:message><xsl:value-of select="count(//person)"/></xsl:message>
	  	<xsl:apply-templates select="//person"/>
  	</html:body>
  </html:html>
</xsl:template>

<xsl:template match="person">
	<html:article id="{@id}">
		<html:h4><xsl:value-of select="@sort"/></html:h4>
		<html:p>
			<xsl:apply-templates select="row" mode="fileyear"/>
		</html:p>
		<html:ul>
			<xsl:apply-templates select="row" mode="rank"/>
		</html:ul>
	</html:article>
</xsl:template>

<xsl:template match="row" mode="fileyear">
	<html:a href="{concat('https://www.georgianarmyofficers.org/record-results?idkey=',col[@name = 'idkey']/@value)}"><xsl:value-of select="col[@name = 'fileyear']/@value"/></html:a>
	<xsl:if test="following-sibling::row">
		<xsl:text>, </xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="row" mode="rank">
	<xsl:variable name="rank" select="col[@name = 'reg_rank']/@value"/>
	<xsl:variable name="date" select="col[@name = 'reg_date']/@value"/>
	<xsl:if test="string-length($rank) &gt; 0 and not(preceding-sibling::row[col[@name = 'reg_rank']/@value = $rank and col[@name = 'reg_date']/@value = $date])">
		<html:li>
			<xsl:value-of select="$rank"/>
			<xsl:if test="string-length($date) &gt; 0"><xsl:value-of select="concat(' (', $date, ')')"/></xsl:if>
		</html:li>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
