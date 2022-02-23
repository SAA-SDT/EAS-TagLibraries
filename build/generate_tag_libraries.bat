@echo off

:: check if Java is installed
java -version
if %ERRORLEVEL% NEQ 0 GOTO NOJAVA

:: check if the TEI file exists
if not exist %2 ( goto NOFILE )

:: check which standard we're generating TLs for
if /i %1 == eac ( goto EAC )
if /i %1 == ead ( goto EAD )
if /i %1 == premis ( goto PREMIS )
echo syntax: generate_tag_libraries.bat (eac ead premis) path\to\tei.xml
goto END

:: run XSLT transformations via Saxon, passing standard-specific variables to the XSLT via these commands
:EAC
echo Generating EAC-CPF tag libraries
java -cp vendor\SaxonHE10-2J\saxon-he-10.2.jar net.sf.saxon.Transform -s:%2 -xsl:..\transformations\tagLibrary2html.xsl -o:%1.html SAA="yes" currentLanguage="en"
java -cp vendor\SaxonHE10-2J\saxon-he-10.2.jar net.sf.saxon.Transform -s:%2 -xsl:..\transformations\tagLibrary2pdf.xsl -o:%1.xml SAA="yes" ISBN="PLACEHOLDER ISBN VALUE" currentLanguage="en"
goto MAIN

:EAD
echo Generating EAD tag libraries
java -cp vendor\SaxonHE10-2J\saxon-he-10.2.jar net.sf.saxon.Transform -s:%2 -xsl:..\transformations\tagLibrary2html.xsl -o:%1.html SAA="yes" currentLanguage="en"
java -cp vendor\SaxonHE10-2J\saxon-he-10.2.jar net.sf.saxon.Transform -s:%2 -xsl:..\transformations\tagLibrary2pdf.xsl -o:%1.xml SAA="yes" ISBN="PLACEHOLDER ISBN VALUE" currentLanguage="en"
goto MAIN

:PREMIS
echo Generating PREMIS tag libraries
java -cp vendor\SaxonHE10-2J\saxon-he-10.2.jar net.sf.saxon.Transform -s:%2 -xsl:..\transformations\tagLibrary2html.xsl -o:%1.html SAA="no" currentLanguage="en"
java -cp vendor\SaxonHE10-2J\saxon-he-10.2.jar net.sf.saxon.Transform -s:%2 -xsl:..\transformations\tagLibrary2pdf.xsl -o:%1.xml SAA="no" ISBN="PLACEHOLDER ISBN VALUE" currentLanguage="en"
goto MAIN

:: error out if Java is not installed
:NOJAVA
ECHO Java not installed - Java is required to run this script
GOTO END

:: error out if TEI file is not found
:NOFILE
ECHO TEI file not found - syntax: generate_tag_libraries.bat (eac ead premis) path\to\tei.xml
GOTO END

:: main function
:: run Saxon on the HTML XSLT
:: run Saxon on the PDF XSLT
:: run fop on the FOXML...I don't know how to remove the temp XML,
:: since fop.bat closes out of the script!
:MAIN
vendor\fop-2.5\fop\fop.bat -c fop-config.xml %1.xml %1.pdf
GOTO END

:END