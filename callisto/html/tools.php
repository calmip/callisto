<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>

    <body>

        <?php include('components/header.php') ?>

        <main>
            <section class="bg p--viewport m--0 flex flex--align-start p--b--4">
                <article class="card p--5 m--t--10 flex flex--col flex--align-center inner-border">
                    <h2 class="text--center text--light">Tools</h2>
                    <div class="flex m--t--2 pos--rel">
                        <div class="m--r--3 flex__even-object">
                            <p class="text--light">SADA, which stands for "Semi-automatic data analysis" helps you to find useful operations to process the data you're searching.</p>
                            <a href="sada.php" onclick="event.preventDefault(); changePage(this);">
                                <button class="btn--block m--t--1 inner-border">SADA</button>
                            </a>
                        </div>

                        <span class="line bg--light pos--abs rounded"></span>
                        
                        <div class="m--l--3 flex__even-object">
                            <p class="text--light">Sem-search, which stands for "Semantic search", enables you to find information such as bibliographic claims or specific data operations.</p>
                            <a href="sem-search.php"  onclick="event.preventDefault(); changePage(this);">
                                <button class="btn--block m--t--1 inner-border">Sem-search</button>
                            </a>
                        </div>
                    </div>

                    <a href="abr.php" class="m--t--2 flex flex--center abr-link p--1 bg--light rounded text--no-decoration" onclick="event.preventDefault(); changePage(this);">
                        <img src="public/img/circle-plus.svg" class="m--r--05" alt="Plus">
                        <b>Add a bibliographic reference</b>
                    </a>
                </article>
            </section>
        </main>

        <?php include('components/footer.php') ?>

        <?php include('components/transitions.php') ?>

        <?php include('components/scripts.php') ?>
        
        <script src="public/js/components/header.js" type="text/javascript"></script>

    </body>
</html>
