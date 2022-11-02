<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>
    <body> 
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>  
        <script src="public/js/cytoscape.js/dist/cytoscape.min.js"></script>
        <!--<script src="public/js/cytoscape-klay.js"></script>-->

        <?php include('components/header.php') ?>

        <main class="flex pos--rel">
            <section class="bg m--0 flex flex--center flex--align-start w--50 shadow--side pos--rel z--3">
            <form action="" class="m--t--10 m--x--5 flex flex--col">
                    <h2 class="m--b--1">SADA (Semi-automatic data analysis)</h2>
                    <p class="text--small text--second-lisibility w--80 m--b--2">This semi-automatic data analysis interface allows you to identify datasets in a specified repository that match the text entered in the search field. For each of these datasets, you can then examine what operations are possible and what potential results you can obtain (automatic processing flows).</p>

                    <label for="repository">Step 1: Select a repository</label>
                    <select name="repository" class="w--50 m--b--1" id="repository" onchange="Change_repository()">
		    	    <option value="demonstration">Demonstration</option>
		    	    <option value="sms">Smart Morphing and Sensing (SMS)</option>
                    </select>

                    <label for="keywords">Step 2: Search by keywords</label>
                    <div class="input-container w--50 m--b--1">
                        <input name="keywords" type="text" value="un fichier de texte avec des lignes de mots" id="information">
                        <img src="" alt="">
                    </div>
                    <button id = "seekInfo" class="inner-border" onclick="event.preventDefault(); activateLoadscreen(); SeekInformation(); closeGetFiles(); hideGetFilesResultBox()">Search</button>
                </form> 
            </section>

            <aside class="w--50 pos--rel z--0">
                <div class="img-wrap" id="graphtest">
                    <img src="public/img/sada.jpg" />
                </div>
            </aside>

            <?php include_once('components/loadscreen.php') ?>

            <!-- SADA results -->
            <div id="sada-wrapper" class="pos--abs bg--pale h--full p--t--10 t--0 r--0 w--screen--50 z--1 flex--align-start flex--justify-center" hidden>
                <div id="sada-results" class="w--80 p--x--1 scrollable scrollable--y h--70"></div>
            </div>

            <!-- SADA workflow -->
            <div id="sada-workflow" class="pos--abs bg--pale h--full p--t--10 t--0 r--0 w--screen--50 z--1 flex--align-start flex--justify-center" hidden>
        
                <!-- SADA workflow graph -->
                <div id="sada-graph" class="w--80 p--x--1 scrollable h--70">
                    <h2>Workflow</h2>
                    <!-- Graph inner -->
                     <!-- <div id="sada-graph-inner" class="m--t--1 m--x--2 p--b--1 flex flex--justify-between">
                    </div>-->
                    <div id="cydetails">
                    </div>
                    <div id="cy">
                    </div>
                    <div id="cyresults">
                    <h2>Results will be displayed here</h2>
                    </div>
                    <div id="runflow">
                    <div id="displayresults" class="flex flex--center unselectable pointer m--x--2 inner-border rounded p--x--1 side-btn">
                        <p class="m--r--05"><button onclick="AutomateServices()">Get results</button></p>
                        <p class="m--r--05"><button><a href = "https://callisto-dev.calmip.univ-toulouse.fr/sada.php">Reset SADA</a></button></p>
                    </div>
                        <!-- get files form -->
                        <!--<div id="sada-get-files">
                            <span class="circle pos--abs t--0 r--0 close pointer flex flex--center" onclick="closeGetFiles()">&#10006;</span>
                            <b>Analyze and get files</b>
                            <form action="" class="flex flex--col m--t--1"></form>
                            <div id="animation-service__container">
                                <div class="lds-ring m--r--05">
                                    <div></div><div></div><div></div><div></div>
                                </div>
                                <p>This may take a little while...</p>
                            </div>
                            <div id="get-files-results" class="flex hidden">
                                <p>Downloadable files:</p>
                            </div>
                        </div>-->
                    </div>
                </div>

               
            </div>

            

        <div class="modal"><!-- Place at bottom of page --></div>
        </main>

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