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

class RegisterService(object):
    """
    """

    def update_ontology(self):
        """
        Met à jour l'ontologie 
        :return:
        Ontologie mise à jour
        """
        service = Namespace("http://www.daml.org/services/owl-s/1.2/Service.owl#")
        profile = Namespace("http://www.daml.org/services/owl-s/1.2/Profile.owl#")
        arcas = Namespace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#")
        myont = Namespace("http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#")
        edam = Namespace("http://edamontology.org/")
        print('Repository contains %d statement(s).' % self.conn.size())

        timer = str(time.time())
        svc = timer
        print("registering service:"+str(svc))
        profile_id = svc + "_Profile"
        short_url = timer + "_url"
        
        presents = self.conn.createURI(URIRef(service.presents))
        hasoperation = self.conn.createURI(URIRef(arcas.hasOperation))
        hasQuerySoftware = self.conn.createURI(URIRef(arcas.hasQuerySoftware))
        hasOutput = self.conn.createURI(URIRef(arcas.hasOutput))
        hasInput =  self.conn.createURI(URIRef(profile.hasInput))
        isCombinedToParam =  self.conn.createURI(URIRef(arcas.isCombinedToParam))
        isCombinedToFormat =  self.conn.createURI(URIRef(arcas.isCombinedToFormat))
        isCombinedToUnit =  self.conn.createURI(URIRef(arcas.isCombinedToUnit))
    
        
        labels = self.conn.createURI("<http://www.w3.org/2000/01/rdf-schema#label>")
        isDefined = self.conn.createURI("<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>")
        servi = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#"+ svc+">")
        profile = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + profile_id+">")
        data_tim = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + timer+">")
        data_url = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + short_url+">")
        
        self.conn.add(servi, RDF.TYPE, URIRef(service.Service))
        self.conn.add(profile, RDF.TYPE, URIRef(service.ServiceProfile))
        self.conn.add(data_tim,RDF.TYPE, URIRef(arcas.MeasuredQuantity))
        
        self.conn.add(servi, presents, profile)
        print("service name:"+"<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + timer+">")
        general =  sys.argv[3].split(",")
        print("general: "+str(general))
        description = general[0]
        timer = str(time.time())
        data_url = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" +timer +">")
        soft = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + general[2]+">")
        operations = general[3].split("&")
        labelsoft = general[4]
        labeldef = general[4]
        
        # AccessURL:
        self.conn.add(data_url, RDF.TYPE, URIRef(arcas.accessURL))
        self.conn.add(data_url, "<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(general[1]))
        self.conn.add(servi,"<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#isAccessedThrough>",data_url)
        self.conn.add(profile,"<http://www.daml.org/services/owl-s/1.2/Profile.owl#textDescription>", Literal(description))
        self.conn.add(profile, hasQuerySoftware, soft)
        self.conn.add(soft,"<http://www.w3.org/2000/01/rdf-schema#label>",Literal(general[2]))
        self.conn.add(servi,"<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(description))
        
        #for op in operations:
        #    print("operation: "+ op)
        #    if "operation_" not in op:
        #        self.conn.add(servi, hasoperation,("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#"+ op +">"))
        #    else:
        #        ope = self.conn.createURI(op)
        #        self.conn.add(servi, hasoperation, ope)
        
        general_input =  sys.argv[1].split("|")
        for genin in general_input:
            print("genin: "+genin)
            details = genin.split(",")
            print ("input details:"+str(details)+" with len:"+str(len(details)))
            if (len(details) == 1):
                continue
            timer = str(time.time())
            aggregate = timer + "_agg"
            agg = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + aggregate+">")
            self.conn.add(agg, RDF.TYPE, URIRef(arcas.Aggregate))
            self.conn.add(servi, hasInput, agg)
            try:
                quantity = details[0]
                q = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + quantity +">")
                self.conn.add(agg,isCombinedToParam, q)
                form = details[1]
                f = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + form +">")
                self.conn.add(agg, isCombinedToFormat, f)
                unit = details[2]
                u = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#"+unit+">")
                self.conn.add(agg, isCombinedToUnit, u)
            except:
                pass
            
        general_output = sys.argv[2].split("|")
        for genout in general_output:
            details = genout.split(",")
            if (len(details) == 1):
                continue
            timer = str(time.time())
            aggregate = timer + "_agg"
            agg = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + aggregate+">")
            self.conn.add(agg, RDF.TYPE, URIRef(arcas.Aggregate))
            self.conn.add(servi, hasOutput, agg)
            try:
                quantity = details[0]
                q = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + quantity +">")
                self.conn.add(agg,isCombinedToParam, q)
                self.conn.add(q,isDefined,Literal(labeldef))
                form = details[1]
                f = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#" + form +">")
                self.conn.add(agg, isCombinedToFormat, f)
                unit = details[2]
                u = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/SMS.rdf#"+unit+">")
                self.conn.add(agg, isCombinedToUnit, u)
                
            except:
                pass
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
        use: CSV inputs(uris) quantity,format,unit CSV of outputs(URIs) quantity,format,unit "description","url","driver name" [operations by uris]]
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
update = RegisterService()
update.update_ontology()


#Operation plotting: <http://edamontology.org/operation_3441>
#python3.6 /home/callisto/UTILS/RegisterService2.py Signal,CSV,UNITLESS\| PSD,CSV,UNITLESS\| "This service calculates the Power Spectral Density (PSD) using the Periodogram  method","http://callisto.calmip.univ-toulouse.fr/cgi-bin/","psd_periodogram.py","PSD_PERIO","PSD Periodogram calculation"
