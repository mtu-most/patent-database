#!/bin/bash
#find previous files
FILES="$(find /itss/local/home/freeipmtu/patent/ -type f -name 'MaintFeeEvents*.*')"

#remove previous files
for i in $FILES
do
	rm "$i"
done

#download the updated file weekly, Wednesday at 1am, 0 1 * * 3 for cron job
wget http://patents.reedtech.com/downloads/PatentMaintFeeEvents/1981-present/MaintFeeEvents.zip -O /itss/local/home/freeipmtu/patent/MaintFeeEvents.zip
unzip /itss/local/home/freeipmtu/patent/MaintFeeEvents.zip -d /itss/local/home/freeipmtu/patent

#find the extracted file
FILES="$(find /itss/local/home/freeipmtu/patent/ -type f -name 'MaintFeeEvents*.txt')"

#load txt file into database table, maintenance_fee_events
pass="PASSWORD"
user="USERNAME"
mysql -u $user -p$pass -Bse "use freeipmt_expired_patents;TRUNCATE TABLE maintenance_fee_events;LOAD DATA LOCAL INFILE '$FILES' INTO TABLE maintenance_fee_events FIELDS TERMINATED BY ' '  LINES TERMINATED BY '\n'"

#load only expired patent into table expired_patents_checked
mysql -u $user -p$pass -Bse "use freeipmt_expired_patents;TRUNCATE TABLE expired_patents_checked;INSERT INTO expired_patents_checked SELECT DISTINCT us_patent_number FROM maintenance_fee_events WHERE maintenance_fee_event_code = 'EXP.'"
echo "Finished loading ${FILES}..."

#load inactive patents into us_inactive_patents
mysql -u $user -p$pass -Bse "use freeipmt_expired_patents;TRUNCATE TABLE us_inactive_patents;INSERT INTO us_inactive_patents (us_patent_number , us_patent_title , us_patent_issue_date , us_term_of_grant) SELECT b.us_patent_number , a.us_patent_title , a.us_patent_issue_date , a.us_term_of_grant FROM full_text_us_patents AS a INNER JOIN expired_patents_checked AS b ON RIGHT(a.us_patent_number,7) = b.us_patent_number;"

mysql -u $user -p$pass -Bse "use freeipmt_expired_patents; INSERT INTO us_inactive_patents (us_patent_number , us_patent_title , us_patent_issue_date , us_term_of_grant) SELECT b.us_patent_number , a.us_patent_title , a.us_patent_issue_date , a.us_term_of_grant FROM full_text_us_patents AS a INNER JOIN expired_patents_checked AS b ON CONCAT(LEFT(a.us_patent_number,1),RIGHT(a.us_patent_number,6)) = b.us_patent_number;"
echo "Finished loading into us_inactive_patents..."
