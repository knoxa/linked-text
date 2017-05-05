<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
  <html>
    <head><title>TESTING</title></head>
    <body>
      <h1>qqqq</h1>
      <xsl:apply-templates select="//item"/>
    </body>
  </html>

</xsl:template>

<xsl:template match="item">
  <p>
  <xsl:value-of select="@href"/>
  </p>
</xsl:template>

</xsl:stylesheet>
