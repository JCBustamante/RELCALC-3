<?xml version="1.0" encoding="UTF-8"?>

<!-- Personnalisations HTML de RELCALC-3 (cible web)                   -->
<!-- Ce fichier est copié avec le dossier core par la CLI PreTeXt.     -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg"
                version="1.0">

<xsl:import href="./core/pretext-html.xsl" />

<!-- Figures Asymptote : copie du gabarit de pretext-html.xsl (CLI 2.52.3), -->
<!-- seul le texte du lien vers la figure pleine grandeur est francisé.      -->
<!-- (Aucune chaîne de localisation n'existe pour ce texte.)                -->
<xsl:template match="image[asymptote]" mode="image-inclusion">
    <!-- base-pathname needed later for archive link production. This   -->
    <!-- is the location for eventual output, in contrast to juat below -->
    <!-- for source analysis.                                           -->
    <xsl:variable name="base-pathname">
        <xsl:value-of select="$generated-directory"/>
        <xsl:text>asymptote/</xsl:text>
        <xsl:apply-templates select="asymptote" mode="image-source-basename"/>
    </xsl:variable>
    <xsl:variable name="html-filename" select="concat($base-pathname, '.html')" />
    <!-- We also need a path to the *source* file, for examination -->
    <!-- to determine the aspect ratio of the diagram, in order to -->
    <!-- insert correctly as a scaled instance                     -->
    <xsl:variable name="html-source-filename">
        <xsl:value-of select="$generated-directory-source"/>
        <xsl:text>asymptote/</xsl:text>
        <xsl:apply-templates select="asymptote" mode="image-source-basename"/>
        <xsl:text>.html</xsl:text>
    </xsl:variable>
    <!-- Assumes filename is relative to primary source file, -->
    <!-- which must be specified with the original version,   -->
    <!-- not the pre-processed, "assembled" version           -->
    <xsl:variable name="image-xml" select="document($html-source-filename, $original)"/>

    <!-- width first -->
    <xsl:variable name="width">
        <xsl:choose>
            <!-- 2-D diagram -->
            <!-- note necessity of namespace for "svg" element -->
            <xsl:when test="$image-xml/html/body/svg:svg">
                <xsl:variable name="wpt" select="$image-xml/html/body/svg:svg/@width"/>
                <!-- Strip "pt" suffix -->
                <xsl:value-of select="substring($wpt, 1, string-length($wpt) - 2)"/>
            </xsl:when>
            <!-- 3-D diagram -->
            <xsl:when test="$image-xml/html/body/canvas">
                <xsl:value-of select="$image-xml/html/body/canvas/@width"/>
            </xsl:when>
            <!-- failure -->
            <xsl:otherwise>
                <xsl:message>PTX:FALLBACK:   the Asymptote diagram produced in "<xsl:value-of select="$image-xml"/>" needs to be available relative to the primary source file, or if available it is perhaps ill-formed and its width cannot be determined (which you might report as a bug).  We might be able to proceed as if the diagram is square, but results can be unpredictable.</xsl:message>
                <!-- reasonable guess at points/pixels -->
                <xsl:text>400</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- now height, similarly -->
    <xsl:variable name="height">
        <xsl:choose>
            <!-- 2-D diagram -->
            <!-- note necessity of namespace for "svg" element -->
            <xsl:when test="$image-xml/html/body/svg:svg">
                <xsl:variable name="hpt" select="$image-xml/html/body/svg:svg/@height"/>
                <!-- Strip "pt" suffix -->
                <xsl:value-of select="substring($hpt, 1, string-length($hpt) - 2)"/>
            </xsl:when>
            <!-- 3-D diagram -->
            <xsl:when test="$image-xml/html/body/canvas">
                <xsl:value-of select="$image-xml/html/body/canvas/@height"/>
            </xsl:when>
            <!-- failure -->
            <xsl:otherwise>
                <xsl:message>PTX:FALLBACK:   the Asymptote diagram produced in "<xsl:value-of select="$image-xml"/>" needs to be available relative to the primary source file, or if available it is perhaps ill-formed and its height cannot be determined (which you might report as a bug).  We might be able to proceed as if the diagram is square, but results can be unpredictable.</xsl:message>
                <!-- reasonable guess at points/pixels -->
                <xsl:text>400</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <!-- All that was to get an aspect-ratio for a responsive iframe embedding -->
    <xsl:variable name="aspect-percent" select="($height div $width) * 100"/>

    <!-- Surrounding/constraining "image", or "sidebyside" panel, or ...    -->
    <!-- will provide an overall width.  The "padding-top" property is what -->
    <!-- makes the right shape.  CSS provides some constant properties.     -->
    <div class="asymptote-box" style="padding-top: {$aspect-percent}%">
        <iframe src="{$html-filename}" class="asymptote">
            <xsl:if test="shortdescription">
                <xsl:attribute name="title">
                    <xsl:value-of select="shortdescription"/>
                </xsl:attribute>
            </xsl:if>
        </iframe>
    </div>
    <!-- possibly annotate with archive links -->
    <xsl:apply-templates select="." mode="archive">
        <xsl:with-param name="base-pathname" select="$base-pathname" />
    </xsl:apply-templates>
    <!-- possibly provide link to full size image -->
    <!-- need to set html/asymptote@links="yes" in publisher file to enable -->
    <xsl:if test="$b-asymptote-html-links">
      <xsl:variable name="image-html-url">
          <xsl:value-of select="$baseurl"/>
          <xsl:value-of select="$html-filename"/>
      </xsl:variable>
      <div class="asymptote-fullsize-link">
        <a href="{$image-html-url}">Agrandir la figure</a>
      </div>
    </xsl:if>
    <!-- possibly give a long description -->
    <xsl:apply-templates select="." mode="description"/>
</xsl:template>

</xsl:stylesheet>
