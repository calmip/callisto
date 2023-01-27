<?php include_once("vars.php");  ?>

<header class="flex flex--align-center flex--justify-between inner-border p--viewport p--y--2">
    <a href="index.php"  onclick="event.preventDefault(); changePage(this);" class="flex flex--center">
        <img src="public/img/calmip.png" alt="Calmip's Logo">
        <h2 class="text--primary m--l--1">Callisto</h2>
    </a>
    <a href="https://www.calmip.univ-toulouse.fr/" target="_blank" class="flex flex--center">
	<h5 class="text--primary m--l--1">Proposed by</h5>
    	<img src="public/img/my_logo.png" alt="My logo">
	<h6 class="text--primary m--l--1">v 1.2</h6>
    </a>
    <nav>
        <ul class="flex">
            <li class="flex flex--col flex--align-center flex--justify-start unselectable">
                <a href="index.php" onclick="event.preventDefault(); changePage(this);">Home</a>
                <span class="circle bg--primary inactive"></span>
            </li>
            <li class="flex flex--col flex--align-center flex--justify-start unselectable">
                <a href="tools.php" onclick="event.preventDefault(); changePage(this);">Tools</a>
                <span class="circle bg--primary inactive"></span>
            </li>
            <li class="flex flex--col flex--align-center flex--justify-start unselectable">
	    <a href="<?php echo $callisto_living_on==="laptop" ? 'index-dataverse.php' : '/Shibboleth.sso/Login?target=/index-dataverse.php' ?>" onclick="event.preventDefault(); changePage(this);">Deposit</a>
                <span class="circle bg--primary inactive"></span>
            </li>
            <li class="flex flex--col flex--align-center flex--justify-start unselectable">
                <a href="about.php" onclick="event.preventDefault(); changePage(this);">About</a>
                <span class="circle bg--primary inactive"></span>
            </li>
            <li class="flex flex--col flex--align-center flex--justify-start unselectable">
                <a href="contact.php" onclick="event.preventDefault(); changePage(this);">Contact</a>
                <span class="circle bg--primary inactive"></span>
            </li> 
        </ul>
        
    </nav>
</header>
 
