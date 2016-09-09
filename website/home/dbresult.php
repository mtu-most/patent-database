<?php
function db_result($result,$row,$field) { 
  if($result->num_rows==0) return 'unknown'; 
  $result->data_seek($row);
  $ceva=$result->fetch_assoc(); 
  $rasp=$ceva[$field]; 
  return $rasp; 
}
?>

