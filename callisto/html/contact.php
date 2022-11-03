<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>

    <body>

        <?php include('components/header.php') ?>

        <main>

            <section class="bg pos--rel flex flex--justify-start flex--justify-between p--viewport p--b--2">

                <form action="components/contactForm.php" class="m--t--10 flex flex--col flex__even-object" method="POST">
                    <h2 class="m--b--1">Contact us</h2>

                    <label for="first">First Name</label>
                    <div class="input-container m--b--1">
                        <input type="text" placeholder="John" id="first" name="first">    
                    </div>

                    <label for="last">Last Name</label>
                    <div class="input-container m--b--1">
                        <input type="text" placeholder="Doe" id="last" name="last">      
                    </div>

                    <label for="email">Email address</label>
                    <div class="input-container m--b--1">
                        <input type="text" placeholder="johndoe@example.com" id="email" name="email">    
                    </div>

                    <label for="message">Your message here</label>
                    <div class="input-container m--b--1">
                        <textarea placeholder="I have a problem regarding..." id="message" name="message"></textarea>   
                    </div>

                    <button type="submit" name="submit">Send</button>
                </form>

                <aside class="m--t--10 flex__even-object m--l--5 flex flex--col flex--center">
                    <img src="public/img/049-choices-colour.svg" class="m--x--4 m--y--1" alt="">
                    <p class="">thierry.louge@toulouse-inp.fr</p>
                    <p class="">05 61 17 12 02</p>
                </aside>

                <span class="faded-bubble primary" id="faded-bubble-1"></span>
                <span class="faded-bubble secondary" id="faded-bubble-2"></span>
            </section>

            

        </main>

        <?php include('components/footer.php') ?>
        
        <?php include('components/transitions.php') ?>

        <?php include('components/scripts.php') ?>

    </body>