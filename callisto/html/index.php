<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>

    <body>

        <?php include('components/header.php') ?>

        <main class="p--b--5">
            <section class="bg p--viewport m--0 flex flex--center pos--rel">
                <article class="flex flex--align-between m--t--5">
                    <div class="flex__even-object m--r--4">
                        <h1 class="text--primary">Share, discover and analyze data easily</h1>
                        <p class="m--t--1">We allow researchers to share, find and use scientific data and data-driven analysis services.</p>
                        <a href="#section-2">
                            <button class="inner-border btn--big m--t--2">Discover</button>
                        </a>
                    </div>
                    <figure class="flex__even-object" id="particles-js"></figure>
                    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js" type="text/javascript"></script>
                </article>


            </section>

            <span class="anchor anchor--start" id="section-2"></span>
            <section class="bg--inverted p--viewport m--0 pos--rel">
                <article>
                    <h3 class="text--center">Our goal is to provide a <span class="text--primary">fair</span> data management to our users:</h3>
                    <figure class="fair-container flex flex--justify-between m--t--3">
                        <!-- FAIR circles -->
                        <div>
                            <div class="circle flex flex--center">
                                <img src="public/img/bx-search-alt.svg" alt="Magnifying glass">
                            </div>
                            <h5 class="text--center m--t--1"><span class="text--primary">F</span>indable</h5>
                        </div>

                        <span class="line bg--primary"></span>

                        <div>
                            <div class="circle flex flex--center">
                                <img src="public/img/universal-access.svg" alt="Human form">
                            </div>
                            <h5 class="text--center m--t--1"><span class="text--primary">A</span>ccesible</h5>
                        </div>

                        <span class="line bg--primary"></span>

                        <div>
                            <div class="circle flex flex--center">
                                <img src="public/img/network-4.svg" alt="Network">
                            </div>
                            <h5 class="text--center m--t--1"><span class="text--primary">I</span>nteroperable</h5>
                        </div>

                        <span class="line bg--primary"></span>

                        <div>
                            <div class="circle flex flex--center">
                                <img src="public/img/sharp-gpp-good.svg" alt="Shield with check inside">
                            </div>
                            <h5 class="text--center m--t--1"><span class="text--primary">R</span>eusable</h5>
                        </div>
                        <!-- FAIR line -->
                        
                    </figure>
                </article>

                <article class="m--t--10 card p--4">
                    <h3 class="text-tertiary text--light text--center">Here's what you can do</h3>
                    <div class="m--t--2 flex flex--justify-between pos--rel">
                        <div class="flex__even-object m--r--3">
                            <div class="flex flex--center">
                                <img src="public/img/globe-search-24-regular.svg" class="icon--title m--r--1" alt="Magnifying glass over globe">
                                <h4 class="text-gradient--1">Tools</h4>
                            </div>  
                            <p class="text--light m--y--1">Use the embedded tools to discover data and software. Just type the info that you need and we’ll guide you.</p>
                            <a href="tools.php" class="text--no-decoration"  onclick="event.preventDefault(); changePage(this);">
                                <button class="inner-border m--x--auto d--block">Use tools</button>
                            </a>
                        </div>

                        <!-- Middle line -->
                        <span class="line bg--light pos--abs rounded"></span>

                        <div class="flex__even-object m--l--3">
                            <div class="flex flex--center">
                                <img src="public/img/bx-share-alt.svg" class="icon--title m--r--1" alt="Connected dots">
                                <h4 class="text-gradient--1">Collaborate</h4>
                            </div>  
                            <p class="text--light m--y--1">Use Callisto's DataVerse to share data and contribute to the scientific community.</p>
                            <a href="index-dataverse.php" class="text--no-decoration"  onclick="event.preventDefault(); changePage(this);">
                                <button class="inner-border m--x--auto d--block">Begin</button>
                            </a>
                            <p class="text--muted text--center m--t--1">Using this feature requires a minimum understanding on how Callisto uses ontologies. To learn more, <a href="about.php" onclick="event.preventDefault(); changePage(this)">click here.</a></p>
                        </div>
                    </div>
                </article>


                <span class="faded-bubble secondary" id="faded-bubble-3"></span>
                <span class="faded-bubble primary" id="faded-bubble-4"></span>
            </section>
        </main>

        <?php include('components/footer.php') ?>

        <?php include('components/transitions.php') ?>

        <?php include('components/scripts.php') ?>


        <script src="public/js/pages/index.js" type="text/javascript"></script>

    </body>
</html>