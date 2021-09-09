<?php

if (isset($_POST['submit'])) {
    $name = $_POST['first'].' '.$_POST['last'];
    $email = $_POST['email'];
    $message = $_POST['message'];
    $mailTo = 'thierry.louge@toulouse-inp.fr';
    $header = 'New message from CALLISTO contact';
    $txt = 'Message from '.$name.'('.$email.')\n\n'.$message;
    
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        header('Location: ../contact.php?message=bad_email');
        exit;
    }

    mail($mailTo, $header, $txt, $header);

    header('Location: ../contact.php?message=sent');
    exit;
}