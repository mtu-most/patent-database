#!/bin/bash
# this bash should be run every Wednesday

#url to new patent every Tuesday
URL='http://patents.reedtech.com/downloads/GrantRedBookText/'$(date +"%Y")'/ipg'$(date -dlast-tuesday +"%y%m%d")'.zip'

./import-full-text-patent-xml.sh $URL >xmlOutput.txt 2>&1
if [ $? -eq 0 ]; then
    echo $i >> importedXML.txt
else
    echo $i >> failImportXML.txt
fi