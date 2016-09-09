#!/bin/bash

#URL[0]='http://patents.reedtech.com/downloads/GrantRedBookText/2016/ipg160517.zip'
filename="list-ipg-xml.txt"
#read all url into array URL
readarray URL <$filename

#execute each url
for i in ${URL[@]}
do

./import-full-text-patent-xml.sh $i >output.txt 2>&1
if [ $? -eq 0 ]; then
    echo $i >> importedXML.txt
else
    echo $i >> failImportXML.txt
fi


done
