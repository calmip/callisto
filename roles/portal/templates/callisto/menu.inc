<?php global $CALLISTO_VERSION; $CALLISTO_VERSION="0.8.0" ?>

<body style="height:100%;margin:0;padding:0;" > 

  <?php 
    $headers = getallheaders();

    if (!isset($headers['AJP_eppn']) || $headers['AJP_eppn']=='')
    {
       $logged = false;
    } 
    else
    {
       $logged = true;
       $user   = $headers['AJP_givenName']." ".$headers['AJP_sn']; 
    }
  ?>

  <!-- End header  -->
  
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

<!--
   MAIN callisto MENU 
-->



  <!-- Start menu -->
  <div style="height:10%;margin:0;padding:0;" id="mu-menu" >
    <nav class="navbar navbar-default" role="navigation">
      <div class="container">
        <img src="assets/img/logo_calmip.svg" alt="logo" style="height:50px;margin:10px;float: left;"/>
	

        <div class="navbar-header">
	<span id="versionnb">CALLISTO - Version <?php global $CALLISTO_VERSION; echo $CALLISTO_VERSION; ?></span>
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
            <li class="active"><a href="/">Home</a></li>
           <!--  <li><a href="/callisto/index-dataverse.php">Collaborate</a></li> -->
            <li><a href="index-work.php">Work</a></li>
            <li><a href="index-tools.php">Tools</a></li>
            <li><a href="index-contact.php">Contact</a></li>
            <?php if ($logged == false): ?>
               <li><a href="/login">Login</a></li>
            <?php else: ?>
               <li><a href="/logout">Logout</a></li>
	       <li><a href="#"><?php echo $user ?></a></li>
	    <?php endif ?>
	    {% if callisto_living_on=="laptop" %}
	    <li><a href="https://{{dataverse_url}}">valid dataverse certif</a></li>
	    {% endif %}

          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
  </div>
  <!-- End menu -->

