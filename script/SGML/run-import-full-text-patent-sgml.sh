#!/bin/bash

#URL[0]='http://patents.reedtech.com/downloads/GrantRedBookText/2016/ipg160517.zip'
filename="list-pg-sgml.txt"
#read all url into array URL
readarray URL <$filename

#execute each url
for i in ${URL[@]}
do

./import-full-text-patent-sgml.sh $i >output.txt 2>&1
echo $i >> importedSGML.txt

done
