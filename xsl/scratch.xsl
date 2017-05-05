<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
  <xsl:apply-templates select="//item"/>
</xsl:template>

<xsl:template match="item">
  <xsl:copy-of select="document(@href)"/>
</xsl:template>

</xsl:stylesheet>
