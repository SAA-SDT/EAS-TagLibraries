#!/bin/bash

# check to see that the arguments exist
if [ $# -lt 2 ]
then
    echo "Tag library script syntax:  ./generate_tag_libraries.sh (eac|ead|premis) path/to/tei.xml (langcode)"
    exit 1
fi

# check that java exists and is executable
if [ ! -x "$(command -v java)" ]
then
    echo "Java doesn't seem to be installed - please install Java to run the build script"
    exit 1
fi

# paths to libraries
saxon="vendor/SaxonHE10-2J/saxon-he-10.2.jar"
fop="vendor/fop-2.5/fop/fop"
outfile=$(basename "$2" .xml)

if [ -z "$3" ]
then
	lang="en"
else
	lang="$3"
fi

# check for which TL we're generating
# and generate the FOXML+HTML with parameters based on that
# e.g. PREMIS doesn't get the SAA logo on the cover
case $1 in
	"eac")
		echo "generating EAC-CPF tag libraries"
		java -cp $saxon net.sf.saxon.Transform -xi:on -s:$2 -xsl:../transformations/tagLibrary2pdf.xsl -o:"$outfile"-tmp.xml SAA="yes" ISBN="PLACEHOLDER ISBN VALUE" currentLanguage=$lang
		java -cp $saxon net.sf.saxon.Transform -xi:on -s:$2 -xsl:../transformations/tagLibrary2html.xsl -o:"$outfile".html SAA="yes" currentLanguage=$lang
		;;
	"ead")
		echo "generating EAD3 tag libraries"
		java -cp $saxon net.sf.saxon.Transform -s:$2 -xsl:../transformations/tagLibrary2pdf.xsl -o:"$outfile"-tmp.xml SAA="yes" ISBN="PLACEHOLDER ISBN VALUE" currentLanguage=$lang
		java -cp $saxon net.sf.saxon.Transform -s:$2 -xsl:../transformations/tagLibrary2html.xsl -o:"$outfile".html SAA="yes" currentLanguage=$lang
		;;
	"premis")
		echo "generating PREMIS tag libraries"
		java -cp $saxon net.sf.saxon.Transform -s:$2 -xsl:../transformations/tagLibrary2pdf.xsl -o:"$outfile"-tmp.xml SAA="no" ISBN="PLACEHOLDER ISBN VALUE" currentLanguage=$lang
		java -cp $saxon net.sf.saxon.Transform -s:$2 -xsl:../transformations/tagLibrary2html.xsl -o:"$outfile".html SAA="no" currentLanguage=$lang
		;;
	*)
		echo "supplied tag library must be: eac, ead, premis"
		exit 1
esac

# generate the FOXML->PDF, then delete FOXML
$fop -c fop-config.xml "$outfile"-tmp.xml "$outfile".pdf
rm "$outfile"-tmp.xml

echo "All done!"
