<?php 
    include('php/desktopDetect.php');
    include('components/head.php');
?>

    <body>
        <main>
            <figure class="flex__even-object pos--fixed fullscreen" id="particles-js"></figure>
            <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js" type="text/javascript"></script>
            <script>
                particlesJS.load('particles-js', 'particles/mobile.json', null);
            </script>
            <span class="overlay-light pos--fixed fullscreen"></span>

            <section class="flex flex--col flex--center p--x--2">
                <article class="flex flex--col flex--center">
                    <h2 class="text--primary m--b--1">Callisto</h2>
                    <p class="text--center">To access Callisto's features, you must be connected on a computer.</p>
                </article>
            </section>
        </main>
    </body>