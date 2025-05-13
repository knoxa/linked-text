<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="event" mode="nation">
    <xsl:if test="contains(text, 'Albania')">
    	<entity type="nation">Albania</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Brazil')">
    	<entity type="nation">Brazil</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Austral') or contains(text, 'H.M.A.S')">
    	<entity type="nation">Great Britain</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'German')">
    	<entity type="nation">Germany</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Britain') or contains(text, 'England') or contains(text, 'British') or contains(text, 'English') or contains(text, 'Anglo') or contains(text, 'H.M.S')">
    	<entity type="nation">Great Britain</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Japan')">
    	<entity type="nation">Japan</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Liberia')">
    	<entity type="nation">Liberia</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Austria-Hungary') or contains(text, 'Austria') or contains(text, 'Austro-Hungar')">
    	<entity type="nation">Austria-Hungary</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'United States')">
    	<entity type="nation">U.S.A.</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Montenegr')">
    	<entity type="nation">Montenegro</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Siam')">
    	<entity type="nation">Siam</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Serbia')">
    	<entity type="nation">Serbia</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Greece') or contains(text, 'Greek')">
    	<entity type="nation">Greece</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Holland') or contains(text, 'Dutch')">
    	<entity type="nation">Holland</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Rumania') or contains(text, 'Roumania') or contains(text, 'Romania')">
    	<entity type="nation">Romania</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Bulgaria')">
    	<entity type="nation">Bulgaria</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'French') or contains(text, 'France') or contains(text, 'Franco')">
    	<entity type="nation">France</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Belgium') or contains(text, 'Belgian')">
    	<entity type="nation">Belgium</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Czech')">
    	<entity type="nation">Czechoslovakia</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Swedish')">
    	<entity type="nation">Sweden</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Russia')">
    	<entity type="nation">Russia</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Italian') or contains(text, 'Italy')">
    	<entity type="nation">Italy</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Ukrain')">
    	<entity type="nation">Ukraine</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Poland')">
    	<entity type="nation">Poland</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Portug')">
    	<entity type="nation">Portugal</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Costa Rica')">
    	<entity type="nation">Costa Rica</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Honduras')">
    	<entity type="nation">Honduras</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Guatemala')">
    	<entity type="nation">Guatemala</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Haiti')">
    	<entity type="nation">Haiti</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Montenegro')">
    	<entity type="nation">Montenegro</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Nicaragua')">
    	<entity type="nation">Nicaragua</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Panama')">
    	<entity type="nation">Panama</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'San Marino')">
    	<entity type="nation">San Marino</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Cuba')">
    	<entity type="nation">Cuba</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Swiss') or contains(text, 'Switzerland')">
    	<entity type="nation">Switzerland</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Chinese') or contains(text, 'China')">
    	<entity type="nation">China</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'Turkish') or contains(text, 'Turkey') or contains(text, 'Turco')">
    	<entity type="nation">Turkey</entity>
    </xsl:if>
    <xsl:if test="contains(text, 'India')">
    	<entity type="nation">India</entity>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
