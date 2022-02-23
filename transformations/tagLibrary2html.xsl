<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format" 
        xmlns:eac-cpf="urn:isbn:1-931666-33-4"
        xmlns:eac="http://archivists.org/ns/eac/v2"
        xmlns:ead="urn:isbn:1-931666-22-9"
        xmlns:ead3="http://ead3.archivists.org/schema/"
        xmlns:premis="http://www.loc.gov/premis/v3"
        xmlns:ex="http://www.tei-c.org/ns/Examples"
        xmlns:eg="http://www.tei-c.org/ns/Examples"
        xmlns:exml="http://workaround for xml namespace restriction/namespace"
        xmlns:xlink="http://www.w3c.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
        xmlns:mods="http://www.loc.gov/mods/v3" xmlns:text="http://www.tei.org/ns/1.0"
        xmlns:example="example" xmlns:term="term" xmlns:exslt="http://exslt.org/common"
        xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
        exclude-result-prefixes="xs xlink eac-cpf eac ex eg exml example ead ead3 mods text term dc oai_dc fo premis tei"
        xpath-default-namespace="http://www.w3.org/1999/xhtml" extension-element-prefixes="exslt"
        version="2.0">

        <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                encoding="UTF-8" omit-xml-declaration="yes" indent="yes" method="xhtml"/>

        <xsl:strip-space elements="*"/>

        <!-- variables passed from the build script to the XSLT -->
        <xsl:param name="SAA" as="xs:string" required="yes"/>
        <xsl:param name="currentLanguage" as="xs:string" required="yes"/>
     
        <xsl:variable name="toctype">short</xsl:variable><!-- Used for the look of the toc Values: long | short -->
        <xsl:param name="spaceCharacter"> </xsl:param> <!-- For egxml formatting -->       
        <xsl:variable name="bulletpoint">&#x2022;</xsl:variable>
        <xsl:variable name="EAD-TL" select="if (matches(tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1], 'Description', 'i')) then true() else false()"/>
        <xsl:variable name="EAC-CPF-TL" select="if (matches(tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1], 'Context', 'i')) then true() else false()"/>
        <xsl:param name="EAC-CPF-html-title" select="'Encoded Archival Context—Corporate Bodies, Persons, and Families (EAC-CPF) Tag Library'"/>
        <xsl:param name="EAD-html-title" select="'Encoded Archival Description Tag Library - Version EAD3 (EAD Official Site, Library of Congress)'"/>

        <!-- Headingtranslations in an own xml-file using the currentLanguage to fetch them -->
        <!-- This only works with XSLT-enginee Saxon 6.5.5 -->
        <xsl:variable name="headingtranslations" select="document('../tei/Headingtranslation.xml')"/>
        <!-- All translated headings -->
        <xsl:variable name="summary"
                select="$headingtranslations//*:terms/*:term[@name='summary']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="description"
                select="$headingtranslations//*:terms/*:term[@name='description']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="desc"
                select="$headingtranslations//*:terms/*:term[@name='desc']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="mayoccurwithin"
                select="$headingtranslations//*:terms/*:term[@name='mayOccurWithin']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="mandatory"
                select="$headingtranslations//*:terms/*:term[@name='mandatory']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="optional"
                select="$headingtranslations//*:terms/*:term[@name='optional']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="repeatable"
                select="$headingtranslations//*:terms/*:term[@name='repeatable']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="nonrepeatable"
                select="$headingtranslations//*:terms/*:term[@name='nonrepeatable']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="attributes"
                select="$headingtranslations//*:terms/*:term[@name='attributes']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="references"
                select="$headingtranslations//*:terms/*:term[@name='references']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="datatype"
                select="$headingtranslations//*:terms/*:term[@name='datatype']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="toc"
                select="$headingtranslations//*:terms/*:term[@name='toc']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="elements"
                select="$headingtranslations//*:terms/*:term[@name='elements']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="maycontain"
                select="$headingtranslations//*:terms/*:term[@name='mayContain']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="occurrence"
                select="$headingtranslations//*:terms/*:term[@name='occurrence']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="appendix"
                select="$headingtranslations//*:terms/*:term[@name='appendix']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="examples"
                select="$headingtranslations//*:terms/*:term[@name='examples']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="example"
                select="$headingtranslations//*:terms/*:term[@name='example']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="usage"
                select="$headingtranslations//*:terms/*:term[@name='usage']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="and"
                select="$headingtranslations//*:terms/*:term[@name='and']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="availability"
                select="$headingtranslations//*:terms/*:term[@name='availability']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="value"
                select="$headingtranslations//*:terms/*:term[@name='value']/*:translation[@lang=$currentLanguage]"/>
                <xsl:variable name="values"
                select="$headingtranslations//*:terms/*:term[@name='values']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="taglibrary"
                select="$headingtranslations//*:terms/*:term[@name='tl']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="seealso"
                select="$headingtranslations//*:terms/*:term[@name='seealso']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="attributeusage"
                select="$headingtranslations//*:terms/*:term[@name='attributeusage']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="allrightsreserved"
                select="$headingtranslations//*:terms/*:term[@name='allrightsreserved']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="printedinusa"
                select="$headingtranslations//*:terms/*:term[@name='printedinusa']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="edition"
                select="$headingtranslations//*:terms/*:term[@name='edition']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="printed"
                select="$headingtranslations//*:terms/*:term[@name='printed']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="availableFrom"
                select="$headingtranslations//*:terms/*:term[@name='availableFrom']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="usageNotes"
                select="$headingtranslations//*:terms/*:term[@name='usageNotes']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="rationale"
                select="$headingtranslations//*:terms/*:term[@name='rationale']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="creationMaintenance"
                select="$headingtranslations//*:terms/*:term[@name='creationmaintenance']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="semanticUnit"
                select="$headingtranslations//*:terms/*:term[@name='semanticunit']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="semanticComponents"
                select="$headingtranslations//*:terms/*:term[@name='semanticcomponents']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="definition"
                select="$headingtranslations//*:terms/*:term[@name='definition']/*:translation[@lang=$currentLanguage]"/>
        <xsl:variable name="dataDictionary"
                select="$headingtranslations//*:terms/*:term[@name='datadictionary']/*:translation[@lang=$currentLanguage]"/>        
        <xsl:variable name="entity"
                select="$headingtranslations//*:terms/*:term[@name='entity']/*:translation[@lang=$currentLanguage]"/>
        
        <xsl:template match="/">
                <!-- should update to HTML5 - mdc -->
                <html lang="en" xml:lang="en">
                        <head>
                                <title>
                                        <xsl:value-of select="if ($EAD-TL) then $EAD-html-title
                                                else if ($EAC-CPF-TL) then $EAC-CPF-html-title
                                                else 'Tag Library'">
                                        </xsl:value-of>
                                </title>
                                <meta content="en" http-equiv="content-language"/>
                                <meta content="text/html; charset=utf-8" http-equiv="content-type"/>
                                <link href="tagLibrary.css" rel="stylesheet" type="text/css"/>
                        </head>
                        <body>
                                <div>
                                        <div>
                                                <xsl:apply-templates mode="title"
                                                  select="//tei:text/tei:front/tei:titlePage"/>
                                        </div>
                                        <div>
                                                <div class="head03" id="toc">
                                                  <xsl:value-of select="$toc"/>
                                                </div>
                                                <xsl:apply-templates mode="toc"
                                                  select="//tei:front/tei:div"/>
                                                <xsl:apply-templates mode="toc" select="//tei:body"/>
                                                <xsl:apply-templates mode="toc" select="//tei:back"
                                                />
                                        </div>
                                        <!--<hr/>-->
                                        <div>
                                                <xsl:apply-templates
                                                  select="//tei:text/tei:front/tei:div"/>
                                        </div>
                                        <!--<hr/>-->
                                        <div>
                                                <xsl:apply-templates
                                                  select="//tei:text/tei:body/tei:div"/>
                                        </div>
                                        <!--<hr/>-->
                                        <div>
                                                <xsl:apply-templates
                                                  select="//tei:text/tei:back/tei:div"/>
                                        </div>
                                </div>
                        </body>
                </html>
        </xsl:template>

        <xsl:template match="tei:front/tei:titlePage" mode="title">
                <div class="titlePage">
                        <div class="title">
                                <xsl:apply-templates select="tei:docTitle/tei:titlePart"/>
                        </div>
                        <div class="edition">
                                <xsl:apply-templates select="tei:docEdition"/>
                        </div>
                        <div class="edition">
                                <div>
                                        <xsl:apply-templates select="tei:byline"/>
                                </div>
                                <div>
                                        <xsl:apply-templates select="tei:docAuthor[1]"/>
                                </div>
                                <div>
                                        <xsl:apply-templates select="tei:docAuthor[2]"/>
                                </div>
                        </div>
                        <div class="logo">
                              <xsl:apply-templates select="tei:figure/tei:graphic"/>  
                        </div>
                        <div>
                                <xsl:apply-templates select="tei:note"/>
                        </div>
                        <!--<hr/>-->
                </div>
        </xsl:template>

        <xsl:template match="tei:ref">
                <a href="{@target}" target="new">
                        <xsl:apply-templates/>
                </a>
        </xsl:template>

        <xsl:template match="tei:front/tei:div" mode="toc">
                <xsl:for-each select="tei:div">
                        <div class="toc1">
                                <a href="#{generate-id()}">
                                        <xsl:apply-templates mode="toc" select="tei:head"/>
                                </a>
                        </div>
                        <xsl:for-each select="tei:div">
                                <div class="toc2">
                                        <a href="#{generate-id()}">
                                                <xsl:apply-templates mode="toc" select="tei:head"/>
                                        </a>
                                </div>
                        </xsl:for-each>
                </xsl:for-each>
        </xsl:template>

        <xsl:template match="tei:body | tei:back" mode="toc">
                <xsl:for-each select="tei:div">
                        <xsl:choose>
                                <xsl:when test="@type='elements'">
                                        <div class="toc1">
                                                <a href="#{generate-id()}">
                                                  <!-- Karin: Add selection of value based upon the xml:id??? -->
                                                  <xsl:value-of select="$elements"/>
                                                </a>
                                        </div>
                                        <div class="toc2">
                                            <table>
                                                    <xsl:for-each-group select="tei:div[@type='elementDocumentation']" group-ending-with="tei:div[@type='elementDocumentation'][position() mod 7 = 0]">
                                                        <tr>
                                                            <xsl:for-each select="current-group()">
                                                                <td>
                                                                    <span>
                                                                        <xsl:for-each select="tei:head/tei:gi">
                                                                            <a href="#{translate(concat('elem-', .), ':','')}">
                                                                                  <xsl:value-of select="."/>
                                                                            </a>
                                                                        </xsl:for-each>
                                                                    </span>
                                                                </td>
                                                            </xsl:for-each>
                                                        </tr>
                                                    </xsl:for-each-group>
                                            </table>
                                        </div>
                                </xsl:when>
                                <xsl:when test="@type='attributes'">
                                        <div class="toc1">
                                                <a href="#{generate-id()}">
                                                  <xsl:value-of select="$attributes"/>
                                                </a>
                                        </div>
                                        <div class="toc2">
                                            <table>
                                                    <xsl:for-each-group select="tei:div[@type='attributeDocumentation']" group-ending-with="tei:div[@type='attributeDocumentation'][position() mod 7 = 0]">
                                                        <tr>
                                                            <xsl:for-each select="current-group()">
                                                                <td>
                                                                <span>
                                                                    <xsl:for-each select="tei:head/tei:att">
                                                                        <a href="#{translate(concat('attr-', .), ':','')}">
                                                                              <xsl:value-of select="."/>
                                                                        </a>
                                                                    </xsl:for-each>
                                                                </span>
                                                            </td>
                                                            </xsl:for-each>
                                                        </tr>
                                                    </xsl:for-each-group>
                                            </table>  
                                        </div>
                                </xsl:when>
                                <xsl:when test="@type='appendix'">
                                        <div class="toc1">
                                                <a href="#{translate(translate(concat('appendix-' , tei:head), ':',''), ' ','')}">
                                                        <xsl:value-of select="tei:head"/>
                                                </a>
                                        </div>
                                        <div class="toc2">
                                                <xsl:for-each select="tei:div/tei:head">
                                                  <span>
                                                          <a href="#{translate(translate(concat('appendix-' , .), ':',''), ' ','')}">
                                                                  <xsl:value-of select="."/>
                                                          </a>
                                                  <xsl:text> &#xA0; </xsl:text>
                                                  </span>
                                                  <xsl:for-each select="parent::tei:div">
                                                  <xsl:variable name="count">
                                                  <xsl:number/>
                                                  </xsl:variable>
                                                  <xsl:if test="($count mod 6) = 0">
                                                  <br/>
                                                  </xsl:if>
                                                  </xsl:for-each>
                                                </xsl:for-each>
                                        </div>
                                </xsl:when>
                                <xsl:otherwise>
                                        <xsl:text>Test of creating links to chapters</xsl:text>
                                </xsl:otherwise>
                        </xsl:choose>
                </xsl:for-each>
        </xsl:template>

        <xsl:template match="tei:front/tei:div">
                <div class="section" id="{generate-id()}">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/tei:head">
                <div class="head03">
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/tei:div/tei:head">
                <div class="head04">
                        <xsl:value-of select="."/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:att[ancestor-or-self::tei:front]">
                <div class="head04">
                        <xsl:text>@</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div">
                <div id="{generate-id()}">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/tei:div">
                <div id="{generate-id()}">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>


        <xsl:template match="tei:list[@type='ordered']">
                <!-- Numbered list -->
                <div class="listOrdered">
                        <div class="head04">
                                <xsl:apply-templates select="tei:head"/>
                        </div>
                        <xsl:for-each select="tei:item">
                                <div class="listOrder">
                                        <xsl:number />
                                        <xsl:text>.</xsl:text>
                                </div>
                                <div class="listContent">
                                        <xsl:apply-templates/>
                                </div>
                        </xsl:for-each>
                </div>
        </xsl:template>

        <xsl:template match="tei:list[@type='bulleted']">
                <!-- Bulletpoint list -->
                <div class="listOrdered">
                        <xsl:if test="tei:head">
                                <div class="head04">
                                        <xsl:apply-templates select="tei:head"/>
                                </div>
                        </xsl:if>
                        <xsl:for-each select="tei:item">
                                <div class="listOrder">
                                        <xsl:value-of select="$bulletpoint"/>
                                </div>
                                <div class="listContent">
                                        <xsl:apply-templates/>
                                </div>
                        </xsl:for-each>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:list[@type='simple' or @type='gloss']">
                <!-- List with only text -->
                <xsl:if test="tei:head">
                        <div>
                                <xsl:value-of select="tei:head"/>
                        </div>
                </xsl:if>
                <xsl:choose>
                        <xsl:when test="tei:label">
                                <xsl:for-each select="tei:label">
                                        <div class="leftcol">
                                                <xsl:apply-templates/>
                                        </div>
                                        <div class="content">
                                                <xsl:for-each
                                                  select="following-sibling::tei:item[1]">
                                                  <xsl:apply-templates/>
                                                </xsl:for-each>
                                        </div>
                                </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                                <div class="blockIndent">
                                        <xsl:for-each select="tei:item">
                                                <xsl:apply-templates/>
                                                <br/>
                                                <br/>
                                        </xsl:for-each>
                                </div>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>

        <xsl:template match="tei:div[@type='elements']">
                <div class="section" id="{generate-id()}">
                        <div class="head03">
                                <!-- Karin: Add selection of value based upon the xml:id??? -->
                                <xsl:value-of select="$elements"/>
                        </div>
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='attributes'][parent::tei:body]">
                <div class="section" id="{generate-id()}">
                        <div class="head03">
                                <xsl:value-of select="$attributes"/>
                              
                        </div>
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>

        </xsl:template>
        
        <xsl:template match="tei:head">
                <div class="head03">
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='elementDocumentation']">
                <div class="element">
                        <xsl:apply-templates select="tei:head/tei:gi"/>
                        <xsl:apply-templates select="tei:div[@type='fullName']"/>
                        <xsl:apply-templates select="tei:div[@type='summary']"/>
                        <xsl:apply-templates select="tei:div[@type='attributeusage']"/>
                        <xsl:apply-templates select="tei:div[@type='seealso']"/>
                        <xsl:apply-templates select="tei:div[@type='mayContain']"/>
                        <xsl:apply-templates select="tei:div[@type='semanticcomponents']"/>
                        <xsl:apply-templates select="tei:div[@type='mayOccurWithin']"/>
                        <xsl:apply-templates select="tei:div[@type='definition']"/>
                        <xsl:apply-templates select="tei:div[@type='entity']"/>
                        <xsl:apply-templates select="tei:div[@type='rationale']"/>
                        <xsl:apply-templates select="tei:div[@type='datatype']"/>
                        <xsl:apply-templates select="tei:div[@type='description']"/>
                        <xsl:apply-templates select="tei:div[@type='desc']"/>
                        <xsl:apply-templates select="tei:div[@type='usage']"/>
                        <xsl:apply-templates select="tei:div[@type='references']"/>
                        <xsl:apply-templates select="tei:div[@type='attributes']"/>
                        <xsl:apply-templates select="tei:div[@type='occurrence']"/>
                        <xsl:apply-templates select="tei:div[@type='availability']"/>
                        <!--<xsl:apply-templates select="tei:div[@type='mandatory']"/>
                        <xsl:apply-templates select="tei:div[@type='repetable']"/>-->
                        <xsl:apply-templates select="tei:div[@type='examples']"/>
                        <xsl:apply-templates select="tei:div[@type='creationmaintenance']"/>
                        <xsl:apply-templates select="tei:div[@type='usagenotes']"/>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:div[@type='deprecatedElementDocumentation']">
                <div class="element">
                        <xsl:apply-templates select="tei:head/tei:gi"/>
                        <xsl:apply-templates select="tei:div[@type='fullName']"/>
                        <xsl:apply-templates select="tei:div[@type='summary']"/>
                        <xsl:apply-templates select="tei:div[@type='description']"/>
                        <xsl:apply-templates select="tei:div[@type='desc']"/>
                        <xsl:apply-templates select="tei:div[@type='usage']"/>
                        <xsl:apply-templates select="tei:div[@type='mayContain']" mode="dep"/>
                        <xsl:apply-templates select="tei:div[@type='mayOccurWithin']" mode="dep"/>
                        <xsl:apply-templates select="tei:div[@type='references']"/>
                        <xsl:apply-templates select="tei:div[@type='attributes']" mode="dep"/>
                        <xsl:apply-templates select="tei:div[@type='occurrence']"/>
                        <xsl:apply-templates select="tei:div[@type='availability']"/>
                        <!-- Not used for deprecated elements -->
                        <!--<xsl:apply-templates select="tei:div[@type='mandatory']"/>
                        <xsl:apply-templates select="tei:div[@type='repetable']"/>-->
<!--                        <xsl:apply-templates select="tei:div[@type='examples']"/>-->
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='attributeDocumentation']">
                <div class="attribute">
                        <xsl:apply-templates select="tei:head/tei:att"/>
                        <xsl:apply-templates select="tei:div[@type='summary']"/>
                        <xsl:apply-templates select="tei:div[@type='description']"/>
                        <xsl:apply-templates select="tei:div[@type='desc']"/>
                        <xsl:apply-templates select="tei:div[@type='usage']"/>
                        <xsl:apply-templates select="tei:div[@type='datatype']"/>
                        <xsl:apply-templates select="tei:div[@type='values']"/> 
                        <xsl:apply-templates select="tei:div[@type='examples']"/>
                </div>
                <div class="spacer">&#xA0;</div>
        </xsl:template>
        
        <xsl:template match="tei:div[@type='deprecatedAttributeDocumentation']">
                <div class="attribute">
                        <xsl:apply-templates select="tei:head/tei:att" mode="dep"/>
                        <xsl:apply-templates select="tei:div[@type='summary']"/>
                        <xsl:apply-templates select="tei:div[@type='description']"/> 
                        <xsl:apply-templates select="tei:div[@type='datatype']"/>
                        <xsl:apply-templates select="tei:div[@type='values']"/>  
                                             
                </div>
                <div class="spacer">&#xA0;</div>
        </xsl:template>

        <xsl:template
                match="tei:list[parent::tei:div[@type='elementDocumentation'] or parent::tei:div[@type='attributeDocumentation']]">
                <xsl:apply-templates/>
        </xsl:template>

        <xsl:template match="tei:head/tei:gi">
                <!-- Karin: Changes needed to be made here to get it to write semmantic unit when head has type=DD -->
                <xsl:choose>
                        <xsl:when test="ancestor-or-self::tei:front">
                                <div class="leftcol" id="{generate-id()}">
                                        <span class="label">
                                                <xsl:text>&lt;</xsl:text>
                                                <xsl:apply-templates/>
                                                <xsl:text>&gt;</xsl:text>                                             
                                        </span>
                                </div>
                        </xsl:when>
                        <xsl:otherwise>
                                <div class="leftcol" id="{translate(concat('elem-', .), ':','')}">
                                        <span class="label">
                                                <!-- would like to look into this section, but for now just removing the PREMIS bit.  - mdc -->
                                                <xsl:text>&lt;</xsl:text>
                                                <xsl:apply-templates/>
                                                <xsl:text>&gt;</xsl:text>    
                                        </span>
                                </div>
                        </xsl:otherwise>
                </xsl:choose>
                <div class="content">
                        <span class="label"> 
                                <xsl:value-of
                                        select="ancestor-or-self::tei:div[@type='elementDocumentation'or 'deprecatedElementDocumentation']/tei:div[@type='fullName']/tei:p"
                                />  
                     </span>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='fullName']"/>


        <xsl:template match="tei:gi">
                <xsl:text>&lt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&gt;</xsl:text>
        </xsl:template>
        
        <!-- Karin: Needs seg in pdf -->    
        <xsl:template match="tei:head/tei:seg[@type='fullName']">
                <xsl:value-of select="."/>
        </xsl:template>

        <!-- If this tempelete isnt here the link back to toc will be duplicated -->
        <xsl:template match="tei:gi[ancestor-or-self::tei:front]">
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>&gt;</xsl:text>
        </xsl:template>
        
        <xsl:template match="tei:gi[ancestor-or-self::tei:list[@type='simple']]">
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>&gt;</xsl:text>
        </xsl:template>

        <!-- If this tempelete isnt here the link back to toc will be duplicated and @ in the text will be headers and links -->
        <xsl:template match="tei:att[ancestor-or-self::tei:front]">
                <xsl:text>@</xsl:text>
                <xsl:value-of select="."/>
        </xsl:template>
        
        <xsl:template match="tei:att[ancestor-or-self::tei:list[@type='simple']]">
                <xsl:text>@</xsl:text>
                <xsl:value-of select="."/>
        </xsl:template>
        
        <xsl:template match="tei:head/tei:att">
                <div class="leftcol" id="{translate(concat('attr-' , .), ':','')}">

                        <span class="label">
                                <xsl:text>@</xsl:text>
                                <xsl:value-of select="."/>
                        </span>
                </div>
                <div class="content">
                        <xsl:text>&#xA0;</xsl:text>
                        <span class="label"> 
                                <xsl:value-of
                                        select="ancestor-or-self::tei:div[@type='attributeDocumentation']/tei:div[@type='fullName']/tei:p"
                                />
                        </span>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:head/tei:att" mode="dep">
                <div class="leftcol">
                        
                        <span class="label">
                                <xsl:text>@</xsl:text>
                                <xsl:value-of select="."/>
                        </span>
                </div>
                <div class="content">
                        <xsl:text>&#xA0;</xsl:text>
                        <span class="label"> 
                                <xsl:value-of
                                        select="ancestor-or-self::tei:div[@type='attributeDocumentation']/tei:div[@type='fullName']/tei:p"
                                />
                              
                        </span>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type=('summary', 'definition', 'entity', 'rationale', 'creationmaintenance', 'usagenotes', 'description', 'desc', 'usage')]">
                <div class="leftcol">
                        <xsl:variable name="termtitle"><xsl:value-of select="current()/@type"/></xsl:variable>
                        <xsl:value-of select="$headingtranslations/*:terms/*:term[@name=$termtitle]/*:translation[@lang=$currentLanguage]"/>
                        <xsl:text>: </xsl:text>
                </div>
                    <div class="content">
                        <xsl:apply-templates/>
                    </div>
        </xsl:template>
        
        <!-- leftcol + content elements -->
        <xsl:template match="tei:div[@type=('mayContain', 'semanticcomponents', 'mayOccurWithin')]">
                <div class="leftcol">
                        <xsl:variable name="termtitle"><xsl:value-of select="current()/@type"/></xsl:variable>
                        <xsl:value-of select="$headingtranslations/*:terms/*:term[@name=$termtitle]/*:translation[@lang=$currentLanguage]"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:for-each select="tokenize(tei:p, ',')">
                                <xsl:choose>
                                        <!-- for anything that has a " or a [, like [text], we'll just output the text as is -->
                                        <xsl:when test="contains(., '&quot;') or contains(., '[')">
                                                <xsl:value-of select="normalize-space(.)"/>
                                        </xsl:when>
                                        <xsl:when test="contains(., ' or ')">
                                            <xsl:for-each select="tokenize(., ' or ')">
                                                <xsl:choose>
                                                    <xsl:when test="contains(., '(')">
                                                        <a href="#{translate(concat('elem-', normalize-space(substring-before(., '('))), ':','')}">
                                                                <xsl:value-of select="normalize-space(.)"/>
                                                        </a>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                            <a href="#{translate(concat('elem-', normalize-space(.)), ':','')}">
                                                                    <xsl:value-of select="normalize-space(.)"/>
                                                            </a>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <xsl:if test="position() ne last()">
                                                    <xsl:text> or </xsl:text>
                                                </xsl:if>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:when test="contains(., '(')">
                                                <a href="#{translate(concat('elem-', normalize-space(substring-before(., '('))), ':','')}">
                                                        <xsl:value-of select="normalize-space(.)"/>
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <a href="#{translate(concat('elem-', normalize-space(.)), ':','')}">
                                                        <xsl:value-of select="normalize-space(.)"/>
                                                </a>
                                        </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position() ne last()">
                                        <xsl:text>, </xsl:text>
                                </xsl:if>
                        </xsl:for-each>
                </div>
        </xsl:template>

        <!-- When description is its own header -->
        <!--<xsl:template match="tei:div[@type='description']">
                <div class="span">
                        <div class="descriptionHead">
                                <xsl:value-of select="$description"/>
                                <xsl:text>: </xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>-->
        
        <xsl:template match="tei:div[@type='description'][parent::tei:div[@type='attributeDocumentation']]">
                <div class="span">
                        <div class="descriptionHead">
                                <xsl:value-of select="$description"/>
                                <xsl:text>: </xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <!-- When we have usage as its own head -->
        <!--<xsl:template match="tei:div[@type='usage']">
                <div class="span">
                        <div class="descriptionHead">
                                <xsl:value-of select="$usage"/>
                                <xsl:text>: </xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>-->
        
        <!-- When we have description and usage in one header -->
        <xsl:template match="tei:div[@type='descriptionAndUsage']">
                <div class="span">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:div[@type='mayContain']" mode="dep">
                <div class="leftcol">
                        <xsl:value-of select="$maycontain"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:value-of select="tei:p"/>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:div[@type='mayOccurWithin']" mode="dep">
                <div class="leftcol">
                        <xsl:value-of select="$mayoccurwithin"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:value-of select="tei:p"/>                        
                </div>
        </xsl:template>
        
        <xsl:template
                match="tei:div[@type='attributes'][parent::tei:div[@type='elementDocumentation']] | tei:div[@type='attributes'][parent::tei:div[@type='elementDocumentation']]/tei:p">
                <xsl:choose>
                        <xsl:when test="tei:list[@type='gloss']">
                                <div class="leftcolattrlist">&#xA0;</div>
                                <xsl:for-each select="tei:list/tei:label[1]">
                                        <div class="centercol">
                                                <a href="#{translate(concat('attr-' , .), ':','')}">
                                                  <xsl:apply-templates/>
                                                </a>
                                        </div>
                                        <div class="rightcol">
                                                <xsl:apply-templates
                                                  select="following-sibling::tei:item[1]"/>
                                        </div>
                                </xsl:for-each>
                                <xsl:for-each select="tei:list/tei:label[position()&gt;1]">
                                        <div class="leftcolattrlist">&#xA0;</div>
                                        <div class="centercol">
                                                <a href="#{translate(concat('attr-' , .), ':','')}">
                                                  <xsl:apply-templates/>
                                                </a>
                                        </div>
                                        <div class="rightcol">
                                                <xsl:apply-templates
                                                        select="following-sibling::tei:item[1]"/>
                                        </div>
                                </xsl:for-each>
                        </xsl:when>
                        
                        <xsl:otherwise>
                                <div class="leftcol">
                                        <xsl:value-of select="$attributes"/>
                                        <xsl:text>: </xsl:text>
                                </div>
                                <div class="content">
                                        <xsl:apply-templates/>
                                </div>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>
        
     
        <xsl:template
                match="tei:div[@type='attributeusage'][parent::tei:div[@type='elementDocumentation']]/tei:list[@type='simple']">
                             <div class="leftcol">
                                        <xsl:value-of select="$attributeusage"/>
                                        <xsl:text>: </xsl:text>
                                </div>
                                <div class="content">
                                        <xsl:for-each select="tei:item">
                                                
                                                <xsl:apply-templates/>
                                                <br/>
                                        </xsl:for-each>
                                </div>
        </xsl:template> 
        <xsl:template
                match="tei:div[@type='seealso'][parent::tei:div[@type='elementDocumentation']]/tei:list[@type='simple']">
                <div class="leftcol">
                        <xsl:value-of select="$seealso"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:for-each select="tei:item">
                                
                                <xsl:apply-templates/>
                                <br/>
                        </xsl:for-each>
                </div>
        </xsl:template>
        
        <xsl:template
                match="tei:div[@type='attributes'][parent::tei:div[@type='deprecatedElementDocumentation']] | tei:div[@type='attributes'][parent::tei:div[@type='deprecatedElementDocumentation']]/tei:p" mode="dep">
                <xsl:choose>
                        <xsl:when test="tei:list[@type='gloss']">
                                <div class="leftcolattrlist">&#xA0;</div>
                                <xsl:for-each select="tei:list/tei:label[1]">
                                        <div class="centercol">
                                                <xsl:apply-templates/>
                                        </div>
                                        <div class="rightcol">
                                                <xsl:apply-templates
                                                        select="following-sibling::tei:item[1]"/>
                                        </div>
                                </xsl:for-each>
                                <xsl:for-each select="tei:list/tei:label[position()&gt;1]">
                                        <div class="leftcolattrlist">&#xA0;</div>
                                        <div class="centercol">
                                                <xsl:apply-templates/>
                                        </div>
                                        <div class="rightcol">
                                                <xsl:apply-templates
                                                        select="following-sibling::tei:item[1]"/>
                                        </div>
                                </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                                <div class="leftcol">
                                        <xsl:value-of select="$attributes"/>
                                        <xsl:text>: </xsl:text>
                                </div>
                                <div class="content">
                                        <xsl:apply-templates/>
                                </div>
                        </xsl:otherwise>
                </xsl:choose>
        </xsl:template>

        <!-- This is replaced with two elements -->
        <!--<xsl:template match="tei:div[@type='occurrence']">
                <div class="leftcol">
                        <xsl:value-of select="$occurrence"/><xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>-->

        <xsl:template match="tei:div[@type='mandatory']">
                <!-- Alway occur togheter with repetable -->
                <!--<div class="leftcol">
                        <xsl:value-of select="$mandatory"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$optional"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>-->
                <xsl:value-of select="tei:p"/>
        </xsl:template>
        
        <xsl:template match="tei:address">
                <br />
                <xsl:for-each select="tei:addrLine">
                        <xsl:value-of select="."/><br />                        
                </xsl:for-each>
        </xsl:template>

        <xsl:template match="tei:div[@type='repeatable']">
                <!-- Changes in layout always occur with mandatory so therefor the , -->
                <!--<div class="leftcol">
                        <xsl:value-of select="$repeatable"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$nonrepeatable"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>-->
                <xsl:text>, </xsl:text>
                <xsl:value-of select="tei:p"/>
        </xsl:template>
        
        <xsl:template match="tei:div[@type='occurrence'] | tei:div[@type='availability']">
                <div class="leftcol">
                        <xsl:value-of select="$availability"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>
        
     
        <xsl:template match="tei:div[@type='references']">
                <div class="leftcol">
                        <xsl:value-of select="$references"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>                        
                </div>
        </xsl:template>
        

        
        <xsl:template match="tei:div[@type='occurenceSpecifikation']">
                       <xsl:if test="string-length(tei:head)>0">
                                <xsl:value-of select="tei:head"/>
                                <xsl:text>: </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="tei:div[@type='mandatory']/tei:p"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="tei:div[@type='repeatable']/tei:p"/>
                        <br />             
        </xsl:template>
        
        <xsl:template match="tei:div[@type='reference']">
                <div class="leftcol">
                        <xsl:value-of select="$references"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='datatype'] | tei:div[@type='dataType']">
                <div class="leftcol">
                        <xsl:value-of select="$datatype"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>
        
        <xsl:template match="tei:div[@type='values']">
                <div class="leftcol">
                        <xsl:value-of select="$values"/>
                        <xsl:text>: </xsl:text>
                </div>
                <div class="content">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:p">
                <div class="p">
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:att" mode="toc">
                <xsl:text>@</xsl:text>
                <xsl:apply-templates/>                
        </xsl:template>

        <xsl:template match="tei:back/tei:div | tei:back/tei:div/tei:div">
                <div class="section" id="{generate-id()}">
                        <div class="head03">
                                <xsl:value-of select="$appendix"/>
                                <xsl:text> </xsl:text>
                                <xsl:text>&#xA0;&#xA0;</xsl:text>
                        </div>
                        <xsl:apply-templates/>
                </div>
        </xsl:template>

        <xsl:template match="tei:back/tei:div/tei:head | tei:back/tei:div/tei:div/tei:head">
                <div class="head03" id="{translate(concat('appendix-' , .), ':() ','')}">
                        <xsl:apply-templates/>
                        <xsl:text>&#xA0;&#xA0;</xsl:text>
                        <a class="tocReturn" href="#toc">[toc]</a>
                </div>
        </xsl:template>



        <xsl:template match="hi">
                <span style="{@rend}">
                        <xsl:apply-templates/>
                </span>
        </xsl:template>

        <!-- why?  looks like formatting for foot/end notes, but there aren't any.
                there are just 2 notes in the EAD tag library... and 0 notes in the EAC tag library.
                so let's remove this from now.
                - mdc.
        <xsl:template match="tei:note">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>)</xsl:text>
        </xsl:template>
        -->
        
      
        <xsl:template match="tei:figure/tei:graphic">
                <div class="image">
                        <xsl:element name="img">
                                <xsl:attribute name="src">
                                        <xsl:text>../images/</xsl:text><xsl:value-of select="@url" />
                                </xsl:attribute>
                                <xsl:attribute name="alt"><xsl:value-of select="@url"/></xsl:attribute>
                        </xsl:element>
                </div>
        </xsl:template>

        <xsl:template match="tei:front/tei:div/tei:div/ex:egXML | tei:front/tei:div/tei:div/eg:egXML">
                <div>
                        <xsl:for-each select="*">

                                <div class="exampleIntro">
                                        <xsl:call-template name="eg"/>
                                        <br/>
                                </div>
                        </xsl:for-each>
                </div>
        </xsl:template>

        <xsl:template match="tei:div[@type='examples']">
                <div class="leftcol">
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
                </div>
                <xsl:for-each select="eg:egXML">
                        <div class="leftcol">
                                <xsl:text>&#x20;</xsl:text>
                        </div>
                        <div class="example">
                                <xsl:apply-templates/>
                                <!--<xsl:call-template name="eg"/>-->
                                <br/>
                        </div>
                </xsl:for-each>
                <br/>
        </xsl:template>

        <xsl:template name="eg">
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="local-name()"/>
                <xsl:for-each select="@*">
                        <xsl:text>&#x20;</xsl:text>
                        <xsl:choose>
                                <xsl:when
                                        test="namespace-uri()='http://workaround for xml namespace restriction/namespace'">
                                        <xsl:text>xml:</xsl:text>
                                        <xsl:value-of select="local-name()"/>
                                </xsl:when>
                                <xsl:when test="namespace-uri()='http://www.w3c.org/1999/xlink'">
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
        </xsl:template>

        <!-- In this template all occuring other namespaceprefixis needs to be added -->
        <xsl:template match="eac-cpf:* |eac:* |example:* | ead:* | ead3:* | mods:* | text:* | dc:* | oai_dc:* | premis:*">
                <div class="innerExample">
                        <xsl:text>&lt;</xsl:text>
                        <xsl:value-of select="local-name()"/>
                        <xsl:for-each select="@*">
                                <xsl:text>&#x20;</xsl:text>
                                <xsl:choose>
                                        <xsl:when
                                                test="namespace-uri()='http://workaround for xml namespace restriction/namespace'">
                                                <xsl:text>xml:</xsl:text>
                                                <xsl:value-of select="local-name()"/>
                                        </xsl:when>
                                        <xsl:when
                                                test="namespace-uri()='http://www.w3c.org/1999/xlink'">
                                                <xsl:text>xlink:</xsl:text>
                                                <xsl:value-of select="local-name()"/>
                                        </xsl:when>
                                        <xsl:when test="local-name()='schemaLocation'">
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
                        <xsl:text>&lt;/</xsl:text>
                        <xsl:value-of select="local-name()"/>
                        <xsl:text>&gt;</xsl:text>
                        <br/>
                </div>
        </xsl:template>
        
        <!-- total hack until we determine how best to hande this. but, we don't want to wind up with "LibraryVersion", which is what we have now. -->
        <xsl:template match="tei:titlePart">
                <xsl:apply-templates/>
                <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                </xsl:if>
        </xsl:template>

    <!-- formatting tags -->
    <xsl:template match="tei:bold">
        <xsl:text> </xsl:text>
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    <xsl:template match="tei:italic">
        <xsl:text> </xsl:text>
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>        
</xsl:stylesheet>