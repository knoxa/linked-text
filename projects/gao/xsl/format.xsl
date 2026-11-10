<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

<xsl:template match="/">
  <html:html>
  	<html:head><html:title>Results</html:title></html:head>
  	<html:body>
	  	<xsl:message><xsl:value-of select="count(//person)"/></xsl:message>
	  	<xsl:apply-templates select="//person"/>
  	</html:body>
  </html:html>
</xsl:template>

<xsl:template match="person">
	<html:article>
		<html:h4><xsl:value-of select="@sort"/></html:h4>
	</html:article>
</xsl:template>

</xsl:stylesheet>
