#!/bin/bash
#Usage: ./import-full-text-patent-sgml.sh 'URL'
if [ $# -eq 0 ]
  then
    echo "No arguments supplied: Usage: ./import-full-text-patent-sgml.sh 'URL'"
else
	fullTextPatentUrl=$1
	workingFolder=/itss/local/home/freeipmtu/patent/full-text-patent-sgml
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
	FILES="$(find $workingFolder -type f -name '*.SGML' -o -name '*.sgml' -o -name '*.xml' -o -name '*.XML')"
	#delete lines that contain ''DOCTYPE'
	sed -i '/DOCTYPE\|ENTITY\|]>\|<\?xml/ d' $FILES >/dev/null
	echo "Spliting the huge SGML file into mutiple files..."
	#split into mutiple xml files by pttern <PATDOC
	csplit -s -z -f ${workingFolder}'/temp' -b '%05d.SGML' ${FILES} /\<PATDOC/ {*}

	#remove the original SGML file
	rm $FILES

	echo "Inserting patent info. into database..."
	#find xml file
	FILES="$(find $workingFolder -type f -name 'temp*.SGML')"

	#insert info of each patent into database
	for i in $FILES
	do
		#wxtract data from file
		patentNumber=$(grep -o '<B110><DNUM><PDAT>.*</PDAT></DNUM></B110>' $i | sed 's/\(<B110><DNUM><PDAT>\|<\/PDAT><\/DNUM><\/B110>\)//g')
		issueDate=$(grep -o '<B140><DATE><PDAT>.*</PDAT></DATE></B140>' $i | sed 's/\(<B140><DATE><PDAT>\|<\/PDAT><\/DATE><\/B140>\)//g')
		patentTitle=$(grep -o '<B540><STEXT><PDAT>.*</PDAT></STEXT></B540>' $i | sed 's/\(<B540><STEXT><PDAT>\|<\/PDAT><\/STEXT><\/B540>\)//g')
		termOfGrant=$(grep -o '<B474><PDAT>.*</PDAT></B474>' $i | sed 's/\(<B474><PDAT>\|<\/PDAT><\/B474>\)//g')

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

			mysql -u $user -p$pass -Bse "use freeipmt_expired_patents;INSERT INTO sgml_full_text_us_patents(us_patent_number, us_patent_title, us_patent_issue_date, us_term_of_grant) VALUES ('${patentNumber}','${patentTitle}',${issueDate},${termOfGrant})"
			if [ $? -eq 0 ]
			then
				#remove the file if no error
				rm $i
			else
				echo $i
				echo "use freeipmt_expired_patents;INSERT INTO sgml_full_text_us_patents(us_patent_number, us_patent_title, us_patent_issue_date, us_term_of_grant) VALUES ('${patentNumber}','${patentTitle}',${issueDate},${termOfGrant})"
			fi


		else
			#keep the error file name and url
			#echo -e '\n'$fullTextPatentUrl'\n'$i >> Error.txt
			patNumber=$(grep -o '<B110><DNUM><PDAT>.*</PDAT></DNUM></B110>' $i | sed 's/\(<B110><DNUM><PDAT>\|<\/PDAT><\/DNUM><\/B110>\)//g')
			echo -e '\n'$patNumber >> errorPatentNumber.txt
		fi
	done

fi
