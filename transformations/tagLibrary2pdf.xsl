<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:eac-cpf="urn:isbn:1-931666-33-4" xmlns:eac="http://archivists.org/ns/eac/v2"
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:ead3="http://ead3.archivists.org/schema/"
    xmlns:premis="http://www.loc.gov/premis/v3"
    xmlns:ex="http://www.tei-c.org/ns/Examples" xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:exml="http://workaround for xml namespace restriction/namespace"
    xmlns:xlink="http://www.w3c.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:text="http://www.tei.org/ns/1.0"
    xmlns:example="example" xmlns:term="term" xmlns:exslt="http://exslt.org/common"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    exclude-result-prefixes="xs xlink eac-cpf eac ex eg exml example ead ead3 mods text term dc oai_dc"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" extension-element-prefixes="exslt"
    version="2.0">

    <!-- variables passed from the build script to the XSLT -->
    <xsl:param name="SAA" as="xs:string" required="yes"/>
    <xsl:param name="ISBN" as="xs:string" required="yes"/>
    <xsl:param name="currentLanguage" as="xs:string" required="yes"/>

    <xsl:output indent="yes"/>
    <!-- Used for inserting SAA logo or not Values: yes | no -->
    <!-- xml:lang from taglibrary -->
    <xsl:variable name="toctype">long</xsl:variable>
    <!-- Used for determine style of toc Values: long | short -->
    <xsl:param name="spaceCharacter"> </xsl:param>
    <!-- For egxml formatting -->
    <xsl:variable name="bulletpoint">&#x2022;</xsl:variable>
    <xsl:variable name="returntotoc">yes</xsl:variable>
    <!--Used for creating the return to toc Values: yes | no -->

    <xsl:variable name="path">../images/</xsl:variable>


    <!-- Headingtranslations in an own xml-file using the currentLanguage to fetch them -->
    <xsl:variable name="headingtranslations" select="document('../tei/Headingtranslation.xml')"/>
    <!-- All translated headings
         Note that some of these may be redundant now, but are kept just in case -->
    <xsl:variable name="summary"
        select="$headingtranslations//*:terms/*:term[@name = 'summary']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="description"
        select="$headingtranslations//*:terms/*:term[@name = 'description']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="mayoccurwithin"
        select="$headingtranslations//*:terms/*:term[@name = 'mayOccurWithin']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="mandatory"
        select="$headingtranslations//*:terms/*:term[@name = 'mandatory']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="optional"
        select="$headingtranslations//*:terms/*:term[@name = 'optional']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="repeatable"
        select="$headingtranslations//*:terms/*:term[@name = 'repeatable']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="nonrepeatable"
        select="$headingtranslations//*:terms/*:term[@name = 'nonrepeatable']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="attributes"
        select="$headingtranslations//*:terms/*:term[@name = 'attributes']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="references"
        select="$headingtranslations//*:terms/*:term[@name = 'references']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="datatype"
        select="$headingtranslations//*:terms/*:term[@name = 'datatype']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="toc"
        select="$headingtranslations//*:terms/*:term[@name = 'toc']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="elements"
        select="$headingtranslations//*:terms/*:term[@name = 'elements']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="maycontain"
        select="$headingtranslations//*:terms/*:term[@name = 'mayContain']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="occurrence"
        select="$headingtranslations//*:terms/*:term[@name = 'occurrence']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="appendix"
        select="$headingtranslations//*:terms/*:term[@name = 'appendix']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="examples"
        select="$headingtranslations//*:terms/*:term[@name = 'examples']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="example"
        select="$headingtranslations//*:terms/*:term[@name = 'example']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="desc"
        select="$headingtranslations//*:terms/*:term[@name = 'desc']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="usage"
        select="$headingtranslations//*:terms/*:term[@name = 'usage']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="and"
        select="$headingtranslations//*:terms/*:term[@name = 'and']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="availability"
        select="$headingtranslations//*:terms/*:term[@name = 'availability']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="value"
        select="$headingtranslations//*:terms/*:term[@name = 'value']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="values"
        select="$headingtranslations//*:terms/*:term[@name = 'values']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="taglibrary"
        select="$headingtranslations//*:terms/*:term[@name = 'tl']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="seealso"
        select="$headingtranslations//*:terms/*:term[@name = 'seealso']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="attributeusage"
        select="$headingtranslations//*:terms/*:term[@name = 'attributeusage']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="allrightsreserved"
        select="$headingtranslations//*:terms/*:term[@name = 'allrightsreserved']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="printedinusa"
        select="$headingtranslations//*:terms/*:term[@name = 'printedinusa']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="edition"
        select="$headingtranslations//*:terms/*:term[@name = 'edition']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="printed"
        select="$headingtranslations//*:terms/*:term[@name = 'printed']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="availableFrom"
        select="$headingtranslations//*:terms/*:term[@name = 'availableFrom']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="usagenotes"
        select="$headingtranslations//*:terms/*:term[@name = 'usagenotes']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="rationale"
        select="$headingtranslations//*:terms/*:term[@name = 'rationale']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="creationmaintenance"
        select="$headingtranslations//*:terms/*:term[@name = 'creationmaintenance']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="semanticunit"
        select="$headingtranslations//*:terms/*:term[@name = 'semanticunit']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="semanticcomponents"
        select="$headingtranslations//*:terms/*:term[@name = 'semanticcomponents']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="definition"
        select="$headingtranslations//*:terms/*:term[@name = 'definition']/*:translation[@lang = $currentLanguage]"/>
    <xsl:variable name="entity"
        select="$headingtranslations//*:terms/*:term[@name = 'entity']/*:translation[@lang = $currentLanguage]"/>

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
            font-selection-strategy="character-by-character" font-family="KurintoText,KurintoTextJP,KurintoTextKR,KurintoTextSC">
            <!-- Replaced Pala with Arial -->
            <fo:layout-master-set>
                <fo:simple-page-master master-name="taglibrary-even" page-height="297mm"
                    page-width="210mm" margin-top="1.5cm" margin-bottom="1.5cm" margin-left="1.5cm"
                    margin-right="1.5cm">
                    <fo:region-body region-name="taglibrary-region-body" margin-top="2.0cm"
                        margin-bottom="1.5cm" margin-left="1.5cm" margin-right="1.5cm"/>
                    <fo:region-before region-name="taglibrary-region-before-even" extent="1.3cm"/>
                    <fo:region-after region-name="taglibrary-region-after-even" extent="0.5cm"/>
                </fo:simple-page-master>
                <fo:simple-page-master master-name="taglibrary-odd" page-height="297mm"
                    page-width="210mm" margin-top="1.5cm" margin-bottom="1.5cm" margin-left="1.5cm"
                    margin-right="1.5cm">
                    <fo:region-body region-name="taglibrary-region-body" margin-top="2.0cm"
                        margin-bottom="1.5cm" margin-left="1.5cm" margin-right="1.5cm"/>
                    <fo:region-before region-name="taglibrary-region-before-odd" extent="1.3cm"/>
                    <fo:region-after region-name="taglibrary-region-after-odd" extent="0.5cm"/>
                </fo:simple-page-master>
                <fo:page-sequence-master master-name="frames">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="taglibrary-even"
                            odd-or-even="even"/>
                        <fo:conditional-page-master-reference master-reference="taglibrary-odd"
                            odd-or-even="odd"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
                <fo:simple-page-master master-name="Frontmatter" page-height="29.7cm"
                    page-width="21cm" margin-top="2.5cm" margin-bottom="2.5cm" margin-left="2.5cm"
                    margin-right="2.5cm">
                    <fo:region-body region-name="frontmatter-body" margin-top="2.4cm"
                        margin-bottom="2.4cm" margin-left="0cm" margin-right="2.4cm"
                        column-count="1" display-align="center"/>
                    <fo:region-before region-name="frontmatter-region-before" extent="2.3cm"/>
                    <fo:region-after region-name="frontmatter-region-after" extent="2.3cm"/>
                </fo:simple-page-master>
                <fo:simple-page-master master-name="toc-region" page-height="29.7cm"
                    page-width="21cm" margin-top="2.5cm" margin-bottom="2.5cm" margin-left="2.5cm"
                    margin-right="2.5cm">
                    <fo:region-body region-name="toc-region-body" margin-top="2.4cm"
                        margin-bottom="2.4cm" margin-left="0cm" margin-right="2.4cm"
                        column-count="2" />
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="Frontmatter">
                <fo:flow flow-name="frontmatter-body">
                    <xsl:apply-templates mode="title"
                        select="tei:TEI/tei:text/tei:front/tei:titlePage"/>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="toc-region">
                <fo:flow flow-name="toc-region-body">
                    <xsl:call-template name="toc"/>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="frames" force-page-count="end-on-even">
                <fo:static-content flow-name="taglibrary-region-before-even">
                    <fo:block font-size="10pt" text-align="start">
                        <fo:retrieve-marker retrieve-class-name="taglibrary-head"/>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="taglibrary-region-after-even">
                    <fo:block font-size="10pt" text-align="start">
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="taglibrary-region-before-odd">
                    <fo:block font-size="10pt" text-align="end">
                        <fo:retrieve-marker retrieve-class-name="taglibrary-head"/>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="taglibrary-region-after-odd">
                    <fo:block font-size="10pt" text-align="end">
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="taglibrary-region-body">
                    <xsl:apply-templates select="tei:TEI"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="tei:TEI">
        <fo:block>
            <xsl:apply-templates select="//tei:text/tei:front/tei:div"/>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="//tei:text/tei:body"/>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="//tei:text/tei:back"/>
        </fo:block>
    </xsl:template>

    <xsl:template name="toc">
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt" space-after="6pt"
            text-align="center" page-break-before="always" id="tocpage" span="all">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="$toc"/>
                </fo:block>
            </fo:marker>
            <xsl:value-of select="$toc"/>
        </fo:block>
            <xsl:if test="$toctype = 'long'">
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:front/tei:div"/>
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:body"/>
                <xsl:apply-templates mode="toclong" select="//tei:text/tei:back"/>
            </xsl:if>
            <xsl:if test="$toctype = 'short'">
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:front/tei:div"/>
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:body"/>
                <xsl:apply-templates mode="tocshort" select="//tei:text/tei:back"/>
            </xsl:if>
    </xsl:template>

    <xsl:template match="tei:div" mode="toclong">
        <xsl:for-each select="tei:div">
            <fo:block font-size="14pt" font-weight="bold" space-before="8pt" space-after="6pt"
                text-align="left" text-align-last="justify" span="all">
                <fo:inline>
                    <fo:basic-link internal-destination="{generate-id()}">
                        <xsl:value-of select="tei:head"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                    </fo:basic-link>
                </fo:inline>
            </fo:block>
            <xsl:for-each select="tei:div">
                <fo:block start-indent="10pt" text-align-last="justify">
                    <fo:inline>
                        <fo:basic-link internal-destination="{generate-id(.)}">
                            <xsl:value-of select="tei:head"/>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{generate-id(.)}"/>
                        </fo:basic-link>
                    </fo:inline>
                </fo:block>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:div" mode="tocshort">
        <xsl:for-each select="tei:div">
            <fo:block font-size="14pt" font-weight="bold" space-before="8pt" space-after="6pt"
                text-align="left" text-align-last="justify">
                <fo:inline>
                    <fo:basic-link internal-destination="{generate-id(.)}">
                        <xsl:value-of select="tei:head"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                    </fo:basic-link>
                </fo:inline>
            </fo:block>
            <xsl:for-each select="tei:div">
                <fo:block start-indent="10pt" text-align-last="justify">
                    <fo:inline>
                        <fo:basic-link internal-destination="{generate-id(.)}">
                            <xsl:value-of select="tei:head"/>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="{generate-id(.)}"/>
                        </fo:basic-link>
                    </fo:inline>
                </fo:block>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:front/tei:titlePage" mode="title">

        <fo:block font-size="24pt" font-weight="bold" space-before="18pt" space-after="12pt"
            text-align="center">
            <xsl:for-each select="tei:docTitle/tei:titlePart">
                <xsl:apply-templates select="."/>
                <xsl:call-template name="newLine"/>
            </xsl:for-each>
        </fo:block>
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt" space-after="6pt"
            text-align="center">
            <xsl:apply-templates select="tei:docEdition"/>
        </fo:block>
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt" space-after="6pt"
            text-align="center">
            <xsl:apply-templates select="tei:byline"/>
        </fo:block>
        <xsl:for-each select="tei:docAuthor">
            <fo:block font-size="14pt" font-weight="bold" space-before="8pt" space-after="6pt"
                text-align="center">
                <xsl:apply-templates select="."/>
            </fo:block>
        </xsl:for-each>
        <!-- No [] in filename -->
        <fo:block text-align="center" page-break-after="always" padding-before="120pt">
            <xsl:choose>
                <xsl:when test="starts-with($SAA, 'yes')">
                    <fo:external-graphic src="../images/SAAVert540.jpg" alignment-adjust="middle"/>
                    <fo:block>Chicago</fo:block>
                </xsl:when>
            </xsl:choose>
        </fo:block>
        <!-- Page 2 with info -->
        <xsl:call-template name="secondpage"/>
    </xsl:template>

    <xsl:template name="secondpage">
        <fo:block font-weight="bold" space-after="6pt" padding-before="-50pt">
            <xsl:for-each select="tei:docTitle/tei:titlePart">
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
            </xsl:for-each>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="tei:docEdition"/>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="tei:note/tei:p"/>
        </fo:block>
        <xsl:variable name="TheWholeDocument" select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc"/>
        <fo:block padding-before="1cm" font-weight="bold">
            <xsl:value-of select="$availableFrom"/>
            <xsl:text>:</xsl:text>
        </fo:block>
        <fo:block>
            <fo:table table-layout="fixed" width="100%">
                <fo:table-body>
                    <xsl:for-each
                        select="$TheWholeDocument/tei:publicationStmt/tei:address/tei:addrLine">
                        <fo:table-row>
                            <fo:table-cell width="3.5cm">
                                <fo:block> </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="."/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block padding-before="1cm">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell width=".5cm">
                            <fo:block>&#169;</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of
                                    select="$TheWholeDocument/tei:publicationStmt/tei:publisher"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of
                                    select="$TheWholeDocument/tei:publicationStmt/tei:date/@when"/>
                                <xsl:text>.</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block wrap-option="no-wrap"><xsl:value-of select="$edition"/>:
                                    <xsl:value-of select="$TheWholeDocument/tei:editionStmt/tei:p"
                                /></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block wrap-option="no-wrap"><xsl:value-of select="$printed"/>:
                                    <xsl:value-of select="$printedinusa"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block padding-before=".5cm">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell width="3.5cm">
                            <!-- Is it always this picture???? -->
                            <fo:block>
                                <fo:external-graphic src="../images/CCommons.png"/>
                                <xsl:text> </xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:apply-templates
                                    select="$TheWholeDocument/tei:publicationStmt/tei:availability/tei:licence"
                                />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block padding-before=".25cm">
            <xsl:value-of select="$ISBN"/>
        </fo:block>
        <fo:block page-break-after="always"/>
    </xsl:template>

    <xsl:template match="tei:body | tei:back" mode="toclong">
        <xsl:for-each select="tei:div">
            <xsl:choose>
                <!-- Karin få in valet här! -->
                <xsl:when test="@type = ['elements', 'rights', 'agents', 'objects', 'events']">
                    <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                        space-after="6pt" text-align="left" text-align-last="justify" span="all">
                        <!-- Karin: Add selection of value based upon the xml:id??? -->
                        <xsl:value-of select="$elements"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                    </fo:block>
                    <xsl:for-each select="tei:div[@type = 'elementDocumentation']">
                        <fo:block font-size="10pt" text-align="left" text-align-last="justify" text-indent="10pt">
                           <fo:inline>
                                <fo:basic-link internal-destination="{generate-id(.)}">
                                    <xsl:value-of select="tei:head/tei:gi"/>
                                    <fo:leader leader-pattern="dots"/>
                                    <fo:page-number-citation ref-id="{generate-id(.)}"/>
                                </fo:basic-link>
                            </fo:inline>
                        </fo:block>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="@type = 'attributes'">
                    <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                        space-after="6pt" text-align="left" text-align-last="justify" span="all">
                        <xsl:value-of select="$attributes"/>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                    </fo:block>
                    <xsl:for-each select="tei:div[@type = 'attributeDocumentation']">
                        <fo:block font-size="10pt" text-align="left" text-align-last="justify" text-indent="10pt">
                            <fo:inline>
                                <fo:basic-link internal-destination="{generate-id(.)}">
                                    <xsl:value-of select="tei:head/tei:att"/>
                                    <fo:leader leader-pattern="dots"/>
                                    <fo:page-number-citation ref-id="{generate-id(.)}"/>
                                </fo:basic-link>
                            </fo:inline>
                        </fo:block>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="@type = 'appendix'">
                    <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                        space-after="6pt" text-align="left" text-align-last="justify" span="all">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="tei:head"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{generate-id(.)}"/>
                            </fo:basic-link>
                        </fo:inline>
                    </fo:block>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:body | tei:back" mode="tocshort">
        <xsl:for-each select="tei:div">
            <xsl:choose>
                <!-- få in valet här! -->
                <xsl:when test="@type = ['elements', 'rights', 'agents', 'objects', 'events']">
                    <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                        space-after="6pt" text-align="left" text-align-last="justify">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <!-- Karin: Add selection of value based upon the xml:id??? -->
                                <xsl:value-of select="$elements"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{generate-id(.)}"/>
                            </fo:basic-link>
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type = 'attributes'">
                    <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                        space-after="6pt" text-align="left" text-align-last="justify">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="$attributes"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{generate-id(.)}"/>
                            </fo:basic-link>
                        </fo:inline>
                    </fo:block>
                </xsl:when>
                <xsl:when test="@type = 'appendix'">
                    <fo:block font-size="14pt" font-weight="bold" space-before="8pt"
                        space-after="6pt" text-align="left" text-align-last="justify">
                        <fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="tei:head"/>
                                <fo:leader leader-pattern="dots"/>
                                <fo:page-number-citation ref-id="{generate-id(.)}"/>
                            </fo:basic-link>
                        </fo:inline>
                    </fo:block>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="tei:front/tei:div/tei:div">
        <fo:block page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="tei:head"/>
                </fo:block>
            </fo:marker>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:front/tei:div/tei:div/tei:div">
        <fo:block id="{generate-id(.)}"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'Introduction']">
        <fo:block id="{generate-id(.)}"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:list[@type = 'ordered']">
        <!-- Numbered list -->
        <xsl:apply-templates select="tei:head"/>
        <fo:list-block>
            <xsl:for-each select="tei:item">
                <fo:list-item>
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>
                            <fo:inline>
                                <xsl:number/>
                                <xsl:text>.</xsl:text>
                            </fo:inline>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates/>
                        </fo:block>
                        <!-- If space is wanted inbetween the points have this active -->
                        <!--<fo:block>
                            <xsl:text>&#xA0;</xsl:text>
                        </fo:block>-->
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:list[@type = 'simple']">
        <!-- List with only text -->
        <xsl:if test="tei:head">
            <fo:block font-size="18pt" font-weight="bold" space-before="18pt" space-after="12pt"
                text-align="left">
                <xsl:value-of select="tei:head"/>
            </fo:block>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="tei:label">
                <fo:list-block provisional-distance-between-starts="70mm">
                    <xsl:for-each select="tei:label">
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block>
                                    <xsl:apply-templates/>
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block>
                                    <xsl:for-each select="following-sibling::tei:item[1]">
                                        <xsl:apply-templates/>
                                    </xsl:for-each>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:for-each>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block provisional-distance-between-starts="20mm">
                    <xsl:for-each select="tei:item">
                        <fo:list-item>
                            <fo:list-item-label font-weight="bold" end-indent="label-end()">
                                <fo:block>
                                    <xsl:text/>
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <fo:block>
                                    <xsl:apply-templates/>
                                </fo:block>
                                <fo:block>
                                    <xsl:text>&#xA0;</xsl:text>
                                </fo:block>
                            </fo:list-item-body>
                        </fo:list-item>
                    </xsl:for-each>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'elements', 'rights', 'objects', 'agents', 'events']">
        <fo:block font-size="24pt" font-weight="bold" space-before="18pt" space-after="12pt"
            text-align="left" page-break-before="always" id="{generate-id(.)}">
            <!--            <xsl:variable name="parttitle"><xsl:value-of select="current()/@type"/></xsl:variable>-->
            <!--            <xsl:value-of select="$headingtranslations/*:terms/*:term[@name=$parttitle]/*:translation[@lang=$currentLanguage]"/>-->
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <!-- Karin: Add selection of value based upon the xml:id??? -->
                    <xsl:variable name="parttitle">
                        <xsl:value-of select="current()/@type"/>
                    </xsl:variable>
                    <xsl:value-of
                        select="$headingtranslations/*:terms/*:term[@name = $parttitle]/*:translation[@lang = $currentLanguage]"
                    />
                </fo:block>
            </fo:marker>
            <!-- Karin: Add selection of value based upon the xml:id??? -->
            <xsl:variable name="parttitle">
                <xsl:value-of select="current()/@type"/>
            </xsl:variable>
            <xsl:value-of
                select="$headingtranslations/*:terms/*:term[@name = $parttitle]/*:translation[@lang = $currentLanguage]"
            />
        </fo:block>
        <xsl:for-each select="tei:div[@type = 'elementDocumentation']">
            <fo:block font-size="18pt" font-weight="bold" space-before="18pt" space-after="12pt"
                text-align="left" page-break-before="always" id="{generate-id()}">
                <fo:marker marker-class-name="taglibrary-head">
                    <!-- elements have an id starting with elem- @xml:id-->
                    <fo:block id="{concat('elem-', tei:head/tei:gi)}">
                        <xsl:text>&lt;</xsl:text>
                        <xsl:value-of select="tei:head/tei:gi"/>
                        <xsl:text>&gt;</xsl:text>
                    </fo:block>
                </fo:marker>
                <xsl:choose>
                    <xsl:when test="tei:head[@type = 'DD']">
                        <xsl:value-of select="$semanticunit"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>&lt;</xsl:text>
                        <xsl:value-of select="tei:head/tei:gi"/>
                        <xsl:text>&gt;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>&#xA0;&#xA0;</xsl:text>
                <xsl:value-of select="tei:div[@type = 'fullName']/tei:p"/>
                <xsl:if test="starts-with($returntotoc, 'yes')">
                    <fo:inline font-size="12pt" start-indent="10pt" font-weight="normal">
                        <fo:basic-link internal-destination="tocpage">
                            <xsl:text>(</xsl:text>
                            <xsl:value-of select="$toc"/>
                            <xsl:text>)</xsl:text>
                        </fo:basic-link>
                    </fo:inline>
                </xsl:if>
            </fo:block>
            <xsl:apply-templates select="tei:div[@type = 'summary']"/>
            <xsl:apply-templates select="tei:div[@type = 'mayContain']"/>
            <xsl:apply-templates select="tei:div[@type = 'semanticcomponents']"/>
            <xsl:apply-templates select="tei:div[@type = 'mayOccurWithin']"/>
            <xsl:apply-templates select="tei:div[@type = 'definition']"/>
            <xsl:apply-templates select="tei:div[@type = 'entity']"/>
            <xsl:apply-templates select="tei:div[@type = 'rationale']"/>
            <xsl:apply-templates select="tei:div[@type = 'datatype']"/>
            <xsl:apply-templates select="tei:div[@type = 'attributes']"/>
            <xsl:apply-templates select="tei:div[@type = 'attributeusage']"/>
            <xsl:apply-templates select="tei:div[@type = 'description']"/>
            <xsl:apply-templates select="tei:div[@type = 'desc']"/>
            <xsl:apply-templates select="tei:div[@type = 'usage']"/>
            <xsl:apply-templates select="tei:div[@type = 'occurrence']"/>
            <xsl:apply-templates select="tei:div[@type = 'availability']"/>
            <xsl:apply-templates select="tei:div[@type = 'seealso']"/>
            <xsl:apply-templates select="tei:div[@type = 'mandatory']"/>
            <xsl:apply-templates select="tei:div[@type = 'repetable']"/>
            <xsl:apply-templates select="tei:div[@type = 'reference']"/>
            <xsl:apply-templates select="tei:div[@type = 'references']"/>
            <xsl:apply-templates select="tei:div[@type = 'examples']"/>
            <xsl:apply-templates select="tei:div[@type = 'creationmaintenance']"/>
            <xsl:apply-templates select="tei:div[@type = 'usagenotes']"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'attributes' and parent::tei:body]">
        <fo:block font-size="24pt" font-weight="bold" space-before="18pt" space-after="12pt"
            text-align="left" page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="$attributes"/>
                </fo:block>
            </fo:marker>
            <xsl:value-of select="$attributes"/>

        </fo:block>
        <xsl:apply-templates select="tei:div[@type = 'Introduction']"/>
        <xsl:for-each select="tei:div[@type = 'attributeDocumentation']">
            <fo:block font-size="18pt" font-weight="bold" space-before="18pt" space-after="12pt"
                text-align="left" page-break-before="always" id="{generate-id(.)}">
                <fo:marker marker-class-name="taglibrary-head">
                    <!-- atttributes have an id starting with attr- @xml:id-->
                    <fo:block
                        id="{concat('attr-', translate(normalize-space(tei:head/tei:att), ':',''))}">
                        <xsl:text>@</xsl:text>
                        <xsl:value-of select="tei:head/tei:att"/>
                    </fo:block>
                </fo:marker>
                <xsl:text>@</xsl:text>
                <xsl:value-of select="tei:head/tei:att"/>
                <xsl:text>&#xA0;&#xA0;</xsl:text>
                <xsl:value-of select="tei:div[@type = 'fullName']/tei:p"/>
                <xsl:if test="starts-with($returntotoc, 'yes')">
                    <fo:inline font-size="12pt" start-indent="10pt" font-weight="normal">
                        <fo:basic-link internal-destination="tocpage">
                            <xsl:text>(</xsl:text>
                            <xsl:value-of select="$toc"/>
                            <xsl:text>)</xsl:text>
                        </fo:basic-link>
                    </fo:inline>
                </xsl:if>
            </fo:block>
            <xsl:apply-templates select="tei:div[@type = 'summary']"/>
            <xsl:apply-templates select="tei:div[@type = 'description']"/>
            <xsl:apply-templates select="tei:div[@type = 'desc']"/>
            <xsl:apply-templates select="tei:div[@type = 'usage']"/>
            <xsl:apply-templates select="tei:div[@type = 'datatype']"/>
            <xsl:apply-templates select="tei:div[@type = 'values']"/>
            <xsl:apply-templates select="tei:div[@type = 'examples']"/>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="tei:div[@type = 'deprecatedAttributeDocumentation']">
        <fo:block font-size="18pt" font-weight="bold" space-before="18pt" space-after="12pt"
            text-align="left" page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block id="{@xml:id}">
                    <xsl:text>@</xsl:text>
                    <xsl:value-of select="tei:head/tei:att"/>
                </fo:block>
            </fo:marker>
            <xsl:text>@</xsl:text>
            <xsl:value-of select="tei:head/tei:att"/>
            <xsl:text>&#xA0;&#xA0;</xsl:text>
            <xsl:value-of select="tei:div[@type = 'fullName']/tei:p"/>
            <xsl:if test="starts-with($returntotoc, 'yes')">
                <fo:inline font-size="12pt" start-indent="10pt" font-weight="normal">
                    <fo:basic-link internal-destination="tocpage">
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="$toc"/>
                        <xsl:text>)</xsl:text>
                    </fo:basic-link>
                </fo:inline>
            </xsl:if>
        </fo:block>
        <xsl:apply-templates select="tei:div[@type = 'summary']"/>
        <xsl:apply-templates select="tei:div[@type = 'description']"/>
        <xsl:apply-templates select="tei:div[@type = 'datatype']"/>
        <xsl:apply-templates select="tei:div[@type = 'values']"/>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'deprecatedElementDocumentation']">
        <!-- No linking to other elements or attributes by using templates with mode="deprecated" -->
        <fo:block font-size="18pt" font-weight="bold" space-before="18pt" space-after="12pt"
            text-align="left" page-break-before="always" id="{generate-id()}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="tei:head/tei:gi"/>
                    <xsl:text>&gt;</xsl:text>
                </fo:block>
            </fo:marker>
            <xsl:text>&lt;</xsl:text>
            <xsl:value-of select="tei:head/tei:gi"/>
            <xsl:text>&gt;</xsl:text>
            <xsl:text>&#xA0;&#xA0;</xsl:text>
            <xsl:value-of select="tei:div[@type = 'fullName']/tei:p"/>
            <xsl:if test="starts-with($returntotoc, 'yes')">
                <fo:inline font-size="12pt" start-indent="10pt" font-weight="normal">
                    <fo:basic-link internal-destination="tocpage">
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="$toc"/>
                        <xsl:text>)</xsl:text>
                    </fo:basic-link>
                </fo:inline>
            </xsl:if>
        </fo:block>
        <xsl:apply-templates select="tei:div[@type = 'summary']"/>
        <xsl:apply-templates select="tei:div[@type = 'description']"/>
        <xsl:apply-templates select="tei:div[@type = 'desc']"/>
        <xsl:apply-templates select="tei:div[@type = 'usage']"/>
        <xsl:apply-templates select="tei:div[@type = 'mayContain']" mode="deprecated"/>
        <xsl:apply-templates select="tei:div[@type = 'mayOccurWithin']" mode="deprecated"/>
        <xsl:apply-templates select="tei:div[@type = 'attributes']/tei:p" mode="deprecated"/>
        <xsl:apply-templates select="tei:div[@type = 'occurrence']"/>
        <xsl:apply-templates select="tei:div[@type = 'availability']"/>
        <xsl:apply-templates select="tei:div[@type = 'mandatory']"/>
        <xsl:apply-templates select="tei:div[@type = 'repetable']"/>
        <xsl:apply-templates select="tei:div[@type = 'reference']"/>
        <xsl:apply-templates select="tei:div[@type = 'references']"/>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'element']">
        <fo:list-block provisional-distance-between-starts="30mm">
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'attribute']">
        <fo:list-block provisional-distance-between-starts="30mm">
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'fullName']"> </xsl:template>

    <xsl:template
        match="tei:list[parent::tei:div[@type = 'element'] or parent::tei:div[@type = 'attribute']]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template
        match="tei:list[@type = 'gloss'][ancestor-or-self::tei:front] | tei:list[@type = 'gloss'][ancestor-or-self::tei:div[@type = 'Introduction']]">
        <fo:list-block provisional-distance-between-starts="5mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:text> </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                    <fo:table table-layout="fixed" width="100%">
                        <fo:table-body>
                            <xsl:for-each select="tei:label[1]">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block padding-before="5mm" font-weight="bold">
                                            <xsl:value-of select="."/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:apply-templates
                                                select="following-sibling::tei:item[1]"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                            </xsl:for-each>
                            <xsl:for-each select="tei:label[position() &gt; 1]">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block padding-before="5mm" font-weight="bold">
                                            <xsl:value-of select="."/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>
                                            <xsl:apply-templates
                                                select="following-sibling::tei:item[1]"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <!-- Non-tokenized note divs -->
    <xsl:template
        match="tei:div[@type = ('summary', 'definition', 'rationale', 'creationmaintenance', 'usagenotes', 'datatype', 'values', 'availability', 'reference', 'references', 'desc', 'usage', 'description')]">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">
                        <xsl:variable name="termtitle">
                            <xsl:value-of select="current()/@type"/>
                        </xsl:variable>
                        <xsl:value-of
                            select="$headingtranslations/*:terms/*:term[@name = $termtitle]/*:translation[@lang = $currentLanguage]"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <!-- Note divs with lists, which get a special indent -->
    <xsl:template
        match="tei:div[@type = ('attributeusage', 'seealso')]">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">
                        <xsl:variable name="termtitle">
                            <xsl:value-of select="current()/@type"/>
                        </xsl:variable>
                        <xsl:value-of
                            select="$headingtranslations/*:terms/*:term[@name = $termtitle]/*:translation[@lang = $currentLanguage]"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="25mm">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <!-- Tokenized note divs -->
    <xsl:template match="tei:div[@type = ('semanticcomponents', 'mayOccurWithin', 'mayContain')]">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">
                        <xsl:variable name="termtitle">
                            <xsl:value-of select="current()/@type"/>
                        </xsl:variable>
                        <xsl:value-of
                            select="$headingtranslations/*:terms/*:term[@name = $termtitle]/*:translation[@lang = $currentLanguage]"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:call-template name="tokenize">
<!--                            <xsl:with-param name="text" select="tei:p"/> -->
                        </xsl:call-template>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <!-- Deprecated (non-tokenized) note divs -->
    <xsl:template match="tei:div[@type = ('semanticcomponents', 'mayOccurWithin', 'mayContain')]"
        mode="deprecated">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">
                        <xsl:variable name="termtitle">
                            <xsl:value-of select="current()/@type"/>
                        </xsl:variable>
                        <xsl:value-of
                            select="$headingtranslations/*:terms/*:term[@name = $termtitle]/*:translation[@lang = $currentLanguage]"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:value-of select="tei:p"/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <!-- occurrence has some special rules, so it gets a special template -->
    <xsl:template match="tei:div[@type = 'occurrence']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">
                        <xsl:value-of select="$occurrence"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <xsl:choose>
                        <xsl:when test="tei:div[@type = 'occurenceSpecifikation']">
                            <fo:block>
                                <xsl:apply-templates/>
                            </fo:block>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block>
                                <xsl:value-of select="tei:div[@type = 'mandatory']/tei:p"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="tei:div[@type = 'repeatable']/tei:p"/>
                            </fo:block>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'entity'][parent::tei:div[@type = 'elementDocumentation']]">
        <!-- Entity information PREMIS DD -->
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block>
                        <xsl:value-of select="$entity"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>


    <!-- commenting these templates out, but keeping them in case they're needed again later
    these templates should be superseded by the occurrence template...

    <xsl:template match="tei:div[@type='mandatory']">
        Only value is given in the latest version of the TL 
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block break-after="auto">
                        <xsl:value-of select="$mandatory"/>
                        <xsl:text>/</xsl:text>
                    </fo:block>
                    <fo:block>
                        <xsl:value-of select="$optional"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <xsl:value-of select="tei:p/text()"/>
    </xsl:template>

    <xsl:template match="tei:div[@type='repeatable']">
        Only value is given in the latest layout of TL. And always after mandatory
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block break-after="auto">
                        <xsl:value-of select="$repeatable"/>
                        <xsl:text>/</xsl:text>
                    </fo:block>
                    <fo:block>
                        <xsl:value-of select="$nonrepeatable"/>
                        <xsl:text>: </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="tei:p/text()"/>
    </xsl:template> -->

    <xsl:template match="tei:div[@type = 'attributes']/tei:p">
        <xsl:choose>
            <xsl:when test="tei:list[@type = 'gloss']">
                <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block font-weight="bold">
                                <xsl:value-of select="$attributes"/>
                                <xsl:text>: </xsl:text>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:table start-indent="body-start()-22.5mm" table-layout="fixed"
                                width="85%">
                                <fo:table-body>
                                    <xsl:for-each select="tei:list/tei:label[1]">
                                        <fo:table-row>
                                            <fo:table-cell width="60mm">
                                                <fo:block>
                                                  <xsl:call-template name="tokenizeattributes">
                                                  <xsl:with-param name="text" select="."/>
                                                  </xsl:call-template>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                    <xsl:for-each select="tei:list/tei:label[position() &gt; 1]">
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:call-template name="tokenizeattributes">
                                                  <xsl:with-param name="text" select="."/>
                                                  </xsl:call-template>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                </fo:table-body>
                            </fo:table>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$attributes"/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'attributes']/tei:p" mode="deprecated">
        <xsl:choose>
            <xsl:when test="tei:list[@type = 'gloss']">
                <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block font-weight="bold">
                                <xsl:value-of select="$attributes"/>
                                <xsl:text>: </xsl:text>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:table start-indent="body-start()-23mm" table-layout="fixed"
                                width="85%">
                                <fo:table-body>
                                    <xsl:for-each select="tei:list/tei:label[1]">
                                        <fo:table-row>
                                            <fo:table-cell width="50mm">
                                                <fo:block>
                                                  <xsl:value-of select="."/>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                    <xsl:for-each select="tei:list/tei:label[position() &gt; 1]">
                                        <fo:table-row>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:value-of select="."/>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell>
                                                <fo:block>
                                                  <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                </fo:table-body>
                            </fo:table>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$attributes"/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:list[@type = 'bulleted']">
        <fo:list-block provisional-distance-between-starts="20mm">
            <xsl:for-each select="tei:item">
                <fo:list-item>
                    <fo:list-item-label font-weight="bold" end-indent="label-end()">
                        <fo:block>
                            <xsl:value-of select="$bulletpoint"/>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>

    </xsl:template>

    <xsl:template match="tei:p">
        <fo:block space-after="6pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:tag">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:gi">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:att">
        <xsl:text>@</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:att" mode="toclong">
        <xsl:text>@</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:att" mode="tocshort">
        <xsl:text>@</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:back/tei:div">
        <fo:block font-size="24pt" font-weight="bold" space-before="18pt" space-after="12pt"
            text-align="left" page-break-before="always" id="{generate-id(.)}">
            <fo:marker marker-class-name="taglibrary-head">
                <fo:block>
                    <xsl:value-of select="$appendix"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@n"/>
                </fo:block>
            </fo:marker>
            <xsl:value-of select="$appendix"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>:</xsl:text>
        </fo:block>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:hi">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:note">
        <fo:footnote>
            <fo:inline font-size="10pt" vertical-align="text-top">
                <xsl:value-of select="@n"/>
            </fo:inline>
            <fo:footnote-body>
                <fo:list-block font-size="9pt">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>
                                <xsl:value-of select="@n"/>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block space-after="8pt">
                                <xsl:apply-templates/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </fo:footnote-body>
        </fo:footnote>
    </xsl:template>

    <xsl:template match="tei:ref">
        <fo:basic-link external-destination="{@target}" color="blue">
            <xsl:apply-templates/>
        </fo:basic-link>
    </xsl:template>

    <xsl:template match="tei:figure">
        <fo:block>
            <xsl:variable name="imagenamenadpath" select="concat($path, tei:graphic/@url)"/>
            <fo:external-graphic src="url({$imagenamenadpath})" max-height="90%" max-width="90%"
                content-height="80%" content-width="80%"/>
            <xsl:value-of select="tei:p"/>
        </fo:block>
    </xsl:template>

    <!-- Returning this function due to the use of egXML in the EAC-CPF TEI.
         This will silence errors regarding the use of body-start() outside of
         a list context, and will properly monospace/format the egXML samples. -->
    <xsl:template match="tei:front/tei:div/tei:div/tei:div/ex:egXML">
        <fo:block>
            <xsl:text> </xsl:text>
        </fo:block>
        <fo:list-block provisional-distance-between-starts="0">
            <fo:list-item>
                <fo:list-item-label start-indent="0" end-indent="0">
                    <fo:block>
                        <xsl:text> </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <xsl:for-each select="*">
                        <xsl:variable name="myDepth"
                            select="count(ancestor::*[not(namespace-uri() = 'http://www.tei-c.org/ns/1.0')]) * 5"/>
                        <fo:block start-indent="body-start() + {$myDepth}mm" font-family="KurintoMono,KurintoMonoJP,KurintoMonoKR,KurintoMonoSC"
                            font-size="10pt">
                            <xsl:call-template name="eg"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block>
            <xsl:text> </xsl:text>
        </fo:block>
    </xsl:template>

    <!-- Terrible hack to account for an egXML called from within some front matter (EAD TEI).
        body-start() is only valid from within a list context (although you can call it from a fo:block from there!), so
        this re-uses the above XPath to achieve that (and monospaces the example for kicks) -->
    <xsl:template
        match="tei:body/tei:div[@type = 'attributes']/tei:div[@type = 'Introduction']/tei:p/ex:egXML">
        <fo:block>
            <xsl:text> </xsl:text>
        </fo:block>
        <fo:list-block provisional-distance-between-starts="0">
            <fo:list-item>
                <fo:list-item-label start-indent="0" end-indent="0">
                    <fo:block>
                        <xsl:text> </xsl:text>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <xsl:for-each select="*">
                        <xsl:variable name="myDepth"
                            select="count(ancestor::*[not(namespace-uri() = 'http://www.tei-c.org/ns/1.0')]) * 5"/>
                        <fo:block start-indent="body-start() + {$myDepth}mm" font-family="KurintoMono,KurintoMonoJP,KurintoMonoKR,KurintoMonoSC"
                            font-size="10pt">
                            <xsl:call-template name="eg"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block>
            <xsl:text> </xsl:text>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'examples']">
        <fo:list-block provisional-distance-between-starts="45mm" space-after="6pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">
                        <xsl:choose>
                            <xsl:when test="count(*) &gt; 1">
                                <xsl:value-of select="$examples"/>
                                <xsl:text>:</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$example"/>
                                <xsl:text>:</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <xsl:choose>
                        <xsl:when test="eg:egXML">
                            <xsl:for-each select="eg:egXML">
                                <fo:block font-family="KurintoMono,KurintoMonoJP,KurintoMonoKR,KurintoMonoSC" font-size="10pt">
                                    <xsl:apply-templates/>
                                </fo:block>
                            </xsl:for-each>
                            <fo:block>
                                <xsl:call-template name="newLine"/>
                            </fo:block>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block>
                                <xsl:apply-templates/>
                            </fo:block>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template name="eg">
        <xsl:choose>
            <xsl:when test="name() != 'eac-cpf:objectXMLWrap' and name() != 'ead:objectxmlwrap' and name() != 'eac:objectXMLWrap'">
                <fo:block>
                    <xsl:call-template name="newLine"/>
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:for-each select="@*">
                        <xsl:text>&#x20;</xsl:text>
                        <xsl:choose>
                            <xsl:when
                                test="namespace-uri() = 'http://workaround for xml namespace restriction/namespace'">
                                <xsl:text>xml:</xsl:text>
                                <xsl:value-of select="local-name()"/>
                            </xsl:when>
                            <xsl:when test="namespace-uri() = 'http://www.w3c.org/1999/xlink'">
                                <xsl:text>xlink:</xsl:text>
                                <xsl:value-of select="local-name()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="local-name()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>="</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>"</xsl:text>
                    </xsl:for-each>
                    <xsl:text>&gt;</xsl:text>
                    <xsl:apply-templates select="* | text()"/>
                    <xsl:text>&lt;/</xsl:text>
                    <xsl:value-of select="local-name()"/>
                    <xsl:text>&gt;</xsl:text>
                    <xsl:call-template name="newLine"/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&lt;objectXMLWrap&gt;</xsl:text>
                <fo:block>
                    <xsl:apply-templates mode="escape"/>
                </fo:block>
                <xsl:text>&lt;/objectXMLWrap&gt;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- In this template all occuring other namespaceprefixis needs to be added -->
    <xsl:template
        match="eac-cpf:* | eac:* |example:* | ead:* | ead3:* | mods:* | text:* | dc:* | oai_dc:* | premis:*">
        <xsl:variable name="myDepth"
            select="count(ancestor::*[not(namespace-uri() = 'http://www.tei-c.org/ns/1.0')]) * 5"/>
        <fo:block start-indent="body-start() + {$myDepth}mm" wrap-option="wrap">
            <xsl:call-template name="newLine"/>
            <xsl:text>&lt;</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:for-each select="@*">
                <xsl:text>&#x20;</xsl:text>
                <xsl:choose>
                    <xsl:when
                        test="namespace-uri() = 'http://workaround for xml namespace restriction/namespace'">
                        <xsl:text>xml:</xsl:text>
                        <xsl:value-of select="local-name()"/>
                    </xsl:when>
                    <xsl:when test="namespace-uri() = 'http://www.w3c.org/1999/xlink'">
                        <xsl:text>xlink:</xsl:text>
                        <xsl:value-of select="local-name()"/>
                    </xsl:when>
                    <xsl:when test="local-name() = 'schemaLocation'">
                        <xsl:text>xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" </xsl:text>
                        <xsl:text>xsi:schemaLocation</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="local-name()"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>="</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>"</xsl:text>
            </xsl:for-each>
            <xsl:text>&gt;</xsl:text>
            <xsl:apply-templates select="* | text()"/>
            <fo:inline keep-together.within-line="always" keep-with-previous.within-line="always">
                <xsl:text>&lt;/</xsl:text>
                <xsl:value-of select="local-name()"/>
                <xsl:text>&gt;</xsl:text>
            </fo:inline>
        </fo:block>
    </xsl:template>

    <xsl:template match="*" mode="escape">
        <xsl:variable name="myDepth"
            select="count(ancestor::*[not(namespace-uri() = 'http://www.tei-c.org/ns/1.0')]) * 5"/>
        <fo:block start-indent="{$myDepth}mm" wrap-option="wrap">
            <!-- Begin opening tag -->
            <xsl:text>&lt;</xsl:text>
            <xsl:value-of select="name()"/>
            <!-- Namespaces -->
            <xsl:variable name="curnode" select="."/>
            <xsl:for-each select="namespace::*">
                <xsl:variable name="nsuri" select="."/>
                <xsl:if
                    test="
                        $curnode/descendant-or-self::*[namespace-uri() = $nsuri] and
                        $curnode/descendant-or-self::*[namespace-uri() != 'http://www.tei-c.org/ns/Examples']
                        ">

                    <xsl:text> xmlns</xsl:text>
                    <xsl:if test="name() != ''">
                        <xsl:text>:</xsl:text>
                        <xsl:value-of select="name()"/>
                    </xsl:if>
                    <xsl:text>='</xsl:text>
                    <xsl:call-template name="escape-xml">
                        <xsl:with-param name="text" select="."/>
                    </xsl:call-template>
                    <xsl:text>'</xsl:text>
                </xsl:if>
            </xsl:for-each>

            <!-- Attributes -->
            <xsl:for-each select="@*">
                <xsl:text> </xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>='</xsl:text>
                <xsl:call-template name="escape-xml">
                    <xsl:with-param name="text" select="."/>
                </xsl:call-template>
                <xsl:text>'</xsl:text>
            </xsl:for-each>

            <!-- End opening tag -->
            <xsl:text>&gt;</xsl:text>

            <!-- Content (child elements, text nodes, and PIs) -->
            <xsl:apply-templates select="node()" mode="escape"/>

            <!-- Closing tag -->
            <fo:inline keep-together.within-line="always" keep-with-previous.within-line="always">
                <xsl:text>&lt;/</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>&gt;</xsl:text>
            </fo:inline>
        </fo:block>
    </xsl:template>

    <xsl:template name="escape-xml">
        <xsl:param name="text"/>
        <xsl:if test="$text != ''">
            <xsl:variable name="head" select="substring($text, 1, 1)"/>
            <xsl:variable name="tail" select="substring($text, 2)"/>
            <xsl:choose>
                <xsl:when test="$head = '&amp;'">&amp;amp;</xsl:when>
                <xsl:when test="$head = '&lt;'">&amp;lt;</xsl:when>
                <xsl:when test="$head = '&gt;'">&amp;gt;</xsl:when>
                <xsl:when test="$head = '&quot;'">&amp;quot;</xsl:when>
                <xsl:when test="$head = &quot;&apos;&quot;">&amp;apos;</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$head"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="escape-xml">
                <xsl:with-param name="text" select="$tail"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="makeIndent">
        <xsl:variable name="depth"
            select="count(ancestor::*[not(namespace-uri() = 'http://www.tei-c.org/ns/1.0')]) + 5"/>
        <xsl:call-template name="makeSpace">
            <xsl:with-param name="d">
                <xsl:value-of select="$depth"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>


    <xsl:template name="newLine">
        <fo:block/>
    </xsl:template>

    <xsl:template name="makeSpace">
        <xsl:param name="d"/>
        <xsl:if test="number($d) &gt; 1">
            <xsl:value-of select="$spaceCharacter"/>
            <xsl:call-template name="makeSpace">
                <xsl:with-param name="d">
                    <xsl:value-of select="$d - 1"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:head">
        <fo:block font-size="14pt" font-weight="bold" space-before="8pt" space-after="6pt"
            text-align="left">
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="tei:div[@type = 'occurenceSpecifikation']">
        <fo:block linefeed-treatment="preserve">
            <xsl:if test="string-length(tei:head) > 0">
                <xsl:value-of select="tei:head"/>
                <xsl:text>: </xsl:text>
            </xsl:if>
            <xsl:value-of select="tei:div[@type = 'mandatory']/tei:p"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="tei:div[@type = 'repeatable']/tei:p"/>
            <xsl:text>&#xA;</xsl:text>
        </fo:block>
    </xsl:template>



    <xsl:template name="tokenize">
        <xsl:for-each select="tokenize(., ',')">
            <xsl:choose>
                <xsl:when test="contains(., 'base64Binary')">
                    <xsl:value-of select="normalize-space(.)" />
                </xsl:when>
                <xsl:when test="contains(., '&#34;')">
                    <xsl:value-of select="normalize-space(.)" />
                </xsl:when>
                <xsl:when test="contains(., 'NMTOKEN')">
                    <xsl:value-of select="normalize-space(.)" />
                </xsl:when>
                <xsl:when test="contains(., 'ROOT')">
                    <xsl:value-of select="normalize-space(.)" />
                </xsl:when>
                <xsl:when test="contains(., ' or ')">
                    <xsl:for-each select="tokenize(., ' or ')">
                        <xsl:call-template name="tokenize"/>
                        <xsl:if test="position() ne last()">
                            <xsl:text> or </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when test="contains(., '[')">
                    <xsl:value-of select="normalize-space(.)" />
                </xsl:when>
                <xsl:when test="contains(., '(')">
                        <!-- remove "(revised in x.y.z)" text from title -->
                        <fo:basic-link
                            internal-destination="{concat('elem-', normalize-space(substring-before(concat(., '('), '(')))}">
                            <xsl:value-of select="normalize-space(.)"/>
                        </fo:basic-link>
                </xsl:when>
                <xsl:otherwise>
                    <fo:basic-link
                            internal-destination="{concat('elem-', translate(normalize-space(.), ':',''))}">
                            <xsl:value-of select="normalize-space(.)"/>
                        </fo:basic-link>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() ne last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="tokenizeattributes">
        <xsl:param name="text" select="."/>
        <xsl:param name="separator" select="','"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <xsl:choose>
                    <xsl:when test="contains($text, '(revised')">
                        <!-- remove "(revised in x.y.z)" text from title -->
                        <fo:basic-link
                            internal-destination="{concat('attr-', substring-before($text, ' '))}">
                            <xsl:value-of select="normalize-space($text)"/>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:when test="not(contains($text, '['))">
                        <!-- attributes have an id with attr- first -->
                        <fo:basic-link
                            internal-destination="{concat('attr-', translate(normalize-space($text), ':',''))}">
                            <xsl:value-of select="normalize-space($text)"/>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($text)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains($text, '(revised')">
                        <!-- remove "(revised in x.y.z)" text from title -->
                        <fo:basic-link
                            internal-destination="{concat('attr-', substring-before($text, ' '))}">
                            <xsl:value-of select="normalize-space($text)"/>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:when test="not(contains($text, '['))">
                        <!-- attributes have an id with attr- first -->
                        <fo:basic-link
                            internal-destination="{concat('attr-', translate(normalize-space(substring-before($text, $separator)), ':',''))}">
                            <xsl:value-of
                                select="normalize-space(substring-before($text, $separator))"/>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(substring-before($text, $separator))"
                        />
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <xsl:call-template name="tokenizeattributes">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- formatting tags -->
    <xsl:template match="bold">
        <fo:inline font-weight="bold">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    <xsl:template match="italic">
        <fo:inline font-style="italic">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

</xsl:stylesheet>