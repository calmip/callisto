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
import rdflib
from rdflib import Graph, URIRef, Literal
from rdflib import Namespace
from rdflib.namespace import OWL, RDF, RDFS
import logging as log
from franz.openrdf.sail.allegrographserver import AllegroGraphServer
from franz.openrdf.repository.repository import Repository
from franz.openrdf.vocabulary import RDF
from franz.openrdf.query.query import QueryLanguage
import subprocess

class DatasetsToOntology(object):
    """
    """
    def get_details(self):
        """
        Recupere et analyse le json du contenu des dataverses.
        Pour bien voir la structure d'un fichier, chaine ou url
        contenant du json: https://jsoneditoronline.org/
        :return:
        liste de listes de 4 elements comprenant: id, titre, description, et liste de sujets lies au dataset
        prototype de chaque liste: [string, string, string, [string,...,string]]
        """
        #API_TOKEN = "e0967c6e-4679-4c4b-b74f-4e165bd6866c"
        API_TOKEN = "9ec41056-85e6-461d-925f-d29fde9cb6e1"
        API_TOKEN = "cb606579-8270-4c3b-a970-43340189499d"
        API_TOKEN = "bea7b84d-3a41-4282-aac0-3a7593271b71"
        API_TOKEN = "a8ca1699-09db-48d2-8717-87780f850238"
        #API_TOKEN = "9ebc9be4-3601-471a-a0aa-cc2931090d6a"
        SERVER_URL = "Callistodataverse:8080"
        liste_results = []
        log.debug("get_detail, repos:"+str(self.repos))
        for store in self.repos:
            print("repository:"+store)
            output = subprocess.check_output(\
                "wget " + SERVER_URL + "/api/dataverses/" + store + "/contents?key=" + \
                API_TOKEN + " --no-check-certificate -O contenu.json" , \
                stderr=subprocess.STDOUT, shell=True)
            print("wget " + SERVER_URL + "/api/dataverses/" + store + "/contents?key=" + \
                  API_TOKEN + " --no-check-certificate -O contenu.json" )
            with open('contenu.json', 'r') as f:
                data_dict = json.load(f)
            
            for data in data_dict["data"]:
              
                keywords = []
                datatypes = []
                datatypes_values = [] 
                print("New data contact id:"+str(data['id']))
                try:
                    output = subprocess.check_output("wget " + SERVER_URL + "/api/datasets/" + str(data['id']) + "?key=" + API_TOKEN + " --no-check-certificate -O data.json" , stderr=subprocess.STDOUT, shell=True)
                    print("wget " + SERVER_URL + "/api/datasets/" + str(data['id']) + "?key=" + API_TOKEN + " --no-check-certificate -O data.json")
                except:
                    print("Pb. contact dataset id:"+str(data['id']))
                    continue
                with open('data.json', encoding='utf-8') as datasets:
                    print("Opening JSON")
                    try:
                        liste_datasets = json.load(datasets)
                    except:
                        print("pb lecture json")
                    print("OK open JSON")    
                    try:
                        print("metaBlocks:"+str(liste_datasets['data']['latestVersion']['metadataBlocks']))
                    except UnicodeEncodeError:
                        print ("metaBlocks:"+str(liste_datasets['data']['latestVersion']['metadataBlocks']).encode('ascii', 'ignore').decode('ascii'))
                    if len(liste_datasets['data']['latestVersion']['files']) == 0:
                        print("No files registered")
                        id_elt = str(data['id'])
                        type_elt = "None"
                        url = SERVER_URL + "/api/access/dataset/" + str(id_elt) + "?key=" 
                    for elt in liste_datasets['data']['latestVersion']['files']:                      
                        # On recupere l'id des datasets du dataverse interroge
                        #print("Element of ['data']['latestVersion']['files']:")
                        #print(elt)
                        if isinstance(elt, dict):
                            id_elt = elt['dataFile']['id']
                            #print("id datafile:" + str(id_elt))
                            type_elt = elt['dataFile']['contentType']
                            #print("type datafile:" + str(type_elt))
                            url = SERVER_URL + "/api/access/datafile/" + str(id_elt) + "?key="
                    for elt in liste_datasets['data']['latestVersion']['metadataBlocks']['citation']['fields']:
                        #print(str(type(elt)) + "-->" + str(elt))
                        if elt["typeName"] == "title":
                            # Recupere le titre du dataset
                            resume = elt["value"]
                            #print("resume:" + str(resume))
                        if elt["typeName"] == "dsDescription":
                                # Recupere la description du dataset
                            for description_index in elt['value']:
                                description = description_index['dsDescriptionValue']['value']
                            #print("description:" + str(description))
                        if elt["typeName"] == "subject":
                            # Recupere les mots-cles des vocabulaires controles lies au dataset
                            subjects = elt["value"]
                            #print(type(subjects))
                            #print("subject:" + str(subjects))
                            keywords.append(subjects)
                        if elt["typeName"] == "keyword":
                        # Recupere les mots-cles des vocabulaires controles lies au dataset
                            for path in elt["value"]:
                                #print("keyword:" + str(path["keywordValue"]["value"]))
                                keywords.append(path["keywordValue"]["value"])
                    #Gestion des metadonnes specifiques a un projet
                    try:
                        print("Testing SMS metadata")
                        #print(str(liste_datasets['data']['latestVersion']['metadataBlocks']['SMS_04Mars2020_v3']).encode('ascii', 'ignore').decode('ascii'))
                        for elt in liste_datasets['data']['latestVersion']['metadataBlocks']:
                            print(str(elt.encode('ascii', 'ignore').decode('ascii')))
                            #print(elt["displayName"])
                            if elt == "SMS_04Mars2020_v3":
                                print ("Here we are")
                                try:
                                    valeurs = liste_datasets['data']['latestVersion']['metadataBlocks'][elt]['fields'][0]['value']
                                    print(valeurs)
                                    for valeur in valeurs:
                                        print(valeur)
                                        print(liste_datasets['data']['latestVersion']['metadataBlocks'][elt]['fields'][0]['value'][valeur]['value'])
                                        datatypes.append(valeur)
                                        datatypes_values.append(liste_datasets['data']['latestVersion']['metadataBlocks'][elt]['fields'][0]['value'][valeur]['value'])
                                except:
                                    print("No value")
                                #signification = elt["typeName"]
                                #print(signification+" : "+valeur)
                                #keywords.append(signification)
                    except UnicodeEncodeError:
                        print ("metaBlocks:"+str(liste_datasets['data']['latestVersion']['metadataBlocks']).encode('ascii', 'ignore').decode('ascii'))
                    except KeyError:
                        print("No SMS MetaData found")
  
                    liste_results.append([id_elt, resume, description, subjects, url, keywords, type_elt, store, datatypes, datatypes_values])
        return liste_results

    def get_registered_datasets(self):
        """
        Get registered datasets on the repository so that 
        datasets won't be registered multiple times
        """
        self.registered_services = []
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
        PREFIX edamontology: <http://edamontology.org/>
        PREFIX obo: <http://purl.obolibrary.org/obo/>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX mp:<http://purl.org/mp#>
        SELECT DISTINCT ?service
        WHERE {
        ?service service:presents ?profile.
        ?profile arcas:hasQuerySoftware <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#get_dataset>.
        ?profile profile:textDescription ?description.
        }"""
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        log.info(queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                self.registered_services.append(str(binding_set.getValue("service")).replace("\"","").replace("\\n","").replace("\\r"," ").replace("\\","").encode('utf8'))
                	
    def update_ontology(self, details):
        """
        Met a jour l'ontologie avec les elements recueillis dans get_details
        :return:
        Ontologie mise a jour
        """
        print ("------------> Maj ontology")
        service = Namespace("http://www.daml.org/services/owl-s/1.2/Service.owl#")
        profile = Namespace("http://www.daml.org/services/owl-s/1.2/Profile.owl#")
        mp = Namespace("http://purl.org/mp/")
        mp2 = Namespace("http://purl.org/mp#")
        provo = Namespace("http://www.w3.org/ns/prov#")
        dc = Namespace("http://purl.org/dc/terms#")
        arcas = Namespace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#")
        print("details:")
        #for elt in details:
            #print(elt)
        mode = Repository.OPEN
        # Add the OWL data to the graph
        for elt in details:
            timer = str(time.time())
            svc = "FDV_" + str(elt[0])
            log.debug("regisering service:"+svc)
            profile_id = svc + "_Profile"
            short_url = timer + "_url"
            aggregate = timer + "_agg"

            measurement = "Quantity that is measured"
            keywords = elt[5]
            elt_type =  elt[6]
            resume = str(elt[1])
            description = str(elt[2])
            subjects = str(elt[3])
            url = str(elt[4])
            unit = "UNITLESS"
            repo = elt[7]
            repository = self.catalog.getRepository(repo, mode)
            self.conn = repository.getConnection()
            self.get_registered_datasets()
            datatypes = elt[8]
            datatypes_values = elt[9]
            myont = Namespace(self.rootiri+repo+".rdf#")
            print("svc: "+svc)
            #print("URL is: --> "+url)
            print("keywords:" + str(keywords))
            for type in range (len(datatypes)):
                print(svc+self.rootiri+repo+".rdf#"+datatypes[type]+">value:"+datatypes_values[type])
            same = 0
            for reg_desc in self.registered_services:
                print("service:" + svc)
                print("comparing with:")
                print(reg_desc)
                if svc in str(reg_desc):
                    same = 1
                    print("matching found")
                    #break
            if same == 1:
                continue
            #print("measurement:" + measurement)
            #print("Adding the dataset:" + resume)
            #print("subjects:" + subjects)
            #print(URIRef(service.Service))

            qualifies = self.conn.createURI(URIRef(mp2.qualifies))
            presents = self.conn.createURI(URIRef(service.presents))
            hasoperation = self.conn.createURI(URIRef(arcas.hasOperation))
            hasQuerySoftware = self.conn.createURI(URIRef(arcas.hasQuerySoftware))
            hasOutput = self.conn.createURI(URIRef(arcas.hasOutput))
            hasInput =  self.conn.createURI(URIRef(arcas.hasInput))
            isCombinedToParam =  self.conn.createURI(URIRef(arcas.isCombinedToParam))
            isCombinedToFormat =  self.conn.createURI(URIRef(arcas.isCombinedToFormat))
            isCombinedToUnit =  self.conn.createURI(URIRef(arcas.isCombinedToUnit))
            ApiKey = self.conn.createURI(URIRef(arcas.ApiKey))

            labels = self.conn.createURI("<http://www.w3.org/2000/01/rdf-schema#label>")
            isDefined = self.conn.createURI("<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>")
            servi = self.conn.createURI(self.rootiri+repo+".rdf#"+ svc)
            profile = self.conn.createURI(self.rootiri+repo+".rdf#" + profile_id)
            data_tim = self.conn.createURI(self.rootiri+repo+".rdf#" + timer)
            data_url = self.conn.createURI(self.rootiri+repo+".rdf#" + url)
            #agg = self.conn.createURI(self.rootiri+repo+".rdf#" + aggregate)
            
            #log.debug(" --> Adding service: "+servi,profile,data_tim,data_url,agg)
            
            self.conn.add(servi, RDF.TYPE, URIRef(service.Service))
            self.conn.add(profile, RDF.TYPE, URIRef(service.ServiceProfile))
            #self.conn.add(data_tim,RDF.TYPE, URIRef(arcas.MeasuredQuantity))
            self.conn.add(servi, presents, profile)
            
            self.conn.add(servi, hasoperation,  URIRef(arcas.retrieve_dataset))
            self.conn.add(servi, hasoperation, URIRef(arcas.retrieve_metadata))
            
            qsoft = self.conn.createURI("<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#get_dataset>")
            self.conn.add(profile, hasQuerySoftware, qsoft)
            self.conn.add(profile,"<http://www.daml.org/services/owl-s/1.2/Profile.owl#textDescription>", Literal(description))
            #self.conn.add(agg, RDF.TYPE, URIRef(arcas.Aggregate))

            self.conn.add(servi, hasInput, ApiKey)
            for type in range (len(datatypes)):
                self.conn.add(servi, self.rootiri+repo+".rdf#"+datatypes[type]+">",datatypes_values[type])
            self.conn.add(servi,"<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(measurement))
            for word in range(len(keywords)):
                print ("Registering:"+str(keywords[word]))
                if isinstance(keywords[word],str):
                    clean_word = keywords[word].rstrip("']").lstrip("['").replace("'","").replace(",","")
                    #La quantite exprimee vient d'ARCADIE
                    quantity = clean_word.replace(" ", "")
                    qri = self.conn.createURI(self.rootiri+repo+".rdf#"+quantity)
                    self.conn.add(servi, hasOutput, qri)
                        #label = self.conn.createURI(self.rootiri+repo+".rdf#" + clean_word)
                        #self.conn.add(quantity,isDefined,label)
                        #self.conn.add(quantity,labels,label)
                    #self.conn.add(agg,isCombinedToParam,quantity)
                else:
                    for stage2 in range(len(keywords[word])):
                        clean_word = keywords[word][stage2].rstrip("']").lstrip("['").replace("'","").replace(",","")
                        #label = self.conn.createURI(self.rootiri+repo+".rdf#" + clean_word)
                        quantity = clean_word.replace(" ", "")
                        qri = self.conn.createURI(self.rootiri+repo+".rdf#"+quantity)
                        self.conn.add(servi, hasOutput, qri)                        
            #agg = self.conn.createURI(self.rootiri+repo+".rdf#" + aggregate)
            

            self.conn.add(data_tim, RDF.TYPE, URIRef(mp.Data))
            self.conn.add(data_tim,"<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>",Literal(description))

            # AccessURL:
            self.conn.add(data_url, RDF.TYPE, URIRef(arcas.accessURL))
            self.conn.add(data_url, "<http://www.w3.org/2000/01/rdf-schema#isDefinedBy>", Literal(url))
            self.conn.add(servi,"<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#isAccessedThrough>",data_url)
            print('Repository contains %d statement(s).' % self.conn.size())
            repository.shutDown()
            self.conn.close()
        print ("Maj ontology ----> FIN MAJ")

    def open_connection(self):
        server=AllegroGraphServer(host=self.host,port=self.port,user=self.user,password=self.password)
        self.catalog = server.openCatalog('')
        return (self.catalog.listRepositories())

    def read_config(self):
        config_file = open("/usr/local/callisto/etc/callisto_conf.cfg", 'r')
        case = ""
        lines = config_file.readlines()
        for line in lines:
            if "callisto-conf-allegro" in line:
                case = "allegro"
                log.debug("case="+case)
            if "callisto-conf-ontologies" in line:
                case = "ontologies"
                log.debug("case="+case)
            if "callisto-conf-generic" in line:
                case = "generic"
                log.debug("case="+case)
            if "callisto-conf-dataverse" in line:
                case = "dataverse"
                log.debug("case="+case)
                    
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
        try:
            output = subprocess.check_output("rm /usr/local/callisto/logs/Datasets_to_allegro.log" , stderr=subprocess.STDOUT, shell=True)
        except:
            pass
        os.system("touch /usr/local/callisto/logs/Datasets_to_allegro.log")
        log.basicConfig(filename='/usr/local/callisto/logs/Datasets_to_allegro.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.read_config()
        self.repos = self.open_connection()
        log.debug("trouve repos:"+str(self.repos))
