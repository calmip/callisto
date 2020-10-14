#! /usr/bin/python3
  
#
# This file is part of Callisto software
# Callisto helps scientists to share data between collaborators
# 
# Callisto is free software: you can redistribute it and/or modify
# it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
#  Copyright (C) 2015-2021    C A L M I P
#  callisto is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU AFFERO GENERAL PUBLIC LICENSE for more details.
#
#  You should have received a copy of the GNU AFFERO GENERAL PUBLIC LICENSE
#  along with Callisto.  If not, see <http://www.gnu.org/licenses/agpl-3.0.txt>.
#
#  Authors:
#        Thierry Louge      - C.N.R.S. - UMS 3667 - CALMIP
#        Emmanuel Courcelle - C.N.R.S. - UMS 3667 - CALMIP
#

import os
import json
import time
from rdflib import Graph, URIRef, Literal
from rdflib import Namespace
from rdflib.namespace import OWL, RDF, RDFS
import logging as log
from franz.openrdf.sail.allegrographserver import AllegroGraphServer
from franz.openrdf.repository.repository import Repository
from franz.openrdf.vocabulary import RDF
from franz.openrdf.query.query import QueryLanguage
import sys

class RegisterPaper(object):
    """
    """

    def update_ontology(self):
        """
        Met à jour l'ontologie 
        :return:
        Ontologie mise à jour
        """
        mp = Namespace("http://purl.org/mp/")
        prov = Namespace("http://www.w3.org/ns/prov#")
        arcas = Namespace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#")
        myont = Namespace("http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#")
        print('Repository contains %d statement(s).' % self.conn.size())

        timer = str(time.time())
        svc = timer
        profile_id = svc + "_Profile"
        short_url = timer + "_url"
        
        #qualif_by = self.conn.createURI("<http://purl.org/mp/qualifiedBy>")
        qualif_by = URIRef(mp.qualifiedBy)
        supports = URIRef(mp.supports)
        supported = URIRef(mp.supportedBy)
        argues = URIRef(mp.argues)
        argued = URIRef(mp.arguedBy)

        attribution = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#A_P" + timer +">")
        ref = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#ref" + timer +">")
        self.conn.add(attribution, RDF.TYPE, URIRef(prov.Attribution))
        self.conn.add(ref, RDF.TYPE, URIRef(mp.Reference))
        self.conn.add(attribution, "<http://purl.org/mp/qualifiedBy>", ref)
        #"biblio","url","claim1&claim2...&claimn","qual1&qual2...&qualn"
        biblio = sys.argv[1]
        self.conn.add(ref, "<http://purl.org/mp/citation>", biblio)
        url = sys.argv[2]
        qualifiers = sys.argv[4].split("&")
        claims = sys.argv[3].split("&")
        for claim in claims:
            print("claim: " + claim)
            timer = str(time.time())
            cl = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#claim" + timer +">")
            self.conn.add(cl,  "<http://purl.org/mp/statement>", claim)
            self.conn.add(cl,  "<http://purl.org/mp/supports>", ref)
            for qualifier in qualifiers:
                #qualifier_cal = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#qual" + timer +">")
                self.conn.add(cl, "<http://purl.org/mp/qualifiedBy>", "http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#"+qualifier)
                #self.conn.add("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#"+qualifier+">","<http://purl.org/mp/qualifies>",cl)
        
        # AccessURL:
        timer = str(time.time())
        data_url = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#url" + timer +">")
        self.conn.add(data_url, RDF.TYPE, URIRef(arcas.accessURL))
        self.conn.add(data_url, "<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(url))
        self.conn.add(ref,"<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#isAccessedThrough>",data_url)
        
        print('Repository contains %d statement(s).' % self.conn.size())

    def open_connection(self,repo):
        server=AllegroGraphServer(host=self.host,port=self.port,user=self.user,password=self.password)
        catalog = server.openCatalog('')
        mode = Repository.OPEN
        repository = catalog.getRepository(repo, mode)
        conn = repository.getConnection()
        return [repository,conn]

    def close_connection(self):
        self.conn.close()
        self.repo.shutDown()

    def __init__(self):
        """
        use: [list of inputs(uris) [quantity format unit]] [[list of outputs(URIs) [quantity format unit]] ["description" "url" "driver name" [operations by uris]]
        """
        os.system("rm register_service.log")
        log.basicConfig(filename='register_service.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.host = "192.168.0.80"
        self.port = 10035
        self.user = "callisto"
        self.password = "ouiouioui123"
        #repo = "demonstration"
        repo = "sms"
        connected = self.open_connection(repo)
        self.repo = connected[0]
        self.conn = connected[1]
        for elt in sys.argv:
            print(elt)
update = RegisterPaper()
update.update_ontology()

#Exemple of use: python3.6 ./RegisterPublication.py "biblio" "url" "claim1&claim2...&claimn" "qual1&qual2...&qualn"

#Exemple of use: python3.6 ./RegisterPublication.py "Marouf, A., Tekap, Y. B., Simiriotis, N., Tô, J. B., Rouchon, J. F., Hoarau, Y., & Braza, M. (2019). Numerical investigation of frequency-amplitude effects of dynamic morphing for a high-lift configuration at high Reynolds number. International Journal of Numerical Methods for Heat & Fluid Flow." "http://callisto.calmip.univ-toulouse.fr/article1.pdf" "The dynamic morphing improves the aerodynamic lift compared to the classical static system through a vortex breakdown of largest coherent structures and enhancement of good vortices." "PSD&NSMB_SMS&dynamicMorphing"
