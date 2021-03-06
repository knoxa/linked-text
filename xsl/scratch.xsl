<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
  <html:html>
    <html:head><html:title>TESTING</html:title></html:head>
    <html:body>
      <html:h1>qqqq4</html:h1>
      <xsl:apply-templates select="//item"/>
    </html:body>
  </html:html>

</xsl:template>

<xsl:template match="item">
  <html:p onclick="window.open('{@href}')">
  <xsl:value-of select="@href"/>
  </html:p>
</xsl:template>

</xsl:stylesheet>
