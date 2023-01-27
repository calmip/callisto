<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>
    <body> 
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>  
        <script src="public/js/cyto/cytoscape.min.js"></script>
        <?php include('components/header.php') ?>

            <br/><br/><br/><br/><br/><br/>
	    <label for="repository">Select a repository</label>
	    <select name="repository" class="w--15 m--b--1" id="repository" onchange="Change_repository()">
	    	    <option value="sms">Smart Morphing and Sensing (SMS)</option>
		    <option value="demonstration">Demonstration</option>
            </select>
            and your search:
	    <input name="keywords" type="text" value="Morphing lift drag" id="information" size="35">
	    <button id = "seekInfo" class="inner-border" onclick="event.preventDefault(); SeekInformation();">Search</button
	<div id="sada-workflow">
	     <div id="sada-graph">
                    <h2>Workflow</h2>
		    <div id="cy">
        	    </div>
	     </div>
	</div>		    
<div id="sem_information"></div>
<div id="displaylayout">
     DISPLAY MODE:<br/>
     <input type="radio" name="layout_display" onclick="Toggle_layout(1);" checked><label>Breadthfirst  </label><br/>
     <input type="radio" name="layout_display" onclick="Toggle_layout(2);"><label>Circle  </label><br/>
     <input type="radio" name="layout_display" onclick="Toggle_layout(3);"<label>Concentric  </label><br/>
     <input type="radio" name="layout_display" onclick="Toggle_layout(4);"<label>Cose  </label></p><br/>
</div>
<div id="displayresults" class="flex flex--center unselectable pointer m--x--2 inner-border rounded p--x--1 side-btn">
     <button id =  "getRes" onclick="freeze_commands(); AutomateServices(); release_commands()";>Get results</button></p>
</div>
<div id="linktoresults">
</div>

            
	
        <?php include('components/footer.php') ?>
        <?php include('components/transitions.php') ?>
        <?php include('components/scripts.php') ?>
        <script src="public/js/functions/appendElement.js"></script>
        <script src="public/js/functions/extensions.js"></script>
        <script src="public/js/pages/sada.js"></script>
	<script src="public/js/FctsAllegro.js"></script>
        <script src="public/js/components/loadscreen.js"></script>
       

       
    </body>
</html>
