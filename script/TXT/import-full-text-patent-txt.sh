#!/bin/bash
#Usage: ./import-full-text-patent-txt.sh 'URL'
if [ $# -eq 0 ]
  then
    echo "No arguments supplied: Usage: ./import-full-text-patent-txt.sh 'URL'"
else
	fullTextPatentUrl=$1
	workingFolder=/itss/local/home/freeipmtu/patent/full-text-patent-txt
	tempZip=${workingFolder}/temp.zip
	#password for mysql
	pass="PASSWORD"
	user="USERNAME"


	echo "Removing previous files..."
	#find previous files
	FILES="$(find $workingFolder -type f -name '*.*')"

	#remove previous files
	for i in $FILES
	do
		rm "$i"
	done

	echo "Downloading new patent file..."
	#download the full-text-patent zip file
	wget $fullTextPatentUrl -O $tempZip

	#Unzip the full text patent, -j = no directory
	echo "Unziping the downloaded file..."
	unzip -j $tempZip -d $workingFolder

	echo "Removing the zip file..."
	#remove the zip file
	rm $tempZip

	#find SGML file
	FILES="$(find $workingFolder -type f -name '*.txt' -o -name '*.TXT')"
	#delete lines that contain ''HHHHHT'
	sed -i '/HHHHHT/ d' $FILES >/dev/null
	echo "Spliting the huge TXT file into mutiple files..."
	#split into mutiple xml files by pttern PATN
	csplit -s -z -f ${workingFolder}'/temp' -b '%05d.txt' ${FILES} /PATN/ {*}

	#remove the original SGML file
	rm $FILES

	echo "Inserting patent info. into database..."
	#find xml file
	FILES="$(find $workingFolder -type f -name 'temp*.txt')"

	#insert info of each patent into database
	for i in $FILES
	do
		#wxtract data from file
		patentNumber=$(grep -o 'WKU.*' $i | sed 's/\(WKU\s\s\)//g')
		#add q to quit after the first match
		issueDate=$(grep -o 'ISD.*' $i | sed 's/\(ISD\s\s\)//g;q')
		patentTitle=$(grep -o 'TTL.*' $i | sed 's/\(TTL\s\s\)//g')
		termOfGrant=$(grep -o 'TRM.*' $i | sed 's/\(TRM\s\s\)//g')

		#check if termOfGrant is empty
		if [ -z "$termOfGrant" ]
		then
			termOfGrant=0
		fi
		#check if patentNumber is empty
		if [ ! -z "$patentNumber" ]
		then
			#add backslash before single qoute
			patentTitle=${patentTitle//[\']/\\\'}
			#insert all patents' info into database

			mysql -u $user -p$pass -Bse "use freeipmt_expired_patents;INSERT INTO txt_full_text_us_patents(us_patent_number, us_patent_title, us_patent_issue_date, us_term_of_grant) VALUES ('${patentNumber:0:8}','${patentTitle}',${issueDate},${termOfGrant})"
			if [ $? -eq 0 ]
			then
				#remove the file if no error
				rm $i
			else
				echo $i
				echo "use freeipmt_expired_patents;INSERT INTO txt_full_text_us_patents(us_patent_number, us_patent_title, us_patent_issue_date, us_term_of_grant) VALUES ('${patentNumber:0:8}','${patentTitle}',${issueDate},${termOfGrant})"
			fi


		else
			#keep the error file name and url
			#echo -e '\n'$fullTextPatentUrl'\n'$i >> Error.txt
			patNumber=$(grep -o 'WKU.*' $i | sed 's/\(WKU\s\s\)//g')
			echo -e '\n'${patNumber:0:8} >> errorPatentNumber.txt
		fi
	done

fi
