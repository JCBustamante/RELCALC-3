<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->
<!-- Conveniences for classes of similar elements -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "entities.ent">
    %entities;
]>

<!-- DMOI customizations for LaTeX runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- assumes this has been copied to mathbook/user -->
<xsl:import href="./core/pretext-latex.xsl" />

<xsl:import href="PDF-style.xsl" />
<!-- Assumes next file can be found in mathbook/user -->



<xsl:param name="debug.exercises.forward" select="'no'"/>

  <!-- Pour les exercices WeBWorK en statique dans le PDF :
       n'inclure que l'énoncé, sans hints / réponses / solutions -->
  <xsl:param name="exercise.text.statement" select="'yes'"/>
  <xsl:param name="exercise.text.hint"      select="'no'"/>
  <xsl:param name="exercise.text.answer"    select="'no'"/>
  <xsl:param name="exercise.text.solution"  select="'no'"/>

  <!-- DEPOT: masquer les <answer> des <example> (mais garder les <solution>) -->
  <xsl:template match="example/answer"/>

  <!-- BUG FIX 2026-09-10 : les réponses/solutions/indices des exercices       -->
  <!-- s'affichaient dans le PDF malgré publication.ptx (answer="no", etc.,    -->
  <!-- dans le bloc <latex>). En fait, PreTeXt-CLI (vérifié jusqu'à 2.52.3)    -->
  <!-- ne branche ces réglages de visibilité que sur la sortie HTML (et sur    -->
  <!-- la cible séparée "solution manual") ; ils sont ignorés par la chaîne   -->
  <!-- LaTeX/PDF standard, qui inclut toujours <answer>/<solution>/<hint>.     -->
  <!-- On masque donc ici explicitement le contenu des exercices dans le PDF  -->
  <!-- (il reste visible dans le HTML, qui n'est pas touché par ce fichier).   -->
  <xsl:template match="exercise//answer"/>
  <xsl:template match="exercise//solution"/>
  <xsl:template match="exercise//hint"/>

<!-- Hack 2024-08-21 to improve layout of matching exercises -->
<xsl:template match="exercise/matches/match" mode="matching-statement">
    <xsl:variable name="premise-number" select="count(preceding-sibling::match) + 1"/>
    <xsl:variable name="all-matches" select="parent::matches/match"/>    
    <row>
        <xsl:if test="following-sibling::match">
            <xsl:attribute name="bottom">
                <xsl:text>minor</xsl:text>
            </xsl:attribute>
        </xsl:if>
        <cell>
            <xsl:copy-of select="premise/node()"/>
        </cell>
        <cell bottom="none"><nbsp/><nbsp/></cell>
        <cell>
            <xsl:copy-of select="$all-matches[@order = $premise-number]/response/node()"/>
        </cell>
    </row>
</xsl:template>
      

<!-- Old version of "geometry" -->
<!-- Geometry: page shape, margins, etc            -->
<!-- Pass a string with any of geometry's options  -->
<!-- Default is empty and thus ineffective         -->
<!-- Otherwise, happens early in preamble template -->
<!-- <xsl:param name="latex.geometry" select="'papersize={7in,10in}, width=4.85in, inner=1in, height=8.5in, top=0.75in, twoside, ignoreheadfoot'"/> -->
<!-- papersize={7in,10in},  width=5in, inner=.75in, height=8.25in, top=0.75in, twoside, ignoreheadfoot, hmargin={0.85in, 0.5in}, -->


<!-- Add newpage -->
<xsl:template match="clearpage">
    <xsl:text>\clearpage&#xa;</xsl:text>
</xsl:template>


<!-- BUG FIX 2026-09-10 (cause racine du "Chapter" en anglais, cf. commentaire  -->
<!-- plus bas près de \chaptername) : le coeur de PreTeXt (vérifié 2.45.0 et   -->
<!-- 2.52.3) ne connaît, pour la cible xelatex (utilisée par nos cibles print  -->
<!-- et latex), aucune correspondance polyglossia pour "fr-CA" (ni pour le     -->
<!-- français en général) dans son xsl:choose de langues, voir               -->
<!-- pretext-latex-common.xsl, template qui écrit \usepackage{polyglossia}.   -->
<!-- Résultat : \setmainlanguage n'est JAMAIS émis, polyglossia reste donc en -->
<!-- anglais par défaut, et réinitialise \chaptername (et autres captions) à -->
<!-- l'anglais au \begin{document}, écrasant notre renewcommand du préambule  -->
<!-- "early". On répare ici, dans le hook "late" (donc après le              -->
<!-- \usepackage{polyglossia} du coeur, qui doit être chargé avant qu'on      -->
<!-- puisse appeler \setmainlanguage).                                       -->
<!-- 2026-09-30 : \setmainlanguage n'existe que si polyglossia est chargé,   -->
<!-- c'est-à-dire avec xelatex/lualatex. Avec pdflatex (compilation manuelle -->
<!-- de main.tex, p. ex. par un éditeur), polyglossia n'est pas chargé et    -->
<!-- \setmainlanguage provoquait « Undefined control sequence ». On se      -->
<!-- rabat alors sur babel.                                                  -->
<xsl:param name="latex.preamble.late">
  <xsl:text>\ifdefined\setmainlanguage\setmainlanguage{french}\else\usepackage[french]{babel}\fi&#xa;</xsl:text>
  <!-- Pas de titre de section ou de sous-section en bas de page : s'il reste -->
  <!-- trop peu de place, la division commence à la page suivante.           -->
  <xsl:text>\usepackage{needspace}&#xa;</xsl:text>
  <xsl:text>\AddToHook{env/sectionptx/before}{\Needspace{0.25\textheight}}&#xa;</xsl:text>
  <xsl:text>\AddToHook{env/subsectionptx/before}{\Needspace{0.25\textheight}}&#xa;</xsl:text>
  <!-- Pour les titres longs des boîtes (varwidth boxed title, PDF-style.xsl) -->
  <xsl:text>\usepackage{varwidth}&#xa;</xsl:text>
  <!-- Verso de couverture (144 x 198 pt) : largeur de la feuille, calé en bas. -->
  <!-- Trop hautes (format lettre) : le surplus est coupé en haut, où il n'y   -->
  <!-- a que le motif. Trop courtes (A4) : légèrement étirées (environ 3 %).   -->
  <!-- Figures Asymptote, dans le PDF seulement : réduites à \asyfacteur de la -->
  <!-- largeur prévue, et centrées (voir le gabarit image[asymptote] plus bas) -->
  <xsl:text>\newcommand{\asyfacteur}{0.8}&#xa;</xsl:text>
  <xsl:text>\newlength{\couvh}&#xa;</xsl:text>
  <xsl:text>\newcommand{\couverture}[1]{%&#xa;</xsl:text>
  <xsl:text>  \setlength{\couvh}{\dimexpr\paperwidth*198/144\relax}%&#xa;</xsl:text>
  <xsl:text>  \ifdim\couvh&lt;\paperheight\setlength{\couvh}{\paperheight}\fi&#xa;</xsl:text>
  <xsl:text>  \includepdf[noautoscale, keepaspectratio=false, width=\paperwidth, height=\couvh,&#xa;</xsl:text>
  <xsl:text>    offset=0 {\dimexpr(\couvh-\paperheight)/2\relax}]{#1}}&#xa;</xsl:text>
</xsl:param>

<xsl:param name="latex.preamble.early">
  <xsl:text>% --- REL-AL: define worksheet-section (7 args) ---&#xa;</xsl:text>
  <xsl:text>\usepackage{xparse}&#xa;</xsl:text>
  <xsl:text>\NewDocumentEnvironment{worksheet-section}{mmmmmmm}{%&#xa;</xsl:text>
  <xsl:text>% #1 = type-name (ex: Feuille d'activités)&#xa;</xsl:text>
  <xsl:text>% #2,#4 = titres (souvent identiques)&#xa;</xsl:text>
  <xsl:text>% #7 = identifiant&#xa;</xsl:text>
  <xsl:text>\par\bigskip\noindent{\large\bfseries #1}\par&#xa;</xsl:text>
  <xsl:text>\noindent{\bfseries #2}\par\medskip&#xa;</xsl:text>
  <xsl:text>\refstepcounter{section}&#xa;</xsl:text>
  <xsl:text>\addcontentsline{toc}{section}{\protect\numberline{\thesection}#2}&#xa;</xsl:text>
  <xsl:text>\phantomsection\label{#7}\hypertarget{#7}{}&#xa;</xsl:text>
  <xsl:text>}{%&#xa;</xsl:text>
  <xsl:text>\par\bigskip&#xa;</xsl:text>
  <xsl:text>}&#xa;</xsl:text>
  <xsl:text>% --- DEPOT palette (UdeS) ---&#xa;</xsl:text>
  <xsl:text>\PassOptionsToPackage{dvipsnames,svgnames,table}{xcolor}&#xa;</xsl:text>
  <xsl:text>\usepackage{xcolor}&#xa;</xsl:text>
  <xsl:text>\definecolor{UdeSVertFonce}{HTML}{018849}&#xa;</xsl:text>
  <xsl:text>\definecolor{UdeSOcre}{HTML}{E5A939}&#xa;</xsl:text>
  <!-- BUG FIX 2026-09-10 : le premier chapitre affichait "Chapter 1" au lieu   -->
  <!-- de "Chapitre 1". Le coeur de PreTeXt ne fait \renewcommand{\chaptername} -->
  <!-- qu'au début du corps de CHAQUE chapitre (donc APRÈS le \chapter{} qui a  -->
  <!-- déjà typographié le titre avec notre \titleformat personnalisé, qui     -->
  <!-- utilise \chaptername). Pour le premier chapitre, \chaptername vaut donc -->
  <!-- encore la valeur par défaut anglaise "Chapter" au moment du titre.      -->
  <!-- On fixe la valeur correcte dès le préambule pour couvrir ce cas.        -->
  <xsl:text>\renewcommand*{\chaptername}{Chapitre}&#xa;</xsl:text>
</xsl:param>

<!-- Override default frontmatter pages: -->

<!-- Remove "half-title" leading page with -->
<!-- title only, at about 1:2 split    -->
<!-- <xsl:template match="book" mode="half-title" >
    <xsl:text>%% no half-title&#xa;</xsl:text>
</xsl:template> -->

<!-- Faux-titre : copie du gabarit "half-title-ad-card" de PreTeXt 2.52.3,  -->
<!-- avec la mention d'édition (tirée de <edition> du colophon) ajoutée    -->
<!-- sous le sous-titre. À revérifier lors d'une mise à jour de PreTeXt.   -->
<xsl:template match="book" mode="half-title-ad-card" >
    <xsl:text>%% begin: half-title&#xa;</xsl:text>
    <xsl:text>\thispagestyle{empty}&#xa;</xsl:text>
    <xsl:text>{\titlepagefont\centering&#xa;</xsl:text>
    <xsl:text>\vspace*{0.28\textheight}&#xa;</xsl:text>
    <xsl:text>{\Huge </xsl:text>
    <xsl:apply-templates select="." mode="title-full"/>
    <xsl:text>}\\</xsl:text>
    <xsl:if test="subtitle">
        <xsl:text>[2\baselineskip]&#xa;</xsl:text>
        <xsl:text>{\LARGE </xsl:text>
        <xsl:apply-templates select="." mode="subtitle"/>
        <xsl:text>}\\&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="$bibinfo/edition">
        <xsl:text>[2\baselineskip]&#xa;</xsl:text>
        <xsl:text>{\Large </xsl:text>
        <xsl:apply-templates select="$bibinfo/edition"/>
        <xsl:text> édition}\\&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>}&#xa;</xsl:text>
    <xsl:text>\clearpage&#xa;</xsl:text>
    <xsl:text>%% end:   half-title&#xa;</xsl:text>
    <xsl:variable name="the-ad-card">
        <xsl:apply-templates select="." mode="ad-card"/>
    </xsl:variable>
    <xsl:choose>
        <xsl:when test="not($the-ad-card = '')">
            <xsl:text>%% begin: adcard&#xa;</xsl:text>
            <xsl:value-of select="$the-ad-card"/>
            <xsl:text>\clearpage&#xa;</xsl:text>
            <xsl:text>%% end:   adcard&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="($b-latex-two-sides) or ($latex-open-odd = 'add-blanks')">
            <xsl:text>%% begin: adcard (empty)&#xa;</xsl:text>
            <xsl:text>\thispagestyle{empty}&#xa;</xsl:text>
            <xsl:text>\null%&#xa;</xsl:text>
            <xsl:text>\clearpage&#xa;</xsl:text>
            <xsl:text>%% end:   adcard (empty)&#xa;</xsl:text>
        </xsl:when>
        <xsl:otherwise/>
    </xsl:choose>
</xsl:template>

<!-- Verso de couverture : copie du gabarit "back-cover" de PreTeXt       -->
<!-- 2.52.3, avec \couverture (voir latex.preamble.late) au lieu de        -->
<!-- \includepdf[noautoscale=false], pour remplir la feuille entière. Le   -->
<!-- recto n'est pas touché : il est fourni aux dimensions de chaque feuille. -->
<xsl:template name="back-cover">
    <xsl:if test="$b-has-latex-back-cover">
        <xsl:text>%% Back cover image, not numbered&#xa;</xsl:text>
        <xsl:text>\cleardoublepage%&#xa;</xsl:text>
        <xsl:if test="$latex-sides= 'two'">
            <xsl:text>%% 2-sided, and at end of even page, so add odd page&#xa;</xsl:text>
            <xsl:text>\thispagestyle{empty}\hbox{}\newpage%&#xa;</xsl:text>
        </xsl:if>
        <xsl:text>\couverture{</xsl:text>
        <xsl:value-of select="$latex-back-cover-filename"/>
        <xsl:text>}%&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<!-- Figures Asymptote dans le PDF : copie du gabarit image[asymptote]     -->
<!-- (mode image-inclusion) de pretext-latex-common.xsl, PreTeXt 2.52.3,    -->
<!-- avec une largeur de \asyfacteur\linewidth (voir latex.preamble.late), -->
<!-- centrée, au lieu de \linewidth. Le HTML n'est pas touché.              -->
<xsl:template match="image[asymptote]" mode="image-inclusion">
    <xsl:variable name="image-file-name">
        <xsl:value-of select="$generated-directory"/>
        <xsl:text>asymptote/</xsl:text>
        <xsl:apply-templates select="asymptote" mode="image-source-basename"/>
        <xsl:text>.pdf</xsl:text>
    </xsl:variable>
    <xsl:text>\makebox[\linewidth]{</xsl:text>
    <xsl:choose>
      <xsl:when test="$b-asymptote-links">
        <xsl:text>\href{</xsl:text>
        <xsl:value-of select="$baseurl"/>
        <xsl:value-of select="$generated-directory"/>
        <xsl:text>asymptote/</xsl:text>
        <xsl:apply-templates select="asymptote" mode="image-source-basename"/>
        <xsl:text>.html}{\includegraphics[width=\asyfacteur\linewidth]{</xsl:text>
        <xsl:value-of select="$image-file-name"/>
        <xsl:text>}}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\includegraphics[width=\asyfacteur\linewidth]{</xsl:text>
        <xsl:value-of select="$image-file-name"/>
        <xsl:text>}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}&#xa;</xsl:text>
</xsl:template>

<!-- Remove Ad card (may contain list of other books        -->
<!-- Or may be overridden to make title page spread -->
<!-- Obverse of half-title                          -->
<!-- <xsl:template match="book" mode="ad-card">
    <xsl:text>%% No adcard&#xa;</xsl:text>
</xsl:template> -->


<!-- Import custom title page -->
<!-- <xsl:template match="book" mode="title-page">
    <xsl:text>%% begin: title page&#xa;</xsl:text>
    <xsl:text>%% my custom page.&#xa;</xsl:text>
    <xsl:text>\input{external/frontmatter/title-page}&#xa;</xsl:text>
    <xsl:text>%% end: title page&#xa;</xsl:text>
</xsl:template> -->

<!-- Import custom copyright page -->
<!-- <xsl:template match="book" mode="copyright-page" >
    <xsl:text>%% begin: copyright-page&#xa;</xsl:text>
    <xsl:text>\input{external/frontmatter/copyright-page}&#xa;</xsl:text>
    <xsl:text>%% end:   copyright-page&#xa;</xsl:text>
</xsl:template> -->

<!-- Dedication style -->
<!-- <xsl:template match="dedication/p|dedication/p[1]" priority="1">
    <xsl:text>\begin{flushright}\large%&#xa;</xsl:text>
        <xsl:apply-templates />
    <xsl:text>%&#xa;</xsl:text>
    <xsl:text>\end{flushright}&#xa;</xsl:text>
</xsl:template> -->






<!-- Restyle paragraphs: -->
<!-- "paragraphs" -->
<!-- Body:  \begin{paragraphs}{title}{label}   -->
<!-- "titlesec" package, Subsection 9.2 has LaTeX defaults -->
<!-- We drop the indentation, and we pass the title itself -->
<!-- explicity with macro parameter #1 since we do not save-->
<!-- off the title in a PTX macro.  None of this is meant  -->
<!-- to support customization in a style.                  -->
<!-- Once a tcolorbox, see warnings as part of divisional  -->
<!-- introductions and conclusions.                        -->


<!-- <xsl:template match="paragraphs" mode="environment">
    <xsl:text>%% paragraphs: the terminal, pseudo-division&#xa;</xsl:text>
    <xsl:text>%% We use the lowest LaTeX traditional division&#xa;</xsl:text>
    <xsl:text>\titleformat{\subparagraph}[block]{\normalfont\filcenter\scshape\bfseries}{\thesubparagraph}{0em}{#1}&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\subparagraph}{0pt}{3.25ex plus 1ex minus .2ex}{1ex}&#xa;</xsl:text>
    <xsl:text>\NewDocumentEnvironment{paragraphs}{mm}&#xa;</xsl:text>
    <xsl:text>{\subparagraph*{#1}\hypertarget{#2}{}}{}&#xa;</xsl:text>
</xsl:template> -->


<!-- Paragraphs -->
<!-- Non-structural, even if they appear to be -->
<!-- <xsl:template match="paragraphs"> -->
    <!-- Warn about paragraph deprecation -->
    <!-- <xsl:text>\begin{paragraphs}</xsl:text> -->
    <!-- <xsl:text>{</xsl:text> -->
    <!-- Get rid of punctuation: (change title-punctuated to title-full) -->
    <!-- <xsl:apply-templates select="." mode="title-full" /> -->
    <!-- <xsl:text>}</xsl:text> -->
    <!-- <xsl:text>{</xsl:text> -->
    <!-- <xsl:apply-templates select="." mode="latex-id" /> -->
    <!-- <xsl:text>}</xsl:text> -->
    <!-- <xsl:text>%&#xa;</xsl:text> -->
    <!-- <xsl:apply-templates/> -->
    <!-- <xsl:text>\end{paragraphs}%&#xa;</xsl:text> -->
<!-- </xsl:template> -->


<!-- "proof" -->
<!-- Body:  \begin{proof}{title}{label}    -->
<!-- Title comes with punctuation, always. -->
<!-- <xsl:template match="proof" mode="environment">
    <xsl:text>%% proof: title is a replacement&#xa;</xsl:text>
    <xsl:text>\tcbset{ proofstyle/.style={</xsl:text>
    <xsl:apply-templates select="." mode="tcb-style" />
    <xsl:text>} }&#xa;</xsl:text>
    <xsl:text>\newtcolorbox{proofptx}[2]{title={\notblank{#1}{#1}{</xsl:text>
    <xsl:apply-templates select="." mode="type-name"/>
    <xsl:text>.}}, phantom={\hypertarget{#2}{}}, breakable, parbox=false, proofstyle }&#xa;</xsl:text>
</xsl:template> -->

<!-- Actually, redefine proofs to use the amsthm env for now -->
<!-- Proofs -->
<!-- Subsidary to THEOREM-LIKE, or standalone        -->
<!-- Defaults to "Proof", can be replaced by "title" -->
<!-- TODO: rename as "proof" once  amsthm  package goes away -->
<!-- <xsl:template match="proof">
    <xsl:text>\begin{proof}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:if test="title">
        <xsl:apply-templates select="." mode="title-full"/>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="*" />
    <xsl:text>\end{proof}&#xa;</xsl:text>
</xsl:template> -->

<!--HACK: 3-23-19 redefine the qed symbol to be qed  -->
<!-- "proof" -->
<!-- Title in italics, as in amsthm style.           -->
<!-- Filled, black square as QED, tombstone, Halmos. -->
<!-- Pushing the tombstone flush-right is a bit      -->
<!-- ham-handed, but more elegant TeX-isms           -->
<!-- (eg \hfill) did not get it done.  We require at -->
<!-- least two spaces gap to remain on the same      -->
<!-- line. Presumably the line will stretch when the -->
<!-- tombstone moves onto its own line.              -->
<!-- <xsl:template match="proof" mode="tcb-style">
    <xsl:text>bwminimalstyle, fonttitle=\normalfont\itshape, attach title to upper, after title={\space}, after upper={\space\space\hspace*{\stretch{1}}\(\textsc{qed}\)}&#xa;</xsl:text>
</xsl:template> -->




</xsl:stylesheet>
