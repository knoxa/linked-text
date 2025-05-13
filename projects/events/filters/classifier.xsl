<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="event" mode="type">
	    <xsl:if test="entity/@type = 'vessel'">
	    	<entity type="class">MARITIME</entity>
	    </xsl:if>
	    <xsl:if test="entity/@type = 'op'">
	    	<entity type="class">OPERATION</entity>
	    </xsl:if>
</xsl:template>

</xsl:stylesheet>
