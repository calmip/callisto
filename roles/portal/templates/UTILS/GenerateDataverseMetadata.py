#! /usr/bin/python3.6m
# -*- coding: utf-8 -*-
import rdflib
from rdflib import Graph, URIRef, BNode, Literal
from rdflib.namespace import OWL, RDF, RDFS, FOAF
import os
import logging as log
import urllib
import urllib.request
from xml.dom import minidom
from time import gmtime, strftime


class BrowseOntology(object):
    """
    """

    def send_request(self, request):
        """
        """
        print(self.base + urllib.parse.quote_plus(request))
        log.debug(self.base + urllib.parse.quote_plus(request))
        xmldoc = minidom.parse(urllib.request.urlopen(self.base + urllib.parse.quote_plus(request)))
        self.results = xmldoc.getElementsByTagName("result")

    def construct_metadata(self):
        """
        """
        metadatafile = open(self.name_metadata_file,'w')
        metadatafile.write("#metadataBlock\tname\tdataverseAlias\tdisplayName\n\tsms"+strftime("%a%d%b%Y%H:%M:%S", gmtime())+"\t\tSmart Morphing and Sensing Metadata ("+strftime("%a, %d %b %Y %H:%M:%S", gmtime())+")\n")
        metadatafile.write("#datasetField\tname\ttitle\tdescription\twatermark\tfieldType\tdisplayOrder\tdisplayFormat\tadvancedSearchField\tallowControlledVocabulary\tallowmultiples\tfacetable\tdisplayoncreate\trequired\tparent\tmetadatablock_id\n")
        self.send_request(self.request)
        #print (self.results)
        #avoidable_items: Ce que l'on ne veut pas voir apparaitre dans les metadonnees selectionnables
        #avoidable_items = ["http://www.w3.org/1999/02/22-rdf-syntax-ns#List","http://www.w3.org/1999/02/22-rdf-syntax-ns#Property","http://www.w3.org/2002/07/owl#DatatypeProperty","http://www.w3.org/2002/07/owl#NamedIndividual","http://www.w3.org/2002/07/owl#ObjectProperty","http://www.w3.org/2002/07/owl#Ontology","Resource","Datatype"]
        avoidable_items=[]
        count = 0
        has_parent = []
        for result in self.results:
            bindings = result.getElementsByTagName("binding")
            name = " "
            title = " "
            description = "No description provided"
            watermark = " "
            fieldType = "text"
            displayOrder = " "
            displayFormat = " "
            advancedSearchField = "TRUE"
            allowControlledVocabulary = "TRUE"
            allowmultiples = "TRUE"
            facetable = "TRUE"
            displayoncreate = "TRUE"
            required = "FALSE"
            parent = " "
            metadatablock_id = "sms"+strftime("%a%d%b%Y%H:%M:%S", gmtime())
            avoid = 0
            metadataLevel = "0"
            for binding in bindings:
                #print(binding.getAttribute("name"))
                if binding.getAttribute("name") == "subject":
                    for lab in binding.getElementsByTagName("uri"):
                        name = lab.firstChild.data.replace("http://www.w3.org/2000/01/rdf-schema#","").replace("http://www.semanticweb.org/thierry/ontologies/2019/10/untitled-ontology-19#", "")
                        title = name.replace("_"," ")
                        if name in avoidable_items:
                            avoid = 1
                            break
                if binding.getAttribute("name") == "comment":
                    for lit in binding.getElementsByTagName("literal"):
                        description = lit.firstChild.data
                if binding.getAttribute("name") == "metadatalevel":
                    for lit in binding.getElementsByTagName("literal"):
                        metadataLevel = lit.firstChild.data
                        if metadataLevel == "1":
                            required = "FALSE"
                        if metadataLevel == "2":
                            required = "TRUE"
                if binding.getAttribute("name") == "supertype":
                    for lit in binding.getElementsByTagName("uri"):
                        parent = lit.firstChild.data.replace("http://www.w3.org/2000/01/rdf-schema#","").replace("http://www.semanticweb.org/thierry/ontologies/2019/10/untitled-ontology-19#", "")
                        if parent in avoidable_items:
                            avoid = 1
                            break
            if parent == name or metadataLevel == "0":
                avoid = 1
            #The first parent encountered for a field is the only one displayed
            if name in has_parent:
                print(name+" already has some parent ")
                avoid = 1
            if parent != " " and avoid == 0:
                has_parent.append(name)
                print(name+" has parent: "+parent)
            if avoid == 0:
                if parent == "Resource":
                    parent = " "
                if parent != " ":
                    name = parent+"."+name
                count += 1
                displayOrder = str(count)
                metadatafile.write("\t"+name+"\t"+title+"\t"+description+"\t"+watermark+"\t"+fieldType+"\t"+displayOrder+"\t"+displayFormat+"\t"+advancedSearchField+"\t"+allowControlledVocabulary+"\t"+allowmultiples+"\t"+facetable+"\t"+displayoncreate+"\t"+required+"\t"+parent+"\t"+metadatablock_id+"\n")
        metadatafile.close()

    def retrieve_taxonomy(self):
        """
        """
        log.info("Entre dans retrieve_taxonomy")
        self.justification = ""
        # Le "i" permet de ne pas etre case-sensitive
        #PREFIX myont: <http://callisto.calmip.univ-toulouse.fr/callisto/CALMIP_SVC_PROD.owl#>
        self.request = """
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX owl: <http://www.w3.org/2002/07/owl#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
        PREFIX myont: <http://www.semanticweb.org/thierry/ontologies/2019/10/untitled-ontology-19#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        SELECT DISTINCT ?subject ?label ?comment ?supertype ?metadatalevel
        WHERE {
        { ?subject a owl:Class . } UNION { ?individual a ?subject . } .
        OPTIONAL { ?subject rdfs:subClassOf ?supertype } .
        OPTIONAL { ?subject rdfs:comment ?comment } .
        OPTIONAL { ?subject myont:metadataLevel ?metadatalevel } .
        OPTIONAL { ?subject rdfs:label ?label }
        } ORDER BY ?subject"""
        
    def __init__(self,repository,filename):
        """
        Génère un fichier de métadonnées avec les éléments recueillis dans l'ontologie
        Ce fichier sera passé à DataVerse pour servir de nouveau set de métadonnées possibles
        basé sur la taxonomie présente dans l'ontologie.
        :return:
        Fichier .tsv prêt à ingérer par DataVerse
        """
        os.system("rm metadata_generation.log")
        log.basicConfig(filename='metadata_generation.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.repository = repository
        self.base = "http://192.168.0.8:8080/rdf4j-workbench/repositories/"+self.repository+"/query?query="
        self.name_metadata_file = filename
        
metadata_filename = "sms_metadata.tsv"
repository = "sms_real" 
browse = BrowseOntology(repository,metadata_filename)
browse.retrieve_taxonomy()
browse.construct_metadata()
#os.system("""curl http://192.168.0.6:8080/api/admin/datasetfield/load -H "Content-type: text/tab-separated-values" -X POST --upload-file """+metadata_filename)
