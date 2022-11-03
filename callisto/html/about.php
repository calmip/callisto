<?php 
    include('php/mobileDetect.php');
    include('components/head.php');
?>

    <body>

        <?php include('components/header.php') ?>

        <main>
            <section class="bg p--viewport m--0 flex flex--justify--start p--b--5">
                <article class="m--t--10">
                    <h2 class="m--b--1">About</h2>
                    <p class="m--b--2">This section covers the essential data management key concepts that you need to understand to use Callisto. You’ll also find some tools and links to documents that will help you get a better understanding.</p>
		     <h3 class="m--b--1">A use-case</h3>
                    <ul class="m--l--1 m--b--2">
                    <li><a href="https://vod.imft.fr/publish/video/oq44eabbA?fullscreen&lang=fr">A webinar exposing CALLISTO use for sharing scient\
ific data and workflows (in									   French).</a></li>
                    </ul>

                    <h3 class="m--b--1">Data Management Platforms (DMP)</h3>
                    <h4 class="m--b--1">Understanding the FAIR principles</h4>

                    <ul class="m--l--1 m--b--2">
                        <li>The dedicated page of the Zenodo Web site presents a comprehensive overview of the FAIR principles.</li>
                        <li>Opidor is a (french-speaking) tool for managing scientific data, available online.</li>
                        <li>It offers a set of templates for DMPs.</li>
                        <li>It also presents an online interface for writing DMPs (require authentication).</li>
                        <li>A list of data-related services is also provided.</li>
                    </ul>      

                    <h3 class="m--b--1">Data archives and storage</h3>
                    <p class="m--b--2">EOSC is the main web front-end for european open science. It aims at providing a federated access point for many services. https://zenodo.org/ allows the sharing of scientific datasets.</p>

                    <h3 class="m--b--1">Metadata, interoperability and harvesting</h3>
                    <h4 class="m--b--1">Understanding metadata harvesting</h4>
                    <p>The Web site for open archives initiative (OAI) presents the basic concepts of Web content interoperability. It also gives an overview of the metadat harvesting mechanisms, and in-depth description of the OAI protocols and metadata standards that those protocols use for data dissemination. Using Dublin Core metadata (also available as an ontology) is mandatory for using the PMH protocol of OAI.</p>
                    <p class="m--b--1">Interoperability itself, though, is a much broader question than metadata description and repositories harvesting. Before diving in to the details (a little) more, it may be useful to specify two major initiatives, namely OGC and IVOA that built a solid set of standards, protocols and relevant softwares for their scientific communities.</p>

                    <h4 class="m--b--1">For the geospatial community</h4>
                    <ul class="m--l--1 m--b--1">
                        <li>OGC (Open Geospatial Consortium) is dedicated to the definition of standards and protocols for describing and accessing geospatial data.</li>
                        <li>A list of the corresponding products is available on the OGC Web site.</li>
                        <li>A complete application implementing many standards from the OGC is freely downloadable and usable: Its name is GeoServer.</li>
                    </ul>   

                    <h4 class="m--b--1">For astrophysicists</h4>
                    <p class="m--b--2">International Virtual Observatory Alliance (IVOA) provides for astrophysics the same set of functionalities that OGC provides for geospatial data.</p>

                    <h3 class="m--b--1">Interoperability, EIF and Ontologies</h3>
                    <p>Interoperability is a wide area of research, which is not limited to data interoperability but also applies to software, industrial products and processes for example. The European commission adopted in 2017 a framework for interoperability that covers many aspects.</p>
                    <p>In 2006, the role of ontologies in interoperability had already been clearly stated by David Chen (CHEN, David. Enterprise Interoperability Framework. In: EMOI-INTEROP. 2006.) in the framework EIF, that also fits for scientific data. Ontologies play a key role for extracting interoperability needs from services or data, and providing "federated" interoperability (the kind of interoperability that does not need a native modification of the data, neither to conform to a predefinite meta-model).</p>
                    <p>The Open Biological and Biomedical Ontology (OBO) not only provides ontologies for Biological-related domains, but also some high level ontologies suitable for any domain of discourse.</p>
                    <p>Basic Formal Ontology (BFO), SUMO and DOLCE are top-level ontologies that are worth studying before diving into the work of writing an ontology.</p>
                    <p>More comprehensive information about ontologies and vocabularies can be found on the W3C Web site.</p>
                </article>

                <span class="faded-bubble secondary" id="faded-bubble-3"></span>
                <span class="faded-bubble primary" id="faded-bubble-4"></span>
            </section>
        </main>

        <?php include('components/footer.php') ?>
        
        <?php include('components/transitions.php') ?>

        <?php include('components/scripts.php') ?>

    </body>
</html>