<?php 
    require_once('plugins/Mobile_Detect.php');
    $detect = new Mobile_Detect();
    if ($detect->isMobile() || $detect->isTablet()) {
        header('Location: mobile.php');
        exit();
    }