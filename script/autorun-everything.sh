#!/bin/bash
# this bash should be run every Wednesday at 1am

#move index.php to maintenance folder
mv "/itss/local/home/freeipmtu/public_html/home/index.php" "/itss/local/home/freeipmtu/public_html/maintenance/"
mv "/itss/local/home/freeipmtu/public_html/maintenance/index.html" "/itss/local/home/freeipmtu/public_html/home/"

#url to new patent every Tuesday
URL='http://patents.reedtech.com/downloads/GrantRedBookText/'$(date +"%Y")'/ipg'$(date -dlast-tuesday +"%y%m%d")'.zip'

./script/XML/import-full-text-patent-xml.sh $URL >/itss/local/home/freeipmtu/script/XML/xmlOutput.txt 2>&1
if [ $? -eq 0 ]; then
    echo $URL >> /itss/local/home/freeipmtu/script/XML/importedXML.txt
else
    echo $URL >> /itss/local/home/freeipmtu/script/XML/failImportXML.txt
fi

./script/import-maintenance-fee-event.sh > /itss/local/home/freeipmtu/script/maintenanceFeeEventsOutput.txt 2>&1
if [ $? -eq 0 ]; then
    echo $(date +"%y%m%d") >> /itss/local/home/freeipmtu/script/importedMaintFeeEvents.txt
else
    echo $(date +"%y%m%d") >> /itss/local/home/freeipmtu/script/failImportMaintFeeEvents.txt
fi

#move index.php back
mv "/itss/local/home/freeipmtu/public_html/maintenance/index.php" "/itss/local/home/freeipmtu/public_html/home/"
mv "/itss/local/home/freeipmtu/public_html/home/index.html" "/itss/local/home/freeipmtu/public_html/maintenance/"
