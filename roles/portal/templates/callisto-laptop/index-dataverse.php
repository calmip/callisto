<!DOCTYPE html>
<html style="height:100%;margin:0;padding:0;" lang="en">
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
  <body style="height:100%;margin:0;padding:0;" > 

<!--	    
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

<?php $logged = true ?>

  <!-- End header  -->
  <!-- Start menu -->
  <div style="height:10%;margin:0;padding:0;" id="mu-menu" >
    <nav class="navbar navbar-default" role="navigation">  
      <div class="container">
        <img src="assets/img/logo_calmip.svg" alt="logo" style="height:50px;margin:10px;float: left;"/>
        <div class="navbar-header">
          <!-- FOR MOBILE VIEW COLLAPSED BUTTON -->
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul id="top-menu" class="nav navbar-nav navbar-right main-nav">
            <li class="active"><a href="/callisto/index.php">Home</a></li>            
            <li><a href="/callisto/index-dataverse.php">Collaborate</a></li>
            <li><a href="work.html">Work</a></li>
	    <li><a href="tools.html">Tools</a></li>
            <li><a href="contact.html">Contact</a></li>
	    <?php if ($logged == false): ?>
               <li><a href="/login">Login</a></li>
	    <?php else: ?>
               <li><a href="/logout">Logout</a></li>
               <li><a href="#"><?php echo $user ?></a></li>
	    <?php endif ?>

          </ul>                     
        </div><!--/.nav-collapse -->        
      </div>     
    </nav>
  </div>
  <!-- End menu -->
  <!-- Dataverse frame -->

  <div style="height:90%;margin:0;padding:0;">
  <iframe width="100%" height="100%" sandbox="allow-scripts allow-forms allow-modals allow-popups allow-same-origin " src="{{ callisto_protocol }}://dataverse.{{ callisto_url }}/loginpage.xhtml"></iframe>
  </div>

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
