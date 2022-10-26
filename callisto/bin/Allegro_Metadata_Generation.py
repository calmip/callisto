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

from franz.openrdf.sail.allegrographserver import AllegroGraphServer
from franz.openrdf.repository.repository import Repository
from franz.openrdf.vocabulary import RDF
from franz.openrdf.query.query import QueryLanguage
from time import gmtime, strftime
import os,sys
import logging as log


class Metadata(object):
    """
    This class handles allegro Triple-Store calls and returns
    """

    def open_connection(self):
        """
        Opens the connection to allegro server
        connects to the repository passed as an argument
        """
        server = AllegroGraphServer(host=self.host, port=self.port, user=self.user, password=self.password)
        catalog = server.openCatalog('')
        mode = Repository.OPEN
        repository = catalog.getRepository(self.repo, mode)
        conn = repository.getConnection()
        return [repository, conn]

    def close_connection(self):
        """
        Closes the connection to allegro server
        """
        self.conn.close()
        self.repo.shutDown()
    def construct_metadata(self):
        """
        """
        name = " "
        title = " "
        description = "No description provided"
        watermark = " "
        fieldType = "text"
        displayOrder = 0
        displayFormat = " "
        advancedSearchField = "TRUE"
        allowControlledVocabulary = "TRUE"
        allowmultiples = "TRUE"
        facetable = "TRUE"
        displayoncreate = "TRUE"
        required = "FALSE"
        metadataLevel = "0"
        for key in self.dict_metadata:
            count = -1
            dispOrder = -1
            print("subject:")
            print (key)
            print("value")
            print(self.dict_metadata[key])
            subjectlabel = self.dict_metadata[key][0].replace("\"","").replace(" ","")
            metadatablock_id = str(subjectlabel) + strftime("%a%d%b%Y%H:%M:%S", gmtime())
            if "#" in str(subjectlabel):
                metadatafile = open(str(subjectlabel).split("#")[1]+"_metadata.tsv",'w')
            else:
                metadatafile = open(str(subjectlabel)+"_metadata.tsv",'w')
            metadatafile.write("#metadataBlock\tname\tdataverseAlias\tdisplayName\n")
            metadatafile.write("\t"+metadatablock_id+"\t\t"+subjectlabel+" Metadata ("+strftime("%a, %d %b %Y %H:%M:%S", gmtime())+")\n")
            metadatafile.write("#datasetField\tname\ttitle\tdescription\twatermark\tfieldType\tdisplayOrder\tdisplayFormat\tadvancedSearchField\tallowControlledVocabulary\tallowmultiples\tfacetable\tdisplayoncreate\trequired\tparent\tmetadatablock_id\n")
            for elt in self.dict_metadata[key]:
                print(elt)
                count += 1
                print(count)
                parent = key
                #print("property list"+str(elt))
                prop = elt[0]
                #print("property:"+prop)
                name = prop
                try:
                    watermark = elt[1].split("#")[1]
                except:
                    continue
                title = elt[2]
                description = elt[3]
                parent = elt[4]
                #print(self.property_dict[prop])
                #if self.property_dict[prop][1]=='None':
                #    print("No predefined values")
                #if metadataLevel == "1":
                #    required = "FALSE"
                #if metadataLevel == "2":
                #    required = "TRUE"
                metadatafile.write("\t"+name+"\t"+title+"\t"+description+"\t"+watermark+"\t"+fieldType+"\t"+str(count)+"\t"+displayFormat+"\t"+advancedSearchField+"\t"+allowControlledVocabulary+"\t"+allowmultiples+"\t"+facetable+"\t"+displayoncreate+"\t"+required+"\t"+parent+"\t"+metadatablock_id+"\n")
            metadatafile.write("#controlledVocabulary\tDatasetField\tValue\tidentifier\tdisplayOrder\n")
            identifier = " "
            for elt in self.dict_metadata[key]:
                prop = elt
                print("property:"+str(prop))
                print("property 0:"+str(prop[0]))
                propname = str(prop[0])
                try:
                    if self.property_dict[propname]=='None':
                        print("No predefined values")
                    else:
                        print("Predefined values"+str(self.property_dict[propname]))
                        for predefined in self.property_dict[propname]:
                            dispOrder += 1
                            print("predefined value:" + str(predefined))
                            print("predefined[1]:"+str(predefined[1]))
                            if str(predefined[1]) == "None":
                                continue
                            metadatafile.write("\t"+propname+"\t"+str(predefined[1])+"\t"+identifier+"\t"+str(dispOrder)+"\n")
                except Exception as e:
                    #print(type(e))    # the exception instance
                    #print(e.args)     # arguments stored in .args
                    print(e)
                count += 1

        #for binding in bindings:
            #print(binding.getAttribute("name"))
            #if binding.getAttribute("name") == "subject":
                #for lab in binding.getElementsByTagName("uri"):
                    #name = lab.firstChild.data.replace("http://www.w3.org/2000/01/rdf-schema#","").replace("http://www.semanticweb.org/thierry/ontologies/2019/10/untitled-ontology-19#", "")
                    #title = name.replace("_"," ")
                    
            # if binding.getAttribute("name") == "comment":
            #     for lit in binding.getElementsByTagName("literal"):
            #         description = lit.firstChild.data
            # if binding.getAttribute("name") == "supertype":
            #     for lit in binding.getElementsByTagName("uri"):
            #         parent = lit.firstChild.data.replace("http://www.w3.org/2000/01/rdf-schema#","").replace("http://www.semanticweb.org/thierry/ontologies/2019/10/untitled-ontology-19#", "")
                   
            # #The first parent encountered for a field is the only one displayed
    
            #     displayOrder = str(count)
            #     metadatafile.write("\t"+name+"\t"+title+"\t"+description+"\t"+watermark+"\t"+fieldType+"\t"+displayOrder+"\t"+displayFormat+"\t"+advancedSearchField+"\t"+allowControlledVocabulary+"\t"+allowmultiples+"\t"+facetable+"\t"+displayoncreate+"\t"+required+"\t"+parent+"\t"+metadatablock_id+"\n")
        metadatafile.close()

    def get_metadatas(self):
        """
        Returns services described in the ontology following metadata from ontology specified in dataverse
        """
        count = 0
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX myont: <http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX mp:<http://purl.org/mp/>
        SELECT DISTINCT ?subject ?subjectlabel ?supertype ?metadatalevel ?property ?label ?range ?values ?definition
        WHERE {
            ?subject arcas:metadataLevel ?metadatalevel.
            ?subject rdfs:subClassOf ?supertype.
            ?subject rdfs:label ?subjectlabel.
            ?property rdfs:domain ?subject.
            ?property rdfs:range ?range.
            OPTIONAL {
                ?property rdfs:isDefinedBy ?definition.
                ?property rdfs:label ?label.
                ?range <http://www.w3.org/2002/07/owl#oneOf> ?list.
  	            ?list rdf:rest*/rdf:first ?values.
            }
        }"""
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        log.info(queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                #print("subject"+str(binding_set.getValue("subject")))
                #print("label"+str(binding_set.getValue("label")))
                #print("comment"+str(binding_set.getValue("comment")))
                #print("supertype"+str(binding_set.getValue("supertype")))
                #print("metadatalevel"+str(binding_set.getValue("metadatalevel")))
                #print("property"+str(binding_set.getValue("property")))
                #print("range"+str(binding_set.getValue("range")))
                #print("values"+str(binding_set.getValue("values")))
                values = str(binding_set.getValue("values")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                subject = str(binding_set.getValue("subject")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                property = str(binding_set.getValue("property")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                label = str(binding_set.getValue("label")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                definition = str(binding_set.getValue("definition")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                supertype = str(binding_set.getValue("supertype")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                metadatalevel = str(binding_set.getValue("metadatalevel")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                subjectlabel = str(binding_set.getValue("subjectlabel")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                range = str(binding_set.getValue("range")).replace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#","").replace("http://www.callisto.calmip.univ-toulouse.fr/MSHT.rdf#","").replace(">","").replace("<","")
                if property in self.property_dict:
                    self.property_dict[property].append([range,values])
                else:
                    self.property_dict[property] = [[range,values]]
                print(property)
                print(str([range,values]))
                if subject not in self.dict_metadata:
                    self.dict_metadata[subject] = [subjectlabel]
                    self.dict_metadata[subject].append([property,metadatalevel,label,definition,supertype])
                else:
                    if [property,metadatalevel,label,definition,supertype] not in self.dict_metadata[subject]:
                        self.dict_metadata[subject].append([property,metadatalevel,label,definition,supertype])
    def read_config(self):
        config_file = open("../etc/callisto_conf.cfg", 'r')
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
	
        try:
            os.system("rm ../logs/metadatas.log")
        except:
            pass
        self.dict_metadata={}
        self.property_dict = {}
        log.basicConfig(filename='../logs/metadatas.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.read_config()
        self.repo = sys.argv[1]
        self.name_metadata_file = self.repo + "_metadata.tsv"
        self.conn = self.open_connection()[1]
        self.get_metadatas()
        self.construct_metadata()

browse = Metadata()