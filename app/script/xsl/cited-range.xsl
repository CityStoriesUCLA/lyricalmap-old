<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="1.0">

    <xsl:output method="html"/>

    <xsl:variable name="dot"        select="'.'"/>
    <xsl:variable name="qq"         select="'&quot;'"/>
    <xsl:variable name="empty"      select="''"/>
    <xsl:variable name="comma"      select="','"/>
    <xsl:variable name="colon"      select="':'"/>
    <xsl:variable name="lbrace"     select="'{'"/>
    <xsl:variable name="rbrace"     select="'}'"/>
    <xsl:variable name="kPart"      select="'part'"/>
    <xsl:variable name="kChapter"   select="'chapter'"/>
    <xsl:variable name="kParagraph" select="'paragraph'"/>

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="string-length(string(//tei:citedRange/@n)) &gt; 0">
                <xsl:apply-templates select="//tei:citedRange"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($lbrace,$rbrace)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:citedRange">

        <xsl:variable name="n"       select="string(@n)"/>
        <xsl:variable name="part"    select="substring-before($n, $dot)"/>
        <xsl:variable name="chapter" select="substring-before(substring-after($n, $dot), $dot)"/>
        <xsl:variable name="para"    select="substring-after(substring-after($n, $dot), $dot)"/>

        <xsl:value-of select="$lbrace"/>

        <xsl:call-template name="entry">
            <xsl:with-param name="pfx" select="$empty"/>
            <xsl:with-param name="key">
                <xsl:call-template name="quote">
                    <xsl:with-param name="str" select="$kPart"/>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="val" select="$part"/>
        </xsl:call-template>

        <xsl:call-template name="entry">
            <xsl:with-param name="pfx" select="$comma"/>
            <xsl:with-param name="key">
                <xsl:call-template name="quote">
                    <xsl:with-param name="str" select="$kChapter"/>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="val" select="$chapter"/>
        </xsl:call-template>

        <xsl:call-template name="entry">
            <xsl:with-param name="pfx" select="$comma"/>
            <xsl:with-param name="key">
                <xsl:call-template name="quote">
                    <xsl:with-param name="str" select="$kParagraph"/>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="val" select="$para"/>
        </xsl:call-template>

        <xsl:value-of select="$rbrace"/>

    </xsl:template>

    <xsl:template name="entry">
        <xsl:param name="pfx"/>
        <xsl:param name="key"/>
        <xsl:param name="val"/>
        <xsl:value-of select="concat($pfx,$key,$colon,$val)"/>
    </xsl:template>

    <xsl:template name="quote">
        <xsl:param name="str"/>
        <xsl:value-of select="concat($qq,$str,$qq)"/>
    </xsl:template>

</xsl:stylesheet>