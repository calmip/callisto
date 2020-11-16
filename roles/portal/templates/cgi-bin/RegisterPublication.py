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
#  Copyright (C) 2019-2021    C A L M I P
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
import cgi

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
        myont = Namespace("http://{{callisto_name}}.{{callisto_topdomainname}}/SMS.rdf#")
        #print('Repository contains %d statement(s).' % self.conn.size())

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

        attribution = self.conn.createURI("<http://{{callisto_name}}.{{callisto_topdomainname}}/SMS.rdf#A_P" + timer +">")
        ref = self.conn.createURI("<http://{{callisto_name}}.{{callisto_topdomainname}}/SMS.rdf#ref" + timer +">")
        self.conn.add(attribution, RDF.TYPE, URIRef(prov.Attribution))
        self.conn.add(ref, RDF.TYPE, URIRef(mp.Reference))
        self.conn.add(attribution, "<http://purl.org/mp/qualifiedBy>", ref)

        biblio = self.ref
        self.conn.add(ref, "<http://purl.org/mp/citation>", biblio)
        url = self.url
        qualifiers = self.qual.split("|")
        claims = self.claims.split("|")
        
        for claim in claims:
            #print("claim: " + claim)
            timer = str(time.time())
            cl = self.conn.createURI("<http://{{callisto_name}}.{{callisto_topdomainname}}/SMS.rdf#claim" + timer +">")
            self.conn.add(cl,  "<http://purl.org/mp/statement>", claim)
            self.conn.add(cl,  "<http://purl.org/mp/supports>", ref)
            for qualifier in qualifiers:
                #qualifier_cal = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#qual" + timer +">")
                self.conn.add(cl, "<http://purl.org/mp/qualifiedBy>", "{{callisto_name}}.{{callisto_topdomainname}}/SMS.rdf#"+qualifier)
                #self.conn.add("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#"+qualifier+">","<http://purl.org/mp/qualifies>",cl)
        
        # AccessURL:
        timer = str(time.time())
        data_url = self.conn.createURI("<http://{{callisto_name}}.{{callisto_topdomainname}}/SMS.rdf#url" + timer +">")
        self.conn.add(data_url, RDF.TYPE, URIRef(arcas.accessURL))
        self.conn.add(data_url, "<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(url))
        self.conn.add(ref,"<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#isAccessedThrough>",data_url)
        
        #print('Repository contains %d statement(s).' % self.conn.size())

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
    
    def read_config(self):
        config_file = open("cgi_conf.cfg", 'r')
        case = ""
        lines = config_file.readlines()
        for line in lines:
            if "callisto-conf-allegro" in line:
                case = "allegro"
            if "callisto-conf-ontologies" in line:
                case = "ontologies"
            if "callisto-conf-generic" in line:
                case = "generic"
            if "callisto-conf-dataverse" in line:
                case = "dataverse"
            #log.debug("case="+case)
                    
            if "host = " in line and case == "allegro":
                self.host = str(line.split("host = ")[1].replace("\n",""))
                log.debug("host="+str(self.host)+".")
            if "port = " in line and case == "allegro":
                self.port = str(line.split("port = ")[1].replace("\n",""))
                log.debug("port="+str(self.port)+".")
            if "user = " in line and case == "allegro":
                self.user = str(line.split("user = ")[1].replace("\n",""))
                log.debug("user="+str(self.user)+".")
            if "password = " in line and case == "allegro":
                self.password = str(line.split("password = ")[1].replace("\n",""))
                log.debug("password="+str(self.password)+".")

            if "close_enough" in line and case == "generic":
                self.close_enough = float(line.split("close_enough = ")[1].replace("\n",""))
                log.debug("close_enough="+str(self.close_enough)+".")

            if "root_iri = " in line and case == "ontologies":
                self.rootiri = str(line.split("root_iri = ")[1].replace("\n",""))
            if "root_https = " in line and case == "ontologies":
                self.roothttps = str(line.split("root_https = ")[1].replace("\n",""))

            if "host_port = "  in line and case == "dataverse":
                self.dataport = str(line.split("host_port = ")[1].replace("\n",""))
            if "host_url = "  in line and case == "dataverse":
                self.dataurl = str(line.split("host_url = ")[1].replace("\n",""))

    def __init__(self):
        """
        use: [list of inputs(uris) [quantity format unit]] [[list of outputs(URIs) [quantity format unit]] ["description" "url" "driver name" [operations by uris]]
        """
        try:
            os.system("rm /var/log/callisto/register_service.log")
        except:
            pass
        log.basicConfig(filename='/var/log/callisto/register_service.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.read_config()
        self.form = cgi.FieldStorage()
        repo = str(self.form.getvalue("repo"))
        self.claims = str(self.form.getvalue("claim"))
        self.ref = str(self.form.getvalue("ref"))
        self.url = str(self.form.getvalue("url"))
        self.qual = str(self.form.getvalue("qual"))
        connected = self.open_connection(repo)
        self.repo = connected[0]
        self.conn = connected[1]
        for elt in sys.argv:
            print(elt)
update = RegisterPaper()
update.update_ontology()

