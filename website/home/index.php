<?php
//ob_start();
session_start();						
?>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Free Inactive Patent Search &mdash; 100% Free Inactive Patent Information</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free Inactive Patent Information" />
	<meta name="keywords" content="Inactive, Patent, Search" />
	<meta name="author" content="Yuenyong" />

  <!-- 
	//////////////////////////////////////////////////////

	FREE HTML5 TEMPLATE 
	DESIGNED & DEVELOPED by FREEHTML5.CO
		
	Website: 		http://freehtml5.co/
	Email: 			info@freehtml5.co
	Twitter: 		http://twitter.com/fh5co
	Facebook: 		https://www.facebook.com/fh5co

	//////////////////////////////////////////////////////
	 -->

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,300,700|Roboto:300,400' rel='stylesheet' type='text/css'>
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="css/bootstrap.css">

	<link rel="stylesheet" href="css/style.css">


	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

	</head>
	<body>
	<div class="box-wrap">
		<header role="banner" id="fh5co-header">
			<div class="container">
				<nav class="navbar navbar-default">
					<div class="row">
						<div class="col-md-3">
							<div class="fh5co-navbar-brand">
								<a class="fh5co-logo" href="http://www.mtu.edu" target="_blank"><img src="images/Husky_MichiganTechnologicalUniv_TwoColor_NoR.png" height="70" width="218" alt="Michigan Tech Logo"></a>
								<br>Free Inactive Patent Search
								<!-- <br>We provide inactive patents information due to maintenance fee. -->
							</div>
						</div>
						<div class="col-md-6">
							<ul class="nav text-center">
								<li><a href="index.php">Search</a></li>
								<!-- <li class="active"><a href="index.html"><span>Work</span></a></li> -->
								<li><a href="inside.html">About</a></li>
								<!-- <li><a href="services.html">Services</a></li> -->
								<!-- <li><a href="contact.html">Contact</a></li> -->
							</ul>
						</div>
						<div class="col-md-3">
							<ul class="social">
								<!-- <li><a href="https://twitter.com/ProfPearce" target="_blank"><i class="icon-twitter"></i></a></li> -->
								<!-- <li><a href="#"><i class="icon-dribbble"></i></a></li> -->
								<!-- <li><a href="#"><i class="icon-instagram"></i></a></li> -->
								<!-- <li><a href="https://www.facebook.com/mostmtu" target="_blank"><i class="icon-facebook"></i></a></li> -->
								<!-- <li><a href="http://www.appropedia.org/Category:MOST" target="_blank"><i class="icon-bookmark"></i></a></li> -->
								<!-- <li><a href="#"><img src="images/247px-Aprologo-old.png" width="25" height="25" alt=""></a></li> -->
							</ul>
						</div>
					</div>
				</nav>
		  </div>
		</header>
		<!-- END: header -->
		<section id="result">
			<div class="container">
				<!-- <script type="text/css">
					#loading {
					   width: 100%;
					   height: 100%;
					   top: 0px;
					   left: 0px;
					   position: fixed;
					   display: block;
					   opacity: 0.7;
					   background-color: #fff;
					   z-index: 99;
					   text-align: center;
					}
					
					#loading-image {
					  position: absolute;
					  top: 100px;
					  left: 240px;
					  z-index: 100;
					}
				</script> -->
					<div id="loading" style="text-align: center">
	  					<h2>Loading...</h2>
	  					<img id="loading-image" src="images/dogs-running2.gif" alt="Loading..." />
					</div>
					<?php
						if ($_SERVER["REQUEST_METHOD"] == "POST" || isset($_GET['page']) || isset($_GET['tpages'])) { // if it is not submitted then show the form
							$searchTerm = "" != trim($_POST['STerm']) ? trim($_POST['STerm']) : null;
							if (($searchTerm == null || strlen($searchTerm) < 2) && empty($_GET['page']) && empty($_GET['tpages'])) {
								//no search string
						    	$errorMsg = "Please type in word[s] to search!";
						    	echo "<br><br><br><br><div align=\"center\"><h2>".$errorMsg."</h2>";
						    	//header('Location: http://www.freeip.mtu.edu/freeip');
						    	echo '<form><input type="button" onClick="window.history.back();" id="reload" class="btn btn-primary" value="Try Again"></form></div>';
						  	} else {
						  		//session_start();	
						  			include ('pagination.php');
						    		include ('dbresult.php');
						  			if (empty($_GET['page'])) {
						  				//echo '<div class="col-md-6 field"><input type="text" name="STerm" id="searchterm" class="form-control"><input type="submit" id="submit" class="btn btn-primary" value="Search"></div>';
								  		//search string is not empty
								  		//echo "<h2>There is a string!</h2>";
								  		//echo "Search Term: ".$searchTerm;
								  		
								    	
								  		//create database connection
										$db_conn = new mysqli("localhost", "USERNAME", "PASSWORD", "freeipmt_expired_patents"); 
										if ($db_conn->errno) die("Database connection failed: " . htmlspecialchars($db_conn->error()));
										//prepare query
										//remove conjunction words, and, or
										$searchConj = array('/\band\b/u','/\bAND\b/u','/\bAnd\b/u','/\bor\b/u','/\bOR\b/u','/\bOr\b/u');
										$replaceconj = array("","","","","","");
										$searchTerm = preg_replace($searchConj, $replaceConj, $searchTerm);
										//separate keywords
										$keywords = explode(" ", $searchTerm);
										$countKeywords = count($keywords);
										
										//$qString1 = "SELECT `us_patent_number`,`us_patent_title`,`us_patent_issue_date` FROM `full_text_us_patents` WHERE `us_patent_title` LIKE '%".$keywords[0]."%'";
										$qString1 = "SELECT `us_patent_number`,`us_patent_title`,`us_patent_issue_date` FROM `us_inactive_patents` WHERE `us_patent_title` REGEXP '[[:<:]]".$keywords[0]."[[:>:]]'";
										$qString2 = "SELECT `us_patent_number`,`us_patent_title`,`us_patent_issue_date` FROM `us_inactive_patents` WHERE `us_patent_title` REGEXP '[[:<:]]".$keywords[0]."[[:>:]]'";
										for($i=1 ; $i < $countKeywords; $i++){
											if($keywords[$i] != "") {
		    									$qString1 .= " AND `us_patent_title` REGEXP '[[:<:]]".$keywords[$i]."[[:>:]]'";
		    									$qString2 .= " OR `us_patent_title` REGEXP '[[:<:]]".$keywords[$i]."[[:>:]]'";
		    								}
		  								}
		  								//$qString = $qString1." UNION ".$qString2;
		  								//use only AND
		  								$qString = $qString1;
		  								$qString = $qString." ORDER BY `us_patent_issue_date` DESC";
		  								//echo $qString;
										//query
										$ret = $db_conn->query($qString);
										//count results
										$rows_ret = mysqli_num_rows($ret);
										//declare array variables
										$patNum = array();
										$titlePat = array();
										$issueDate = array();
										//fetch data into array
										while ($row = mysqli_fetch_array($ret, MYSQLI_ASSOC)) {
    										$patNum[] = $row['us_patent_number'];
    										$titlePat[] = $row['us_patent_title'];
    										$issueDate[] = $row['us_patent_issue_date'];
										}
										//store results in sessions
										$_SESSION['patNum'] = $patNum;
										$_SESSION['titlePat'] = $titlePat;
										$_SESSION['issueDate'] = $issueDate;
										$_SESSION['rows_ret'] = $rows_ret;
										$_SESSION['searchTerm'] = $searchTerm;
						  			}
						  			else {
						  				//echo "get_page has value!";
						  				//restore sessions to variables
						  				$patNum = $_SESSION['patNum'];
						  				$titlePat = $_SESSION['titlePat'];
						  				$issueDate = $_SESSION['issueDate'];
						  				$rows_ret = $_SESSION['rows_ret'];
						  				$searchTerm = $_SESSION['searchTerm'];
						  			}
						  		
								
								echo "<div style=\"padding-bottom:10px;\"><font size=\"2\">About ".number_format($rows_ret)." results for \"".$searchTerm."\"</font></div>";
								//set how many records per page
								$per_page = 25;
								$num_pages = ceil($rows_ret / $per_page);
								//echo "Number of pages: ".$num_pages;
								//-------------if page is setcheck------------------//
								if (isset($_GET['page'])) {
								    $show_page = $_GET['page']; //current page
								    if ($show_page > 0 && $show_page <= $num_pages) {
								        $start = ($show_page - 1) * $per_page;
								        $end = $start + $per_page;
								    } else {
								        // error - show first set of results
								        $start = 0;              
								        $end = $per_page;
								    }
								} else {
								    // if page isn't set, show first set of results
								    $show_page = 1;
								    $start = 0;
								    $end = $per_page;
								}
								// display pagination
								$page = intval($_GET['page']);
								$tpages=$num_pages;
								if ($page <= 0)
								    $page = 1;
								 //check reload page
							    $reload = $_SERVER['PHP_SELF'] . "?tpages=" . $tpages;
							   
							    // display data
							    // loop through results of database query, displaying them
							    for ($i = $start; $i < $end; $i++) {
							        // make sure that PHP doesn't try to show results that don't exist
							        if ($i == $rows_ret) {
							            break;
							        }
							        // if patent number > 7 digits
							        if (strlen($patNum[$i])>7) {
							        		if($patNum[$i][0]=='0') {
							        			$patNum[$i] = substr($patNum[$i], 1, 7);
							        		}
							        		else {
							        			$patNum[$i] = $patNum[$i][0].substr($patNum[$i], 2, 6);
							        		}
							        }
										//echo search results
							        echo"<p><font face=\"arial\" size=3><a href=\"http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO1&Sect2=HITOFF&d=PALL&p=1&u=%2Fnetahtml%2FPTO%2Fsrchnum.htm&r=1&f=G&l=50&s1=".$patNum[$i].".PN.&OS=PN/".$patNum[$i]."&RS=PN/".$patNum[$i]."\" target=\"_blank\">".htmlspecialchars($titlePat[$i])."</a></font><br>";
							        echo"<font face=\"arial\" size=2>Patent No.: ".$patNum[$i]."&nbsp;&nbsp;&nbsp;Issue Date: ".$issueDate[$i]."</font></p>";
							    }       
							//echo pagination
					 		echo '<div align="left"><ul class="pagination pagination-sm">';
					    	if ($num_pages > 1) {
					        	echo paginate($reload, $show_page, $num_pages);
					    	}
					    	echo "</ul></div>";
						  	}//if ($searchTerm == null)
							
						} else {
							session_unset();
						?>
				</div>
			</section>
			<section id="intro">
			<br><br><br><br>
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
						<div class="intro animate-box">
							<!-- <h2>We are web agency based in London &amp; we love functional &amp; meaningful design.</h2> -->
							<form name="searchForm" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
								<div class="form-group row">
									<div class="col-md-12 field">
										<input type="text" name="STerm" id="searchterm" class="form-control" autofocus>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-md-12 field">
										<input type="submit" id="submit" class="btn btn-primary" value="Search">
									</div>
								</div>
							</form>
						<?php
						}//if ($_SERVER["REQUEST_METHOD"] == "POST")
						//ob_end_flush();
						?>
						</div>
					</div>
				</div>
			<div>
		</section>

		<!-- <section id="work">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="fh5co-grid animate-box" style="background-image: url(images/work-1.jpg);">
							<a class="image-popup text-center" href="#">
								<div class="work-title">
									<h3>Don’t Just Stand There</h3>
									<span>Illustration, Print</span>
								</div>
							</a>
						</div>
					</div>
					<div class="col-md-6">
						<div class="fh5co-grid animate-box" style="background-image: url(images/work-2.jpg);">
							<a class="image-popup text-center" href="#">
								<div class="work-title">
									<h3>Don’t Just Stand There</h3>
									<span>Illustration, Print</span>
								</div>
							</a>
						</div>
					</div>
					<div class="col-md-8">
						<div class="fh5co-grid animate-box" style="background-image: url(images/work-5.jpg);">
							<a class="image-popup text-center" href="#">
								<div class="work-title">
									<h3>Don’t Just Stand There</h3>
									<span>Illustration, Print</span>
								</div>
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="fh5co-grid animate-box" style="background-image: url(images/work-4.jpg);">
							<a class="image-popup text-center" href="#">
								<div class="work-title">
									<h3>Don’t Just Stand There</h3>
									<span>Illustration, Print</span>
								</div>
							</a>
						</div>
					</div>

					<div class="col-md-12">
						<div class="fh5co-grid animate-box" style="background-image: url(images/work-3.jpg);">
							<a class="image-popup text-center" href="#">
								<div class="work-title">
									<h3>Ampersand</h3>
									<span>Illustration, Print</span>
								</div>
							</a>
						</div>
					</div>

				</div>
			<div>
		</section>

		<section id="services">
			<div class="container">
				<div class="row">
					<div class="col-md-4 animate-box">
						<div class="service">
							<div class="service-icon">
								<i class="icon-command"></i>
							</div>
							<h2>Brand Identity</h2>	
							<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia.</p>
						</div>
					</div>
					<div class="col-md-4 animate-box">
						<div class="service">
							<div class="service-icon">
								<i class="icon-drop2"></i>
							</div>
							<h2>Web Design &amp; UI</h2>
							<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia.</p>
						</div>
					</div>
					<div class="col-md-4 animate-box">
						<div class="service">
							<div class="service-icon">
								<i class="icon-anchor"></i>
							</div>
							<h2>Development &amp; CMS</h2>
							<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia.</p>
						</div>
					</div>
				</div>
			</div>
		</section> -->

		<footer id="footer" role="contentinfo">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-center ">
						<div class="footer-widget border">
							<!-- <p class="pull-left"><small>&copy; Closest Free HTML5. All Rights Reserved.</small></p> -->
							<!-- <p class="pull-right"><small> Designed by  <a href="http://freehtml5.co/" ta>freehtml5.co</a>  Images: <a href="https://unsplash.com/">Unsplash</a></small></p> -->
							
						</div>
					</div>
				</div>
			</div>
		</footer>
	</div>
	<!-- END: box-wrap -->
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>

	<!-- Main JS (Do not remove) -->
	<script src="js/main.js"></script>
	<script language="javascript" type="text/javascript">
	     $(window).load(function() {
	     $('#loading').hide();
	  });
	</script>
	</body>
</html>

