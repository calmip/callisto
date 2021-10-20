<?php
/*
 *
 * This file is part of Callisto software
 * Callisto helps scientists to share data between collaborators
 * 
 * Callisto is free software: you can redistribute it and/or modify
 * it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 *  Copyright (C) 2019-2021    C A L M I P
 *  callisto is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 *  You should have received a copy of the GNU AFFERO GENERAL PUBLIC LICENSE
 *  along with Callisto.  If not, see <http://www.gnu.org/licenses/agpl-3.0.txt>.
 *
 *  Authors:
 *        Thierry Louge      - C.N.R.S. - UMS 3667 - CALMIP
 *        Emmanuel Courcelle - C.N.R.S. - UMS 3667 - CALMIP
 *
 */
include('php/mobileDetect.php');
include('components/head.php');
include_once('components/vars.php');
?>
 <body>
    <?php include('components/header.php'); ?>
    <main>
      <section class="bg flex flex--align-start flex--justify-center rounded">
        
      <iframe style="border: 0" class="m--t--10 fullscreen" sandbox="allow-scripts allow-forms allow-modals allow-popups allow-same-origin allow-downloads" src='https://dataverse.<?php echo "$callisto_name.$callisto_topdomainname" ?>/shib.xhtml'></iframe> 
      </section>
        
    </main>
  
      <?php include('components/footer.php') ?>
      <?php include('components/transitions.php') ?>
      <?php include('components/scripts.php') ?>
  </body>
</html>

