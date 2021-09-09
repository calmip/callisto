<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>

    <body>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

        <?php include('components/header.php') ?>

        <main>

            <section class="bg p--viewport p--t--10 p--b--5">
            
                <article class="rounded p--5 inner-border bg--light shadow">
                    <form action="" class="flex flex--col">
                    
                        <h2 class="text--center m--b--2">New bibliographic reference</h2>

                        <label for="repository" class="m--t--2">Select a repository</label>
                        <select name="repository" class="w--100 m--b--2" id="repository" onchange="Change_repository(); changeRepoSearchLinks()">
                            <option value="demonstration">Demonstration</option>
                            <option value="sms">Smart Morphing and Sensing (SMS)</option>
                        </select>

                        <div class="flex flex--col m--b--2">
                            <div class="flex flex--justify-between w--full m--b--1">
                                <div class="flex flex--col w--50">
                                    <label for="abr-allegro-uid">Allegro ontology username</label>
                                    <div class="input-container m--r--1">
                                        <input type="text" placeholder="Username" id="abr-allegro-uid" class="abr-required">
                                    </div>
                                </div>
                                <div class="flex flex--col w--50">   
                                    <label for="abr-allegro-pwd" class="m--l--1">Allegro ontology password</label>
                                    <div class="input-container m--l--1">
                                        <input type="password" placeholder="Password" id="abr-allegro-pwd" class="abr-required">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <label for="abr-first-name" class="m--t--2">Add author(s)</label>
                        <div class="flex flex--col" id="abr-authors">
                            <div class="flex flex--justify-between w--full m--b--1">
                                <div class="input-container w--50 m--r--1">
                                    <input type="text" placeholder="First name" class="abr-first-name abr-required" id="abr-first-name">
                                </div>
                                <div class="input-container w--50 m--l--1">
                                    <input type="text" placeholder="Last name" class="abr-last-name abr-required">
                                </div>
                            </div>
                        </div>
                        <button class="m--b--2 w--full inner-border bg--primary bg--img--none" onclick="addAuthor()">Add another author</button>

                        <label for="abr-title">Add a title</label>
                        <div class="input-container m--b--2">
                            <input type="text" placeholder="Document's title goes here" id="abr-title">
                        </div>

                        <label for="abr-claim">Add claim(s)</label>
                        <p class="text--small m--b--1">Insert factual and concrete statements disclosed in the provided document</p>
                        <div class="flex flex--col" id="abr-claims">    
                            <div class="input-container m--b--1">
                                <textarea type="text" class="abr-required" placeholder="Example: Only about half of the universe’s expected amount of ordinary matter has ever been cataloged." class="abr-claim" id="abr-claim"></textarea>
                            </div>
                        </div>
                        <button class="m--b--2 w--full inner-border bg--primary bg--img--none" onclick="addClaim()">Add another claim</button>

                        <div class="flex flex--justify-between">
                            <label for="abr-link">Downloadable PDF link</label>
                            <span class="text--small">Optional</span>
                        </div>
                        <div class="input-container m--b--2">
                            <input type="text" placeholder="Your URL goes here" id="abr-link">
                        </div>

                        <hr>

                        <label for="abr-concept" class="m--t--2">Which ontology concepts are related to this reference?</label>
                        <div class="flex flex--col" id="abr-concepts">
                            <div class="input-container m--b--1">
                                <input type="text" placeholder="(Example: Dynamic morphing)" class="abr-concept abr-required" id="abr-concept">
                            </div>
                        </div>
                        
                        <button class="w--full m--b--1 inner-border bg--primary bg--img--none" onclick="addConcept()">Add another ontology reference</button>

                        <div class="flex m--b--2">
                            <a href="https://allegro.callisto.calmip.univ-toulouse.fr/#/repositories/demonstration/gruff" target="_BLANK" id="abr-manual-search">Graphic ontology search</a>
                            <a href="https://allegro.callisto.calmip.univ-toulouse.fr/#/repositories/demonstration" target="_BLANK" id="abr-advanced-search" class="m--l--1">Advanced ontology browse</a>
                        </div>
                    
                        <hr>

                        <button class="w--full inner-border p--y--2 m--t--2" onclick="Register_publication()">Add</button>

                    </form>
                </article>
            </section>
        </main>

        <?php include('components/footer.php') ?>
        <?php include('components/transitions.php') ?>
        <?php include('components/scripts.php') ?>

        <script src="public/js/functions/appendElement.js"></script>
        <script src="public/js/pages/abr.js"></script>
        <script src="public/js/FctsAllegro.js"></script>

    </body>