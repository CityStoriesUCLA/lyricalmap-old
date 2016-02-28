<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    version="1.0">

    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="p div span"/>

    <!-- url of the image directory, relative to the base-url of the index.html page -->
    <xsl:param name="article-dir"/>
    <xsl:param name="iconUrl"/>
    <xsl:param name="cid"/>

    <xsl:template match="/">
        <article id="{$cid}" class="before-footer article-content">
            <header id="header">
                <xsl:call-template name="header"/>
            </header>
            <section id="body">
                <xsl:call-template name="body"/>
                <xsl:apply-templates select="//tei:back/tei:div[@type='bibliography']"/>
            </section>
        </article>
        <footer id="footer" class="article-content">
            <xsl:call-template name="footer"/>
        </footer>
    </xsl:template>

    <xsl:template match="tei:ref">
        <a href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>


<!--
-/- header templates
-->

    <xsl:template name="header">
        <p class="heading"><xsl:call-template name="handle-note"/></p>
        <h1 class="article-title">
            <xsl:apply-templates select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
            <img class="article-marker" src="{$iconUrl}"></img>
        </h1>
        <p class="byline"><xsl:call-template name="handle-byline"/>
            <xsl:text> </xsl:text>
            <xsl:call-template name="handle-date"/>
        </p>
    </xsl:template>

    <xsl:template name="handle-note">
        <span><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:notesStmt/tei:relatedItem/tei:bibl/tei:author"/> </span>
        <xsl:text> </xsl:text>
        <span><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:notesStmt/tei:relatedItem/tei:bibl/tei:title"/></span>
    </xsl:template>

    <xsl:template name="handle-byline">
        <xsl:variable name="count" select="count(//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author)"/>
        <xsl:for-each select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author">
            <xsl:choose>
                <xsl:when test="position() = 1">
                    <span><xsl:value-of select="."/></span>
                </xsl:when>
                <xsl:when test="position() != 1">
                    <span>, <xsl:value-of select="."/></span>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="handle-date">
        <span>(<xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/>)</span>
    </xsl:template>

<!--
-/- body templates
-->

    <xsl:template name="body">
        <xsl:apply-templates select="//tei:body"/>
    </xsl:template>

    <xsl:template match="tei:div|tei:p">
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:div[@type='bibliography']">
        <xsl:if test="tei:listBibl/tei:bibl/text()">
            <div>
                <h6>Works Cited</h6>
                <xsl:apply-templates/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:emph">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <xsl:template match="tei:q">
        <p class="pullquote">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:bibl">
        <p class="bibl">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!--
-/-  footer templates
-->

    <xsl:template name="footer">
        <xsl:if test="count(//tei:text/tei:back/tei:div[@type='images']/tei:figure) &gt; 0">
            <div id="article-images" class="image-loading">
                <div id="slides">
                    <xsl:apply-templates select="//tei:text/tei:back/tei:div[@type='images']/tei:figure" mode="img"/>
                </div>
                <xsl:apply-templates select="//tei:text/tei:back/tei:div[@type='images']/tei:figure" mode="popover"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:figure" mode="img">
        <xsl:variable name="src">
            <xsl:choose>
                <xsl:when test="starts-with(tei:graphic/@url, 'http')">
                    <xsl:value-of select="tei:graphic/@url"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($article-dir,tei:graphic/@url)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- .remove class removed when the image loads -->
        <img id="{concat('fig', position())}" src="{$src}" href="{$src}" alt="{tei:title}" class="slidesjs-slide gallery-item remove"></img>
    </xsl:template>

    <xsl:template match="tei:figure" mode="popover">
        <div style="display:none" class="{concat('fig', position(), ' popover')}">
            <span class="{concat('fig', position(), ' head')}"><xsl:value-of select="tei:head"/></span>
            <span class="{concat('fig', position(), ' desc')}"><xsl:value-of select="tei:figDesc"/></span>
            <span class="{concat('fig', position(), ' attr')}"><xsl:value-of select="tei:note"/></span>
        </div>
    </xsl:template>

</xsl:stylesheet>
