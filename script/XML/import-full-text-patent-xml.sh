#!/bin/bash
#Usage: ./import-full-text-patent-xml.sh 'URL'
if [ $# -eq 0 ]
  then
    echo "No arguments supplied: Usage: ./import-full-text-patent-xml.sh 'URL'"
else
	fullTextPatentUrl=$1
	workingFolder=/itss/local/home/freeipmtu/patent/full-text-patent
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

	#Unzip the full text patent
	echo "Unziping the downloaded file..."
	unzip -j $tempZip -d $workingFolder

	echo "Removing the zip file..."
	#remove the zip file
	rm $tempZip

	#find xml file
	FILES="$(find $workingFolder -type f -name 'ipg*.xml' -o -name 'ipg*.XML')"
	#delete lines that contain ''DOCTYPE'
	sed -i '/DOCTYPE/ d' $FILES >/dev/null
	echo "Spliting the huge xml file into mutiple files..."
	#split into mutiple xml files by pttern <?xml
	csplit -s -z -f ${workingFolder}'/temp' -b '%05d.xml' ${FILES} /\<\?xml/ {*}

	#remove the original xml file
	rm $FILES

	echo "Inserting patent info. into database..."
	#find xml file
	FILES="$(find $workingFolder -type f -name 'temp*.xml')"

	#insert info of each patent into database
	for i in $FILES
	do
		#grep return 0 when found the string
		if ! grep -Fxq "us-patent-grant" $i
		then
		    # extract data, ;q to quit after first match
			patentNumber=$(grep -o '<doc-number>.*</doc-number>' $i | sed 's/\(<doc-number>\|<\/doc-number>\)//g;q')
			issueDate=$(grep -o '<date>.*</date>' $i | sed 's/\(<date>\|<\/date>\)//g;q')
			patentTitle=$(grep -o '<invention-title.*>.*</invention-title>' $i | sed 's/\(<invention-title.*">\|<\/invention-title>\)//g;q')
			termOfGrant=$(grep -o '<length-of-grant>.*</length-of-grant>' $i | sed 's/\(<length-of-grant>\|<\/length-of-grant>\)//g;q')
		#elif [ grep -Fxq "sequence-cwu" $i ]
		#then
		    # no title information in sequence
		#	patentNumber=$(xmllint --xpath '/sequence-cwu/publication-reference/document-id/doc-number/text()' $i)
		#	issueDate=$(xmllint --xpath '/sequence-cwu/publication-reference/document-id/date/text()' $i)
		#	patentTitle=$(xmllint --xpath '/us-patent-grant/us-bibliographic-data-grant/invention-title/text()' $i)
		#	termOfGrant=$(xmllint --xpath '/us-patent-grant/us-bibliographic-data-grant/us-term-of-grant/length-of-grant/text()' $i 2>/dev/null)
		else
			#patentNumber equal empty
			patentNumber=
		fi
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

			mysql -u $user -p$pass -Bse "use freeipmt_expired_patents;INSERT INTO full_text_us_patents(us_patent_number, us_patent_title, us_patent_issue_date, us_term_of_grant) VALUES ('${patentNumber}','${patentTitle}',${issueDate},${termOfGrant})"
			if [ $? -eq 0 ]
			then
				#remove the file if no error
				rm $i
			else
				echo $i
				echo "use freeipmt_expired_patents;INSERT INTO full_text_us_patents(us_patent_number, us_patent_title, us_patent_issue_date, us_term_of_grant) VALUES ('${patentNumber}','${patentTitle}',${issueDate},${termOfGrant})"
			fi


		else
			#keep the error file name and url
			#echo -e '\n'$fullTextPatentUrl'\n'$i >> Error.txt
			patNumber=$(grep -o '<doc-number>.*</doc-number>' $i | sed 's/\(<doc-number>\|<\/doc-number>\)//g;q')
			echo -e '\n'$patNumber >> errorPatentNumber.txt
		fi



	done

fi
