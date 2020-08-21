<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>Callisto | Home</title>

    <!-- Favicon -->
    <link rel="shortcut icon" href="assets/img/favicon.ico" type="image/x-icon">

    <!-- Font awesome -->
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">   
    <!-- Slick slider -->
    <link rel="stylesheet" type="text/css" href="assets/css/slick.css">          
    <!-- Fancybox slider -->
    <link rel="stylesheet" href="assets/css/jquery.fancybox.css" type="text/css" media="screen" /> 
    <!-- Theme color -->
    <link id="switcher" href="assets/css/theme-color/default-theme.css" rel="stylesheet">          

    <!-- Main style sheet -->
    <link href="assets/css/style.css" rel="stylesheet">    

   
    <!-- Google Fonts -->
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,400italic,300,300italic,500,700' rel='stylesheet' type='text/css'>
    

  </head>
  <body> 

<!-- Used with Shib 	    
  <?php 
    $headers = getallheaders();
    if ($headers['AJP_eppn']=='')
    {
       $logged = false;
    } 
    else
    {
       $logged = true;
       $user   = $headers['AJP_givenName']." ".$headers['AJP_sn']; 
    }
  ?>

-->

<?php include_once "menu.php" ?>

  <!-- Start search box -->
  <div id="mu-search">
    <div class="mu-search-area">      
      <button class="mu-search-close"><span class="fa fa-close"></span></button>
      <div class="container">
        <div class="row">
          <div class="col-md-12">            
            <form class="mu-search-form">
              <input type="search" placeholder="Type Your Keyword(s) & Hit Enter">              
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- End search box -->
  <!-- Start Slider -->
  <section id="mu-slider">
    <!-- Start single slider item -->
    <div class="mu-slider-single">
      <div class="mu-slider-img">
        <figure>
          <img src="assets/img/slider/bandeau.jpg" alt="img">
        </figure>
      </div>
      <div class="mu-slider-content">
        
        <span></span>
        <h2>Welcome to CALLISTO</h2>
        <p></p>
        <!-- <a href="#" class="mu-read-more-btn">Read More</a>-->
      </div>
    </div>
    <!-- Start single slider item -->    
  </section>
  <!-- End Slider -->
  <!-- Start service  -->
  <section id="mu-service">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 col-md-12">
          <div class="mu-service-area">
            <!-- Start single service -->
            <div class="mu-service-single">
              <span class="fa fa-users"></span>
              <h3>Collaborate</h3>
              <p>Use the CALLISTO DataVerse instance to share your data, and discover other datasets useful for you.</p>
	      <!-- <a href="https://callisto.calmip.univ-toulouse.fr/loginpage.xhtml" target="_blank" class="mu-read-more-btn">Begin</a> -->
	      <?php if ($logged==true): ?>
	      <a href="/index-dataverse.php" target="_blank" class="mu-read-more-btn">Begin</a>
	      <?php else: ?>
	      <a href="/Shibboleth.sso/Login?target=/index-dataverse.php" target="_blank" class="mu-read-more-btn">Begin</a>
              <?php endif ?>
            </div>
            <!-- Start single service -->
            <!-- Start single service -->
            <div class="mu-service-single">
              <span class="fa fa-table"></span>
              <h3>Work</h3>
              <p>Use the embedded tools to ease the discovery of data and software. Tell CALLISTO what you need and let us guide you!</p>
	       <a href="work.html" class="mu-read-more-btn">Web interface</a>
	       <a href="http://callisto-local.mylaptop/hub/" class="mu-read-more-btn">Interactive scripting</a>
            </div>
            <!-- Start single service -->
	    <div class="mu-service-single">
              <span class="fa fa-table"></span>
              <h3>Toolbox</h3>
              <p>Find online tools that may help you describing your data, understanding the interoperability whereabouts, writing your DMPs and more...</p>
	             <a href="tools.html" class="mu-read-more-btn">Go</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- End service  -->

  <!-- Start about us -->
  <section id="mu-about-us">
    <div class="container">
      <!-- Start Title -->
      <div class="mu-title">
        <h2>About Callisto</h2>              
      </div>
      <!-- End Title -->
      <p>CALmip Launches an Interface for a Semantic Toolbox Online (CALLISTO) is a Web interface allowing researchers to share, discover and use data, data services and analysis services. It is intended to help collaborators achieve a FAIR (Findable, Accessible, Interoperable and Reliable) data management. <br/> <br/>Callisto is a work in progress. Its intent is to test methods for ensuring FAIR access to scientific data for the CALMIP community of users. Currently, the functionalities on the testbench are:</p>
      <ul>
        <li>Automatic generation of schema.org for sharing datasets.</li>
        <li>Hosting a dedicated DataServe instance for sharing data among projects with fine-grained authorizations</li>
        <li>An OAI-PMH repository for open datasets (part of the DataVerse instance)</li>
        <li>Ontology-based reasoning on datasets and services (looking towards ta future Virtual Research Environment)</li>
      </ul>
    </div>    
  </section>
  <!-- End about us -->
  
  <!-- jQuery library -->
  <script src="assets/js/jquery.min.js"></script>  
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="assets/js/bootstrap.js"></script>   
  <!-- Slick slider -->
  <script type="text/javascript" src="assets/js/slick.js"></script>
  <!-- Counter -->
  <script type="text/javascript" src="assets/js/waypoints.js"></script>
  <script type="text/javascript" src="assets/js/jquery.counterup.js"></script>  
  <!-- Mixit slider -->
  <script type="text/javascript" src="assets/js/jquery.mixitup.js"></script>
  <!-- Add fancyBox -->        
  <script type="text/javascript" src="assets/js/jquery.fancybox.pack.js"></script>
  
  
  <!-- Custom js -->
  <script src="assets/js/custom.js"></script> 

  </body>
</html>
