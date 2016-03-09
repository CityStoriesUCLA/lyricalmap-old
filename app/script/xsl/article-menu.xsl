<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="tei"
    version="1.0">

    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:param name="href"/>

    <xsl:template match="/">
        <xsl:variable name="title" select="//tei:titleStmt/tei:title"/>
        <li data-sort-key="{$title}">
            <a href="{$href}"><xsl:value-of select="$title"/></a>
        </li>
    </xsl:template>

</xsl:stylesheet>