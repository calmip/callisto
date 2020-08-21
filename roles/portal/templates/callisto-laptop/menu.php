<?php 
/*
   MAIN callisto MENU 
*/
?>

<?php $logged="NEVER" ?>

  <!--START SCROLL TOP BUTTON -->
    <a class="scrollToTop" href="#">
      <i class="fa fa-angle-up"></i>      
    </a>
  <!-- End header  -->
  <!-- Start menu -->
  <section id="mu-menu">
    <nav class="navbar navbar-default" role="navigation">  
      <div class="container">
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
            <li class="active"><a href="index.php">Home</a></li>            
	    <?php if ($logged===true || $logged==="NEVER"): ?>
            <li><a href="http://callisto-local.mylaptop/index-dataverse.php">Collaborate</a></li>
	    <?php endif ?>
            <li><a href="work.html">Work</a></li>
	    <li><a href="tools.html">Tools</a></li>
            <li><a href="contact.html">Contact</a></li>
	    <?php if ($logged === false): ?>
	       <li><a href="/login">Login</a></li>
	    <?php endif ?>
            <?php if ($logged === true): ?>
               <li><a href="/logout">Logout</a></li>
               <li><a href="#"><?php echo $user ?></a></li>
	    <?php endif ?>

          </ul>                     
        </div><!--/.nav-collapse -->        
      </div>     
    </nav>
  </section>
  <!-- End menu -->

