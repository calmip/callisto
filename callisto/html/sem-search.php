<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>

    <body>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

        <?php include('components/header.php') ?>

        <main class="flex">
            <section class="bg m--0 flex flex--center flex--align-start w--50 shadow--side pos--rel z--3">
                <form action="" class="m--t--10 m--x--5 flex flex--col">
                    <h2 class="m--b--1">Sem-search</h2>
                    <p class="text--small text--second-lisibility w--80 m--b--2">This interface allows you to find generic functionalities associated with a repository (Mean calculation, Power spectral distribution display...), search for scientific claims expressed in papers registered within the ontology, and search for any domain-specific term (Type 1 morphing, Permafrost...) and see how this domain relates to the repository's semantic graph.</p>

                    <!--<p class="text--small text--second-lisibility w--80 m--b--2">Following the query returns, a list of elements will be proposed, so that in a second step data related with those semantic elements can be retrieved or more explanation about these elements may be accessed.</p>-->

                    <label for="repository">Step 1: Select a repository</label>
                    <select name="repository" class="w--50 m--b--1" id="repository" onchange="Change_repository()">
                        <option value="demonstration">Demonstration</option>
                        <option value="sms">Smart Morphing and Sensing (SMS)</option>
                    </select>

                    <label for="research-type">Step 2: Select research information type</label>
                    <select name="research-type" class="w--50 m--b--1" id="research-type">
                        <option value="generic">Bibliographic claims</option>
                        <option value="functionality">Functionalities and generic context elements</option>
                    </select>

                    <label for="keywords">Step 3: Type a subject or an ontological definition</label>
                    <div class="input-container w--50 m--b--1">
                        <input id="query" name="keywords" type="text" placeholder="(Ex: Permafrost, Rock Glacier, FFT, ...)">
                        <img src="" alt="">
                    </div>

                    <button id="activate-loadscreen" class="inner-border" onclick="event.preventDefault(); activateLoadscreen(); query_repository()">Search</button>
                </form>
            </section>

            <aside class="w--50 pos--rel z--0">
                <div class="img-wrap">
                    <img src="public/img/sem-search.jpg" />
                </div>
            </aside>

            <?php include_once('components/loadscreen.php') ?>

            <!-- Sem-search results -->
            <div id="sem-search-wrapper" class="pos--abs bg--pale h--full p--t--10 t--0 r--0 w--screen--50 z--1 flex--col flex--justify-start flex--align-center" hidden="hidden">
                <div id="sem-search-results" class="w--80 p--x--1 scrollable scrollable--y h--65 pos--rel"></div>
            </div>
        </main>

        <?php include('components/footer.php') ?>
        <?php include('components/transitions.php') ?>
        <?php include('components/scripts.php') ?>

        <script src="public/js/functions/appendElement.js"></script>
        <script src="public/js/pages/sem-search.js"></script> 
        <script src="public/js/FctsAllegro.js"></script>
        <script src="public/js/components/loadscreen.js"></script>

    </body>
</html>