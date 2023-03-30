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
        API_TOKEN = "02ba007d-ec99-4669-98e1-f3b18abfa19b"
        SERVER_URL = "Callistodataverse:8080"
        liste_results = []
        log.debug("get_detail, repos:"+str(self.repos))
        for store in self.repos:
            print("repository:"+store)
            output = subprocess.check_output(\
                "wget " + SERVER_URL + "/api/dataverses/" + store + "/contents?key=" + \
                API_TOKEN + " --no-check-certificate -O contenu.json" , \
                stderr=subprocess.STDOUT, shell=True)
            #print("wget " + SERVER_URL + "/api/dataverses/" + store + "/contents?key=" + \
            #      API_TOKEN + " --no-check-certificate -O contenu.json" )
            with open('contenu.json', 'r') as f:
                data_dict = json.load(f)
            
            for data in data_dict["data"]:
                files_urls = []
                keywords = []
                datatypes = []
                datatypes_values = [] 
                print("New data contact id:"+str(data['id']))
                try:
                    output = subprocess.check_output("wget " + SERVER_URL + "/api/datasets/" + str(data['id']) + "?key=" + API_TOKEN + " --no-check-certificate -O data.json" , stderr=subprocess.STDOUT, shell=True)
                    print("wget " + SERVER_URL + "/api/datasets/" + str(data['id']) + "?key=" + API_TOKEN + " --no-check-certificate -O data.json")
                except:
                    #print("Pb. contact dataset id:"+str(data['id']))
                    continue
                with open('data.json', encoding='utf-8') as datasets:
                    #print("Opening JSON")
                    try:
                        liste_datasets = json.load(datasets)
                    except:
                        print("pb lecture json")
                    #print("OK open JSON")    
                    #try:
                    #    print("metaBlocks:"+str(liste_datasets['data']['latestVersion']['metadataBlocks']))
                    #except UnicodeEncodeError:
                    #    print ("metaBlocks:"+str(liste_datasets['data']['latestVersion']['metadataBlocks']).encode('ascii', 'ignore').decode('ascii'))
                    if len(liste_datasets['data']['latestVersion']['files']) == 0:
                        #print("No files registered")
                        id_elt = str(data['id'])
                        type_elt = "None"
                        url = SERVER_URL + "/api/access/dataset/" + str(id_elt) + "?key=" 
                    for elt in liste_datasets['data']['latestVersion']['files']:                      
                        # On recupere l'id des datasets du dataverse interroge
                        #print("Element of ['data']['latestVersion']['files']:")
                        #print(elt)
                        if isinstance(elt, dict):
                            id_elt = elt['dataFile']['id']
                            try:
                                id_tags = elt['categories']
                            except:
                                id_tags = []
                            try:
                                filedescription = elt['description']
                                print("filedescription:"+str(filedescription))
                            except:
                                filedescription = ""
                            print("tags: "+str(id_tags))
                            print("id datafile:" + str(id_elt))
                            type_elt = elt['dataFile']['contentType']
                            url = SERVER_URL + "/api/access/datafile/" + str(id_elt) + "?key="
                            #print("individual file url:"+url)
                            files_urls.append([url,str(id_elt),id_tags,filedescription])
                    for elt in liste_datasets['data']['latestVersion']['metadataBlocks']['citation']['fields']:
                        #print(str(type(elt)) + "-->" + str(elt))
                        if elt["typeName"] == "title":
                            # Recupere le titre du dataset
                            resume = elt["value"]
                            #print("resume:" + str(resume))
                        if elt["typeName"] == "dsDescription":
                                # Recupere la description du dataset
                            for description_index in elt['value']:
                                dataset_description = description_index['dsDescriptionValue']['value']
                                print("description:" + str(dataset_description.encode('utf-8')))
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
                        #print("Testing SMS metadata")
                        for elt in liste_datasets['data']['latestVersion']['metadataBlocks']:
                            print(str(elt.encode('ascii', 'ignore').decode('ascii')))
                            if elt == "SMS_04Mars2020_v3":
                                #print ("Here we are")
                                try:
                                    valeurs = liste_datasets['data']['latestVersion']['metadataBlocks'][elt]['fields'][0]['value']
                                    print(valeurs)
                                    for valeur in valeurs:
                                        print(valeur)
                                        print(liste_datasets['data']['latestVersion']['metadataBlocks'][elt]['fields'][0]['value'][valeur]['value'])
                                        datatypes.append(valeur)
                                        datatypes_values.append(liste_datasets['data']['latestVersion']['metadataBlocks'][elt]['fields'][0]['value'][valeur]['value'])
                                except:
                                    pass
                                    #print("No value")
                                #signification = elt["typeName"]
                                #print(signification+" : "+valeur)
                                #keywords.append(signification)
                    except UnicodeEncodeError:
                        print ("metaBlocks:"+str(liste_datasets['data']['latestVersion']['metadataBlocks']).encode('ascii', 'ignore').decode('ascii'))
                    except KeyError:
                        print("No SMS MetaData found")
                    ### gestion des fichiers individuels
                    for indiv in files_urls:
                        f_url = indiv[0]
                        id_indiv = indiv[1]
                        print("indiv:"+str(id_indiv))
                        tags = indiv[2]
                        print("keywords:"+str(keywords))
                        new_keys = []
                        description = indiv[3]
                        description = description.replace("\\x","")
                        for ke in keywords:
                            new_keys.append(ke)
                        for tag in tags:
                            new_keys.append(tag)
                        liste_results.append([id_indiv, resume, description, subjects, f_url, new_keys, type_elt, store, \
                                             datatypes, datatypes_values])
                    #liste_results.append([id_elt, resume, description, subjects, url, keywords, type_elt, store, datatypes, datatypes_values])
        for elt in liste_results:
            print(elt[0])
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
        Construit le fichier "template" de description de service
        a partir des elements recuperes dans get_details
        Appelle registerservicepour enregistrement dans l'ontologie
        :return:
        """
        
        for elt in details:
            timer = str(time.time())
            svc = "FDV_" + str(elt[0])
            #print("regisering service:"+svc)
            #print (elt)
            measurement = "Quantity that is measured"
            keywords = elt[5]
            elt_type =  elt[6]
            resume = str(elt[1])
            description = str(elt[2].encode('utf-8', errors='ignore')).replace("b","")            
            subjects = str(elt[3])
            repo = elt[7]
            url = str(elt[4])
            mode = Repository.OPEN
            repository = self.catalog.getRepository(repo, mode)
            
            self.conn = repository.getConnection()
            self.get_registered_datasets()
            
            #print("keywords:" + str(keywords))
            same = 0
            for reg_desc in self.registered_services:
                #print("service:" + svc + " comparing with:" + str(reg_desc).split("#")[1].split(">")[0])
                if svc == str(reg_desc).split("#")[1].split(">")[0]:
                    same = 1
                    #print("matching found")
                    break
            if same == 1:
                continue
            template_file = open(svc+".template",'w')
            template_file.write("service name = "+svc+"\n")
            template_file.write("input = http://www.callisto.calmip.univ-toulouse.fr/"+repo+".rdf#ApiKey\n")
            try:
                template_file.write("description = "+description+"\n")
            except:
                template_file.write("description = Unspecified \n")
            template_file.write("repository = "+repo+"\n")
            template_file.write("scriptfile = get_dataset.py\n")                                                                                                                           
            template_file.write("resultfile = "+svc+".csv\n")                      
            template_file.write("label = Dataset access "+svc+"\n")
            for word in range(len(keywords)):
                print("word:"+str(word))
                try:
                    clean_word = keywords[word].rstrip("']").lstrip("['").replace("'","").replace(",","").replace(" ", "")
                    #print("Outputs ontology aggregate:"+clean_word)
                    template_file.write("output = "+self.rootiri+repo+".rdf#"+clean_word+"\n")
                except:
                    continue
            template_file.write("base url = "+url+"\n")
            template_file.close()
            #print("calling: python3 ./RegisterService.py "+svc+".template register")
            os.system("python3 /usr/local/callisto/bin/RegisterService.py "+svc+".template register")
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
        #self.repos = ['demonstration']
        log.debug("trouve repos:"+str(self.repos))
