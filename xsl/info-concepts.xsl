<xsl:stylesheet version="1.0" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" encoding="UTF-8" />

<xsl:import href="file:///D:/GitHub/eleatics/xsl-utils/stringhash.xsl"/>

<xsl:template match="/">
	<xsl:apply-templates select="//html:a" />
	<xsl:text>_:person </xsl:text><xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/><xsl:text> '*person'  .&#13;&#10;</xsl:text>
	<xsl:text>_:role </xsl:text><xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/><xsl:text> '*role'  .&#13;&#10;</xsl:text>
	<xsl:text>_:vessel </xsl:text><xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/><xsl:text> '*vessel'  .&#13;&#10;</xsl:text>
	<xsl:text>_:place </xsl:text><xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/><xsl:text> '*place'  .&#13;&#10;</xsl:text>
	<xsl:text>_:notation </xsl:text><xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/><xsl:text> '*notation'  .&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="html:a">
	<xsl:apply-templates select="document(@href)" mode="extract"/>
</xsl:template>

<xsl:template match="/" mode="extract">
	<xsl:apply-templates select="*" mode="entity"/>
</xsl:template>

<xsl:template match="html:blockquote" mode="entity"/>

<xsl:template match="*" mode="entity">
	<xsl:apply-templates select="*" mode="entity"/>
</xsl:template>

<xsl:template match="html:span[@class]" mode="entity">
	<xsl:variable name="hash">
		<xsl:call-template name="hashMD5">
			<xsl:with-param name="text" select="."/>
		</xsl:call-template>
	</xsl:variable>	
	<xsl:variable name="nodeID">
		<xsl:value-of select="concat('_:', $hash)"/>
	</xsl:variable>
	<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type&gt;'"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#Concept&gt;'"/>
	<xsl:text> .&#13;&#10;</xsl:text>
	<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#broader&gt;'"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="concat('_:', @class)"/>
	<xsl:text> .&#13;&#10;</xsl:text>
	<xsl:variable name="txt">
		<xsl:call-template name="escapeApostrophe">
			<xsl:with-param name="text" select="."/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:choose>
		<xsl:when test="@content">
			<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
			<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="concat(&quot;'&quot;, @content, &quot;'&quot;)"/>
			<xsl:text> .&#13;&#10;</xsl:text>
			<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
			<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#altLabel&gt;'"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="concat(&quot;'&quot;, $txt, &quot;'&quot;)"/>
			<xsl:text> .&#13;&#10;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
			<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="concat(&quot;'&quot;, $txt, &quot;'&quot;)"/>
			<xsl:text> .&#13;&#10;</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="html:span[@content]" mode="entity">
	<xsl:variable name="hash">
		<xsl:call-template name="hashMD5">
			<xsl:with-param name="text" select="@content"/>
		</xsl:call-template>
	</xsl:variable>	
	<xsl:variable name="nodeID">
		<xsl:value-of select="concat('_:', $hash)"/>
	</xsl:variable>
	<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type&gt;'"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#Concept&gt;'"/>
	<xsl:text> .&#13;&#10;</xsl:text>
	<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
	<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#broader&gt;'"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="concat('_:', @class)"/>
	<xsl:text> .&#13;&#10;</xsl:text>
	<xsl:variable name="txt">
		<xsl:call-template name="escapeApostrophe">
			<xsl:with-param name="text" select="."/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:choose>
		<xsl:when test="@content">
			<xsl:variable name="preftxt">
				<xsl:call-template name="escapeApostrophe">
					<xsl:with-param name="text" select="@content"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
			<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="concat(&quot;'&quot;, $preftxt, &quot;'&quot;)"/>
			<xsl:text> .&#13;&#10;</xsl:text>
			<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
			<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#altLabel&gt;'"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="concat(&quot;'&quot;, $txt, &quot;'&quot;)"/>
			<xsl:text> .&#13;&#10;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$nodeID"/><xsl:text> </xsl:text>
			<xsl:value-of select="'&lt;http://www.w3.org/2004/02/skos/core#prefLabel&gt;'"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="concat(&quot;'&quot;, $txt, &quot;'&quot;)"/>
			<xsl:text> .&#13;&#10;</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="html:span[contains(@class,'claim') or contains(@class,'premise') or contains(@class,'conclusion') or contains(@class,'support')  or contains(@class,'conflict')  or contains(@class,'rewrite')]" mode="entity">
	<xsl:apply-templates select="*" mode="entity"/>
</xsl:template>

<xsl:template match="html:span[@class = 'date' or @class = 'ref']" mode="entity">
	<xsl:apply-templates select="*" mode="entity"/>
</xsl:template>


<xsl:template name="escapeApostrophe">
	<xsl:param name="text"/>
	<xsl:choose>
		<xsl:when test="contains($text, &quot;&apos;&quot;)">
			<xsl:value-of select="substring-before($text, &quot;&apos;&quot;)"/>
			<xsl:text>\&apos;</xsl:text>
			<xsl:call-template name="escapeApostrophe">
				<xsl:with-param name="text" select="substring-after($text, &quot;&apos;&quot;)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$text"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
