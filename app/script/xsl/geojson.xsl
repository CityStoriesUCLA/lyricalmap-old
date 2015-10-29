<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="1.0">

    <xsl:output method="html"/>

    <xsl:template match="/">
        <xsl:apply-templates select="//tei:note[@type='mapmarker']"/>
    </xsl:template>

    <xsl:template match="tei:note[@type='mapmarker']">
        <xsl:text>{"type": "Feature"</xsl:text>

        <!-- map coordinates: longitude, latitude -->
        <xsl:text>,"geometry":{"type":"Point","coordinates":[</xsl:text>
        <xsl:value-of select="substring-before(tei:geo, ' ')"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="substring-after(tei:geo, ' ')"/>

        <!-- title for marker -->
        <xsl:text>]},"properties":{"markername":"</xsl:text>
        <xsl:value-of select="tei:placeName"/>

        <!-- popup text -->
        <xsl:text>", "text":"</xsl:text>
        <xsl:value-of select="tei:p"/>

        <!-- marker layer -->
        <xsl:text>", "layer":"</xsl:text>
        <xsl:value-of select="tei:placeName/@type"/>

        <xsl:text>"}}</xsl:text>
    </xsl:template>

</xsl:stylesheet>