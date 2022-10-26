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
import ReadConfig

class RegisterService(object):
    """
    """

    def update_ontology(self):
        """
        Met a jour l'ontologie 
        :return:
        Ontologie mise a jour
        """
        service = Namespace("http://www.daml.org/services/owl-s/1.2/Service.owl#")
        profile = Namespace("http://www.daml.org/services/owl-s/1.2/Profile.owl#")
        arcas = Namespace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#")
        myont = Namespace(self.readconf.rootiri+self.svc_repo_tplt+".rdf#")
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
        servi = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#"+ svc+">")
        profile = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + profile_id+">")
        #data_tim = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + timer+">")
        data_url = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + short_url+">")
        
        self.conn.add(servi, RDF.TYPE, URIRef(service.Service))
        self.conn.add(profile, RDF.TYPE, URIRef(service.ServiceProfile))
        #self.conn.add(data_tim,RDF.TYPE, URIRef(arcas.MeasuredQuantity))
        
        self.conn.add(servi, presents, profile)
        print("service name:"+"<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + timer+">")
        soft = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" +self.svc_script_tplt +">")
        operations = self.svc_opt_tplt.split("&")
        labelsoft = self.svc_script_tplt
        labeldef = self.svc_label_tplt
        
        # AccessURL:
        self.conn.add(data_url, RDF.TYPE, URIRef(arcas.accessURL))
        self.conn.add(data_url, "<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(self.svc_url_tplt))
        self.conn.add(servi,"<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#isAccessedThrough>",data_url)
        self.conn.add(profile,"<http://www.daml.org/services/owl-s/1.2/Profile.owl#textDescription>", Literal(self.svc_desc_tplt))
        self.conn.add(profile, hasQuerySoftware, soft)
        self.conn.add(soft,labels,Literal(labelsoft))
        #self.conn.add(servi,"<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(self.svc_desc_tplt))
        
        timer = str(time.time())
        aggregate = timer + "_agg"
        agg = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + aggregate+">")
        self.conn.add(agg, RDF.TYPE, URIRef(arcas.Aggregate))
        self.conn.add(servi, hasInput, agg)
        quantity = self.svc_input
        print("input:"+quantity)
        if "http" in quantity:
            #La quantite exprimee est decrite dans un vocabulaire importe
            q = self.conn.createURI(quantity.replace(" ", ""))
        else:
            #La quantite exprimee vient d'ARCADIE
            q = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + quantity +">")
        self.conn.add(agg,isCombinedToParam, q)
        form = self.svc_input_format
        f = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + form +">")
        self.conn.add(agg, isCombinedToFormat, f)
        unit = self.svc_input_unit
        if unit != "UNITLESS":
            u = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#"+unit+">")
            self.conn.add(agg, isCombinedToUnit, u)
        else:
            self.conn.add(agg, isCombinedToUnit, "http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#unitless")
   
        timer = str(time.time())
        aggregate = timer + "_agg"
        agg = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + aggregate+">")
        self.conn.add(agg, RDF.TYPE, URIRef(arcas.Aggregate))
        self.conn.add(servi, hasOutput, agg)
        print ("svc output"+self.svc_output)
        quantity = self.svc_output
        print("Q: "+str(q))
        print("Quantity: "+str(quantity))
        if "http" in quantity:
            #La quantite exprimee est decrite dans un vocabulaire importe
            q = self.conn.createURI(quantity.replace(" ", ""))
        else:
            #La quantite exprimee vient d'ARCADIE
            q = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + quantity +">")
            self.conn.add(q,isDefined,Literal(quantity))
        print("New Q: "+str(q))
        self.conn.add(agg,isCombinedToParam, q)
        form = self.svc_output_format
        f = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#" + form +">")
        self.conn.add(agg, isCombinedToFormat, f)
        unit = self.svc_output_unit
        if unit != "UNITLESS":
            u = self.conn.createURI("<"+self.readconf.rootiri+self.svc_repo_tplt+".rdf#"+unit+">")
            self.conn.add(agg, isCombinedToUnit, u)
        else:
            self.conn.add(agg, isCombinedToUnit, "http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#unitless")
        #self.conn.add(agg, isCombinedToUnit, u)
        print('Repository contains %d statement(s).' % self.conn.size())

    def open_connection(self):
        server=AllegroGraphServer(host=self.readconf.host,port=self.readconf.port,user=self.readconf.user,password=self.readconf.password)
        catalog = server.openCatalog('')
        mode = Repository.OPEN
        print("repository:"+self.svc_repo_tplt)
        repository = catalog.getRepository(self.svc_repo_tplt.lower(), mode)
        conn = repository.getConnection()
        return [repository,conn]

    def close_connection(self):
        self.conn.close()
        self.repo.shutDown()

    def read_template(self,config):
        print("Entree dans read_template:"+config)
        config_file = open(config, 'r')
        case = ""
        lines = config_file.readlines()
        for line in lines:
            if "input:" in line:
                case = "input"
            if "output:" in line:
                case = "output"
            if "service name =" in line:
                self.svc_name_tplt = str(line.split("service name = ")[1].replace("\n","")).toupper()
                log.debug("Service name:"+str(self.svc_name_tplt)+".")
            if "name =" in line:
                if case == "input":
                    self.svc_input = str(line.split("name = ")[1].replace("\n",""))
                    log.debug("input name:"+str(self.svc_input)+".")
                if case == "output":
                    self.svc_output = str(line.split("name = ")[1].replace("\n",""))
                    log.debug("output name:"+str(self.svc_output)+".")
                    print("output name:"+str(self.svc_output)+".")
            if "format =" in line:
                if case == "input":
                    self.svc_input_format = str(line.split("format = ")[1].replace("\n",""))
                    log.debug("input format:"+str(self.svc_input_format)+".")
                if case == "output":
                    self.svc_output_format = str(line.split("format = ")[1].replace("\n",""))
                    log.debug("output format:"+str(self.svc_output_format)+".")
            if "unit =" in line:
                if case == "input":
                    self.svc_input_unit = str(line.split("unit = ")[1].replace("\n",""))
                    log.debug("input unit:"+str(self.svc_input_unit)+".")
                if case == "output":
                    self.svc_output_unit = str(line.split("unit = ")[1].replace("\n",""))
                    log.debug("output unit:"+str(self.svc_output_unit)+".")
            if "description =" in line:
                self.svc_desc_tplt = str(line.split("description = ")[1].replace("\n",""))
                log.debug("Service description:"+str(self.svc_desc_tplt)+".")
            if "base url =" in line:
                self.svc_url_tplt = str(line.split("base url = ")[1].replace("\n",""))
                log.debug("Service url:"+str(self.svc_url_tplt)+".")
            if "scriptfile =" in line:
                self.svc_script_tplt = str(line.split("scriptfile = ")[1].replace("\n",""))
                log.debug("Service script name:"+str(self.svc_script_tplt)+".")
            if "label = " in line:
                self.svc_label_tplt = str(line.split("label = ")[1].replace("\n",""))
                log.debug("Service label:"+str(self.svc_label_tplt)+".")
            if "repository =" in line:
                self.svc_repo_tplt = str(line.split("repository = ")[1].replace("\n",""))
                log.debug("Service repository:"+str(self.svc_repo_tplt)+".")
            if "operations =" in line:
                self.svc_opt_tplt = str(line.split("operations =")[1].replace("\n",""))
                log.debug("Service operations:"+str(self.svc_opt_tplt)+".")
            if "resultfile =" in line:
                self.svc_result_tplt = str(line.split("resultfile =")[1].replace("\n",""))
                log.debug("Service results:"+str(self.svc_result_tplt)+".")

    def generate_skeleton(self):
        os.system("rm -f ../cgi-bin/"+self.svc_script_tplt)
        skel_file = open('skeleton.py', 'r')
        res_file = open('scriptfile.py','w')
        script = open(self.svc_script_tplt,'r')
        lines = skel_file.readlines()
        for line in lines:
            if "MyNewTerm" in line:
                if "#" in self.svc_input:
                    line = line.replace("MyNewTerm",self.svc_input.split("#")[1])
                elif "/" in self.svc_input:
                    line = line.replace("MyNewTerm",self.svc_input.split("/")[len(self.svc_input.split("/")) - 1])
                else:
                    line = line.replace("MyNewTerm",self.svc_input)
            if "... your script will be put here ..." in line:
                res_file.write("# ------- Beginning of your script. You may change things from here\n")
                for line_script in script.readlines():
                    res_file.write(line_script)
                res_file.write("# ------- Ending of your script. You should not change things after this line\n")
                continue
            if "myresult" in line:
                line = line.replace("myresult",self.svc_result_tplt.rstrip(" ").lstrip(" "))
            res_file.write(line)
        res_file.close()
        skel_file.close()
        script.close()
        os.system("mv ./scriptfile.py ../cgi-bin/"+self.svc_script_tplt)
        os.system("chmod 755 ../cgi-bin/"+self.svc_script_tplt) 

    def __init__(self):
        """
        use: CSV inputs(uris) quantity,format,unit CSV of outputs(URIs) quantity,format,unit "description","url","driver name" [operations by uris]]
        """
        os.system("rm ../logs/register_service.log")
        log.basicConfig(filename='../logs/register_service.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.readconf = ReadConfig.ReadConfig()
        for elt in sys.argv:
            print(elt)
        self.read_template(sys.argv[1])
        if sys.argv[2] == "generate":
            self.generate_skeleton()
        if sys.argv[2] == "register":
            connected = self.open_connection()
            self.repo = connected[0]
            self.conn = connected[1]
            self.update_ontology()
update = RegisterService()

#Exemple: python3 ./RegisterService.py ExempleService1.template generate
#Exemple: python3 ./RegisterService.py ExempleService1.template register
