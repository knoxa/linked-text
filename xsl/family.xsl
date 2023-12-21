<xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:aif="http://www.arg.dundee.ac.uk/aif#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:import href="rewrite.xsl"/>

<xsl:template match="/">
<html:html>
<html:head>
<html:title>Testing</html:title>
<html:style type="text/css">
.parent, .person {
	color: blue;
}

.child {
	color: green;
}

.claim {
	font-style: italic;
}

</html:style>
</html:head>
<html:body>
	<xsl:apply-templates select="//aif:claimText" />
</html:body>
</html:html>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the father of')]">
	<xsl:apply-templates select="." mode="parent">
		<xsl:with-param name="relationship" select="'is the father of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the mother of')]">
	<xsl:apply-templates select="." mode="parent">
		<xsl:with-param name="relationship" select="'is the mother of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is a parent of') or contains(., ' is the parent of ')]">
	<xsl:apply-templates select="." mode="parent">
		<xsl:with-param name="relationship" select="' is the parent of '"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the son of')]">
	<xsl:apply-templates select="." mode="child">
		<xsl:with-param name="relationship" select="'is the son of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the daughter of')]">
	<xsl:apply-templates select="." mode="child">
		<xsl:with-param name="relationship" select="'is the daughter of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the offspring of')]">
	<xsl:apply-templates select="." mode="child">
		<xsl:with-param name="relationship" select="'is the offspring of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the child of')]">
	<xsl:apply-templates select="." mode="child">
		<xsl:with-param name="relationship" select="'is the child of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the grandfather of')]">
	<xsl:apply-templates select="." mode="grandparent">
		<xsl:with-param name="relationship" select="'is the grandfather of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the grandmother of')]">
	<xsl:apply-templates select="." mode="grandparent">
		<xsl:with-param name="relationship" select="'is the grandmother of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the grandson of')]">
	<xsl:apply-templates select="." mode="grandchild">
		<xsl:with-param name="relationship" select="'is the grandson of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the granddaughter of')]">
	<xsl:apply-templates select="." mode="grandchild">
		<xsl:with-param name="relationship" select="'is the granddaughter of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the brother of')]">
	<xsl:apply-templates select="." mode="sibling">
		<xsl:with-param name="relationship" select="'is the brother of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is the sister of')]">
	<xsl:apply-templates select="." mode="sibling">
		<xsl:with-param name="relationship" select="'is the sister of'"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'is married to')]">
	<xsl:apply-templates select="." mode="marriage">
		<xsl:with-param name="relationship" select="'is married to'"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="aif:claimText[contains(., ' refers to ')]">
	<!--  ignore -->
</xsl:template>

<xsl:template match="aif:claimText[contains(., 'contradicts')]">
	<xsl:message>IGNORED: <xsl:value-of select="."/></xsl:message>
</xsl:template>

<xsl:template match="aif:claimText">
	<xsl:message>TO DO: <xsl:value-of select="."/></xsl:message>
</xsl:template>


<xsl:template match="aif:claimText" mode="parent">
	<xsl:param name="relationship"/>
	<xsl:variable name="text"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:variable name="parent" select="normalize-space(substring-before($text, $relationship))"/>	
	<xsl:variable name="child"  select="normalize-space(substring-after($text, $relationship))"/>
	<html:p>
		<html:span class="parent"><xsl:value-of select="$parent"/></html:span>
		<html:span><xsl:value-of select="' is the parent of '"/></html:span>
		<html:span class="child"><xsl:value-of select="$child"/></html:span>
		<xsl:text>.</xsl:text>
	</html:p>
</xsl:template>


<xsl:template match="aif:claimText" mode="child">
	<xsl:param name="relationship"/>
	<xsl:variable name="text"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:variable name="child"  select="normalize-space(substring-before($text, $relationship))"/>	
	<xsl:variable name="parent" select="normalize-space(substring-after($text, $relationship))"/>
	<html:p>
		<html:span class="parent"><xsl:value-of select="$parent"/></html:span>
		<html:span><xsl:value-of select="' is the parent of '"/></html:span>
		<html:span class="child"><xsl:value-of select="$child"/></html:span>
		<xsl:text>.</xsl:text>
	</html:p>
</xsl:template>


<xsl:template match="aif:claimText" mode="sibling">
	<xsl:param name="relationship"/>
	<xsl:variable name="text"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:variable name="child1" select="normalize-space(substring-before($text, $relationship))"/>	
	<xsl:variable name="child2" select="normalize-space(substring-after($text, $relationship))"/>
	<html:p>
		<html:span>
			<html:span about="{concat('_:', generate-id())}" class="parent"><xsl:value-of select="'?'"/></html:span>
			<html:span><xsl:value-of select="' is the parent of '"/></html:span>
			<html:span class="child"><xsl:value-of select="$child1"/></html:span>
		</html:span>
		<xsl:text>, and </xsl:text>
		<html:span>
			<html:span about="{concat('_:', generate-id())}" class="parent"><xsl:value-of select="'?'"/></html:span>
			<html:span><xsl:value-of select="' is the parent of '"/></html:span>
			<html:span class="child"><xsl:value-of select="$child2"/></html:span>
		</html:span>
		<xsl:text>.</xsl:text>
	</html:p>
</xsl:template>


<xsl:template match="aif:claimText" mode="grandchild">
	<xsl:param name="relationship"/>
	<xsl:variable name="text"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:variable name="grandchild"  select="normalize-space(substring-before($text, $relationship))"/>	
	<xsl:variable name="grandparent" select="normalize-space(substring-after($text, $relationship))"/>
	<html:p class="claim">
		<xsl:value-of select="."/>
	</html:p>
	<html:p>
		<html:span>
			<html:span class="parent"><xsl:value-of select="$grandparent"/></html:span>
			<html:span><xsl:value-of select="' is the parent of '"/></html:span>
			<html:span about="{concat('_:', generate-id())}" class="child"><xsl:value-of select="'?'"/></html:span>
		</html:span>
		<xsl:text>, and </xsl:text>
		<html:span>
			<html:span about="{concat('_:', generate-id())}" class="parent"><xsl:value-of select="'?'"/></html:span>
			<html:span><xsl:value-of select="' is the parent of '"/></html:span>
			<html:span class="child"><xsl:value-of select="$grandchild"/></html:span>
		</html:span>
		<xsl:text>.</xsl:text>
	</html:p>
</xsl:template>


<xsl:template match="aif:claimText" mode="grandparent">
	<xsl:param name="relationship"/>
	<xsl:variable name="text"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:variable name="grandparent" select="normalize-space(substring-before($text, $relationship))"/>	
	<xsl:variable name="grandchild"  select="normalize-space(substring-after($text, $relationship))"/>
	<html:p class="claim">
		<xsl:value-of select="."/>
	</html:p>
	<html:p>
		<html:span>
			<html:span class="parent"><xsl:value-of select="$grandparent"/></html:span>
			<html:span><xsl:value-of select="' is the parent of '"/></html:span>
			<html:span about="{concat('_:', generate-id())}" class="child"><xsl:value-of select="'?'"/></html:span>
		</html:span>
		<xsl:text>, and </xsl:text>
		<html:span>
			<html:span about="{concat('_:', generate-id())}" class="parent"><xsl:value-of select="'?'"/></html:span>
			<html:span><xsl:value-of select="' is the parent of '"/></html:span>
			<html:span class="child"><xsl:value-of select="$grandchild"/></html:span>
		</html:span>
		<xsl:text>.</xsl:text>
	</html:p>
</xsl:template>


<xsl:template match="aif:claimText" mode="marriage">
	<xsl:param name="relationship"/>
	<xsl:variable name="text"><xsl:call-template name="getArgument"/></xsl:variable>
	<xsl:variable name="p1" select="normalize-space(substring-before($text, $relationship))"/>	
	<xsl:variable name="p2" select="normalize-space(substring-after($text, $relationship))"/>
	<html:p class="claim">
		<xsl:value-of select="."/>
	</html:p>
	<html:p>
		<html:span class="claim">
			<html:span class="person"><xsl:value-of select="$p1"/></html:span>
			<html:span class="marriage"><xsl:value-of select="' is married to '"/></html:span>
			<html:span class="person"><xsl:value-of select="$p2"/></html:span>
		</html:span>
		<xsl:text>.</xsl:text>
	</html:p>
</xsl:template>

</xsl:stylesheet>
