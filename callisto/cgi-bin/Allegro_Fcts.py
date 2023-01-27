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

import StringDist
from franz.openrdf.sail.allegrographserver import AllegroGraphServer
from franz.openrdf.repository.repository import Repository
from franz.openrdf.vocabulary import RDF
from franz.openrdf.query.query import QueryLanguage
import cgi
import os
import logging as log


class Allegro(object):
    """
    This class handles allegro Triple-Store calls and returns
    """

    def open_connection(self, repo):
        """
        Opens the connection to allegro server
        connects to the repository passed as an argument
        """
        server = AllegroGraphServer(host=self.host, port=self.port, user=self.user, password=self.password)
        catalog = server.openCatalog('')
        mode = Repository.OPEN
        repository = catalog.getRepository(repo, mode)
        conn = repository.getConnection()
        return [repository, conn]

    def close_connection(self):
        """
        Closes the connection to allegro server
        """
        self.conn.close()
        self.repo.shutDown()

    def send_header(self):
        """
        :return:
        prints generic header for browsers response
        """
        print("Content-Type: text/xml\n")
        print("<options>\n")
        print("<case>" + self.usecase + "</case>")
        print("<allegro>" + self.rootallegro.replace("\"","") + "</allegro>\n")
        print("<suffix>" + self.onto_suffix + "</suffix>\n")
        print("<csvschemafile>" + self.csv_file + "</csvschemafile>\n")

    def send_footer(self):
        """
        :return:
        generic footer for ending xml tags
        """
        print("</options>")

    def send_response(self):
        """
        Send returns to the internet brower.
        """
        if self.usecase == "seek_operations":
            log.debug("OPERATIONS:\n"+str(self.operations)+"\n")
            self.general_file.write("source,target\n")
            liste_services_retournes = []
            for svc in range(len(self.operations)):
                current = self.operations[svc]
                if current in liste_services_retournes:
                    continue
                liste_services_retournes.append(current)
                log.debug("---> operation "+str(svc)+":"+str(current))
                print("<service>\n")
                print("<nom>S"+str(svc)+"</nom>\n")
                print("<ontology_id>" + current[0] + "</ontology_id>\n")
                soft = str(current[2])
                url = str(current[4]).replace(">","").replace("<","")
                if "#" in url:
                    url = url.split("#")[1]
                print("<url>" + url + "</url>\n")
                print("<soft>" + soft.replace("\"","") + "</soft>\n")
                for out in current[6]:
                    log.debug("output:"+str(out))
                    if str(out[0]).replace(">","").replace("<","").split("#")[1] == "None":
                        continue                   
                    print("<output>" + str(out[0]).replace(">","").replace("<","").replace(".","").split("#")[1] + "</output>\n")
                    self.general_file.write("service:S0," + str(out[0]).replace(">","").replace("<","").replace(".","") + "\n")
                    print("<output_definition>"+ str(out[2]).replace("\"","") + "</output_definition>\n")
                    print("<information>ToBD</information>\n")
                    print("<information_label>" + str(out[2]).replace("\"","") + "</information_label>\n")
                    short_output = str(out[0]).replace(">","").replace("<","").replace(".","").split("#")[1]
                    print("<short_output>" + short_output + "</short_output>\n")
                for inpt in current[7]:
                    log.debug("input:"+str(inpt))
                    in_svc = str(inpt[0]).replace(">", "").replace("<", "").replace(".","")
                    if "#" in in_svc:
                        in_svc = in_svc.split("#")[1]
                    if in_svc == "None":
                        #print("<input>None</input>\n")
                        #print("<short_input>None</short_input>\n")
                        #print("<input_definition>None</input_definition>\n")
                        continue
                    print("<input>" + in_svc + "</input>\n")
                    try:
                        short_input = in_svc.split("#")[1]
                    except:
                        short_input = in_svc
                    print("<short_input>" + short_input + "</short_input>\n")
                    if str(inpt[1]) == "None":
                        print("<input_definition>None</input_definition>\n")
                    else:
                        print("<input_definition>" + str(inpt[2]).replace(">", "").replace("<", "").replace("\"","") + "</input_definition>\n")
                print("<definition>ToBD</definition>\n")
                print("<profdef>" +str(current[5]) + "</profdef>\n")
                print("</service>\n")
        if self.usecase == "generic":
            for key in self.services:
                print("<service>\n")
                print("<nom>" + key.replace(">", "").replace("<", "") + "</nom>\n")
                log.info(
                    "<generic statement>" + str(self.services[key][0]).replace("&", "&amp;").replace(">", "").replace(
                        "<", "") + "</statement>")
                print("<statement>" + str(self.services[key][0]).replace("&", "&amp;").replace(">", "").replace("<", "")
                      + "</statement>\n")
                print("<claim>" + str(self.services[key][2]).replace(">", "").replace("<", "") + "</claim>\n")
                print("</service>\n")
        if self.usecase == "data":
            sent = []
            for key in self.final_services:
                if str(key) not in sent:
                    log.debug("send_response:" + str(key))
                    url_soft = self.get_soft_and_url(str(key))
                    soft = str(url_soft[0])
                    url = str(url_soft[1])
                    description = str(url_soft[2])
                    print("<service>\n")
                    print("<nom>\"" + str(key).lstrip("<").rstrip(">") + "\"</nom>\n")
                    print(
                        "<description>" + str(description.encode('utf8')).replace("\\n", "").replace("\\r", "").replace(
                            "\\", "") + "</description>\n")
                    print("<soft>" + soft + "</soft>\n")
                    print("<url>" + url + "</url>")
                    print("</service>\n")
                sent.append(str(key))
        if self.usecase == "functionality":
            for key in self.services:
                print("<service>\n")
                print("<nom>" + str(key) + "</nom>\n")
                print("</service>\n")

    def get_general_topics(self):
        """
        Returns claims identified by their sentences, or semantic qualifiers
        best fitting the loose query expressed by the user
        """
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX myont: <%s%s.rdf#>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX mp:<http://purl.org/mp/>
        SELECT DISTINCT ?statement ?qualifier ?claim ?ref ?cit ?qual
        WHERE {
        ?claim mp:supports ?ref.
        ?claim mp:qualifiedBy ?qual.
        ?claim mp:statement ?statement.
        ?qual rdfs:isDefinedBy ?qualifier.
        ?ref mp:citation ?cit.
        }""" % (self.rootiri,self.repository)
        log.debug(queryString)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        # print(result)
        ok_claims = []
        with result:
            for binding_set in result:
                # print("<service>")
                log.debug(binding_set)
                statement = str(binding_set.getValue("statement"))
                qualifier = str(binding_set.getValue("qualifier"))
                # service = str(binding_set.getValue("service"))
                claim = str(binding_set.getValue("claim")).split("#")[1].replace(">", "")
                log.debug("claim: " + claim)
                log.debug("Iseek: " + self.Iseek)
                temp_statement_score = StringDist.compare(statement, self.Iseek)
                temp_qualifier_score = StringDist.compare(qualifier, self.Iseek)
                log.debug("statement: " + statement + " score: " + str(temp_statement_score))
                log.debug("qualifier: " + qualifier + " score: " + str(temp_qualifier_score))
                # This is a loose query. We don't need the closer match, but every match considered close enough.
                if temp_statement_score > self.close_enough or temp_qualifier_score > self.close_enough:
                    log.debug(ok_claims)
                    ok_claims.append(claim)
                    log.debug(ok_claims)
                # print("</service>")
        encountered_claims = []
        for claim in ok_claims:
            log.debug(claim)
            queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            PREFIX myont: <%s%s.rdf#>
            PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
            PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
            PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
            PREFIX mp:<http://purl.org/mp/>
            SELECT DISTINCT ?statement ?qualifier ?claim ?ref ?cit ?qual ?url ?dataval
            WHERE {
            myont:%s mp:supports ?ref.
            myont:%s mp:qualifiedBy ?qual.
            myont:%s mp:statement ?statement.
            ?qual rdfs:isDefinedBy ?qualifier.
            ?ref mp:citation ?cit.
            ?ref arcas:isAccessedThrough ?urlval.
            ?urlval rdfs:isDefinedBy ?url.
            ?dataurl mp:elementOf ?ref.
            ?dataurl rdfs:isDefinedBy ?dataval.
            }""" % (self.rootiri,self.repository, claim, claim, claim)
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result2 = tupleQuery.evaluate()
            qualifiers = []
            print("<service>")
            for binding_set in result2:
                # log.debug(binding_set)
                citation = str(binding_set.getValue("cit"))
                statement = str(binding_set.getValue("statement"))
                qualifier = str(binding_set.getValue("qualifier"))
                qual = str(binding_set.getValue("qual")).replace("\"", "")
                url = str(binding_set.getValue("url"))
                dataval = str(binding_set.getValue("dataval"))
                if claim not in encountered_claims:
                    encountered_claims.append(claim)
                    print("<claim>" + claim + "</claim>")
                print("<statement>" + statement + "</statement>")
                print("<citation>" + citation.encode('ascii', 'ignore').decode('ascii').replace("&", " and ")
                  + "</citation>")
                try:
                    print("<qualifier>" + qualifier.split("#")[1].replace("<", "").replace(">", "") + "</qualifier>")
                except:
                    print("<qualifier>" + qualifier + "</qualifier>")
                try:
                    filtered_qual = qual.split("#")[1].replace("<", "").replace(">", "")
                    if filtered_qual in qualifiers:
                        continue
                    else:
                        print("<qual>" + qual.split("#")[1].replace("<", "").replace(">", "") + "</qual>")
                        qualifiers.append(filtered_qual)
                except:
                    if qual in qualifiers:
                        continue
                    else:
                        print("<qual>" + qual + "</qual>")
                        qualifiers.append(qual)
                print("<url>" + url.replace(self.roothttps, "") + "</url>")
                print("<urldata>" + dataval + "</urldata>")
            print("</service>")

        return

    def get_implemented_operations_and_algos(self):
        """
        Lists definitions, alternatives terms and labels from concepts
        representing operations / algorithms /processes in the ontology
        """
        count = 0
        # * makes the request transitive: subClassOf explores every subclass of specified class
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
        PREFIX edamontology: <http://edamontology.org/>
        PREFIX obo: <http://purl.obolibrary.org/obo/>
        PREFIX swo: <http://www.ebi.ac.uk/swo/>
        PREFIX arcas:<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        SELECT ?concept ?label ?definition ?alternative ?library ?svc
        WHERE { 
        ?svc arcas:hasOperation ?operation.
        ?operation rdfs:isDefinedBy ?definition.
        OPTIONAL {?operation rdfs:label ?label.}
        OPTIONAL {?svc swo:SWO_0000082 ?library}
        }"""
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        log.debug(queryString)
        with result:
            for binding_set in result:
                count += 1
                self.concepts_dict[count] = ["", "", "", "", "", ""]
                concept = str(binding_set.getValue("concept"))
                self.concepts_dict[count][0] = concept
                label = str(binding_set.getValue("label"))
                self.concepts_dict[count][1] = label
                definition = str(binding_set.getValue("definition"))
                self.concepts_dict[count][2] = definition
                alternative = str(binding_set.getValue("alternative"))
                self.concepts_dict[count][3] = alternative
                library = str(binding_set.getValue("library"))
                self.concepts_dict[count][4] = library
                svc = str(binding_set.getValue("svc"))
                self.concepts_dict[count][5] = svc

    def render_best_data(self):
        """
        """
        definition_score = 0.4
        best_definition = 0
        best_definition_key = 0
        output_score = 0.4
        best_output = 0
        keyword_score = 0.4
        best_keyword = 0
        best_keyword_key = 0
        self.output_svc = self.Iseek
        tested = []
        for key in self.data_dict:
            log.debug("key:" + str(key))
            val = str(str(self.data_dict[key]).encode('utf-8'))
            log.debug("value:" + val)
            #if self.data_dict[key][1] in tested:
            #    continue
            #tested.append(self.data_dict[key][1])
            
            to_compare = str(str(self.data_dict[key][1]).encode('utf-8')).replace(">", "").replace("<", "").replace(
                self.myont, "")
            temp_definition_score = StringDist.compare(self.Iseek, to_compare)
            log.debug("for data definition compare: " + self.Iseek + " with: " + to_compare + " score: " + str(
                temp_definition_score))
            log.debug("lowered:" + self.Iseek.lower())
            log.debug("lowered" + to_compare.lower())
            if self.Iseek.lower() in to_compare.lower() and temp_definition_score < 0.5:
                log.debug("Match found. Setting sim to 0.5")
                temp_definition_score = 0.5
                if self.data_dict[key][0] not in self.final_services:
                    self.final_services.append(self.data_dict[key][0])
            
            if temp_definition_score > definition_score:
                if self.data_dict[key][0] not in self.final_services:
                    self.final_services.append(self.data_dict[key][0])
            
            to_compare = str(str(self.data_dict[key][4]).encode('utf-8')).replace(">", "").replace("<", "").replace(self.myont, "")
            temp_output_score = StringDist.compare(self.Iseek, to_compare)
            log.debug("for data otuput compare: " + self.Iseek + " with: " + to_compare + " score: " + str(temp_output_score))
            if self.Iseek.lower() in to_compare.lower() and temp_output_score < output_score:
                log.debug("Match found. Setting sim to 0.5")
                if self.data_dict[key][0] not in self.final_services:
                    self.final_services.append(self.data_dict[key][0])
            if temp_output_score > output_score:
                if self.data_dict[key][0] not in self.final_services:
                    self.final_services.append(self.data_dict[key][0])

            to_compare = str(str(self.data_dict[key][2]).encode('utf-8')).replace(">", "").replace("<", "").replace(self.myont, "")
            temp_keyword_score = StringDist.compare(self.Iseek, to_compare)
            log.debug("for data keyword compare: " + self.Iseek + " with: " + to_compare + " score: " + str(temp_keyword_score))
            if self.Iseek.lower() in to_compare.lower() and temp_keyword_score < keyword_score:
                log.debug("Match found. Setting sim to 0.5")
                if self.data_dict[key][0] not in self.final_services:
                    self.final_services.append(self.data_dict[key][0])
            if temp_keyword_score > keyword_score:
                if self.data_dict[key][0] not in self.final_services:
                    self.final_services.append(self.data_dict[key][0])
        
        for key in self.metadata_dict:
            log.debug("key:" + str(key))
            val = str(str(self.metadata_dict[key]).encode('utf-8'))
            log.debug("METADATA value:" + val)
            to_compare = str(str(self.metadata_dict[key][2]).encode('utf-8')).replace(">", "").replace("<", "").replace(self.myont, "")
            temp_definition_score = StringDist.compare(self.Iseek, to_compare)
            log.debug("for METAdata definition compare: " + self.Iseek + " with: " + to_compare + " score: " + str(temp_definition_score))
            if temp_definition_score > 0.5:
                if self.metadata_dict[key][0] not in self.final_services:
                    self.final_services.append(self.metadata_dict[key][0])

    def get_soft_and_url(self, index):
        """
        gets software and url for service passed as index
        """
        queryString = """PREFIX myont: <%s%s.rdf#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>
        SELECT DISTINCT ?url ?soft ?description
        WHERE { 
        %s service:presents ?profile.
        ?profile arcas:hasQuerySoftware ?soft_profile.
        OPTIONAL {?soft_profile rdfsns:label ?soft.}
        %s arcas:isAccessedThrough ?address.
        ?address rdfsns:isDefinedBy ?url.
        OPTIONAL {
        %s service:presents ?profile.
        ?profile profile:textDescription ?description.
        }}""" % (self.rootiri,self.repository, index, index, index)
        soft = ""
        return_url = ""
        description = ""
        log.debug(queryString)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                return_url = binding_set.getValue("url")
                soft = binding_set.getValue("soft")
                description = binding_set.getValue("description")
                log.debug("description:" + str(description))
        return [soft, return_url, description]

    def data_claim(self):
        """
        Returns the service, url and software with whom the data
        related to a claim may be obtained
        """
        log.debug("Constructing URL")
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX myont: <%s%s.rdf#>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX mp:<http://purl.org/mp/>
        SELECT DISTINCT ?svc ?desc ?param ?url ?soft 
        WHERE {
        ?claim mp:qualifiedBy myont:%s.
        ?svc arcas:hasOutput ?out.
        ?out arcas:isCombinedToParam myont:%s.
        ?svc service:presents ?profile.
        ?profile profile:textDescription ?desc.
        ?svc arcas:hasInput ?input_agg.
        ?input_agg arcas:isCombinedToParam ?param.
        ?profile arcas:hasQuerySoftware ?soft.
        ?svc arcas:isAccessedThrough ?accessurl.
        ?accessurl rdfs:isDefinedBy ?url.
        }""" % (self.rootiri,self.repository, self.qual, self.qual)
        log.debug(queryString)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        dict_svcs = {}
        with result:
            for binding_set in result:
                list_param = []
                log.debug("exploring data claim binding sets")
                service = binding_set.getValue("svc")
                log.debug(service)
                svc = str(service).split("#")[1].replace("<", "").replace(">", "")
                log.debug(svc)
                desc = str(binding_set.getValue("desc"))
                log.debug("desc:"+desc)
                log.debug("brute url:"+str(binding_set.getValue("url")))
                url = str(binding_set.getValue("url"))
                log.debug("url:"+url)
                soft = str(binding_set.getValue("soft"))
                log.debug("soft:"+soft)
                if svc not in dict_svcs:
                    dict_svcs[svc] = []
                    dict_svcs[svc].append(desc)
                    dict_svcs[svc].append(url)
                    dict_svcs[svc].append(soft)
                param = str(binding_set.getValue("param")).split("#")[1].replace("<", "").replace(">", "")
                log.debug(param)
                list_param.append(param)
            dict_svcs[svc].append(list_param)
        for key in dict_svcs:
            log.debug(key)
            print("<service>")
            print("<nom>" + key + "</nom>")
            print("<description>" + dict_svcs[key][0] + "</description>")
            print("<soft>" + dict_svcs[key][2].split("#")[1].replace("<", "").replace(">", "")+ "</soft>")
            print("<url>" + dict_svcs[key][1].replace("CallistoDataverse","https://dataverse.calmip.univ-toulouse.fr") + "</url>")
            params = dict_svcs[key][3]
            for param in params:
                print("<input>" + param + "</input>")
            print("</service>")

    def get_definitions(self):
        """
        Returns services described in the ontology
        """
        count = 0
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
        PREFIX edamontology: <http://edamontology.org/>
        PREFIX obo: <http://purl.obolibrary.org/obo/>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX mp:<http://purl.org/mp#>
        SELECT DISTINCT ?service ?description ?label ?output_definition
        WHERE {
        ?service service:presents ?profile.
        ?profile arcas:hasQuerySoftware <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#get_dataset>.
        ?service arcas:hasOutput ?output.
        ?output arcas:isCombinedToParam ?param.
        OPTIONAL {?param rdfs:isDefinedBy ?output_definition.}
        ?profile profile:textDescription ?description.
        OPTIONAL {?param rdfs:label ?label}
        }"""
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        log.info(queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                count += 1
                self.data_dict[count] = ["", "", "", "", "", ""]
                self.data_dict[count][2] = binding_set.getValue("label")
                self.data_dict[count][1] = binding_set.getValue("description")
                self.data_dict[count][0] = binding_set.getValue("service")
                self.data_dict[count][4] = binding_set.getValue("output_definition")
    
    def get_metadatas(self):
        """
        Returns services described in the ontology following metadata from ontology specified in dataverse
        """
        count = 0
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
        PREFIX edamontology: <http://edamontology.org/>
        PREFIX obo: <http://purl.obolibrary.org/obo/>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX mp:<http://purl.org/mp#>
        SELECT DISTINCT ?service ?prop ?def ?value
        WHERE {
        ?service service:presents ?profile.
        ?prop <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2002/07/owl#DatatypeProperty>.
        ?service ?prop ?value.
        ?prop <http://www.w3.org/2000/01/rdf-schema#isDefinedBy> ?def.
        }"""
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        log.info(queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                count += 1
                self.metadata_dict[count] = ["", "", "", ""]
                self.metadata_dict[count][0] = binding_set.getValue("service")
                self.metadata_dict[count][1] = binding_set.getValue("prop")
                self.metadata_dict[count][2] = binding_set.getValue("def")
                self.metadata_dict[count][3] = binding_set.getValue("value")


    def get_details(self):
        """
        gets details for service passed as index
        """
        queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>\
        PREFIX edamontology: <http://edamontology.org/>\
        PREFIX obo: <http://purl.obolibrary.org/obo/>\
        PREFIX myont: <%s%s#.rdf>\
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>\
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>\
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>\
        PREFIX mp:<http://purl.org/mp/>\
        SELECT DISTINCT ?statement ?publisher ?description ?datadesc\
        WHERE { \
        service:%s arcas:hasOutput ?out.\
        ?out arcas:isCombinedToParam ?param.\
        service:%s service:presents ?profile.\
        ?profile profile:textDescription ?description.\
        OPTIONAL{?param rdfs:isDefinedBy ?datadesc.\
        ?param mp:publishedBy ?publisher.\
        ?param mp:supports ?claim.\
        ?claim mp:statement ?statement}}" % (self.rootiri,self.repository, self.service, self.service)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                self.statement = binding_set.getValue("statement")
                self.publisher = binding_set.getValue("publisher")
                self.description = binding_set.getValue("description")
                self.data_desc = binding_set.getValue("datadesc")

    def get_operations(self):
        """
        """
        new_step_found = 0
        new_list_svc = []
        log.debug("Entering get operations:")
        log.debug(self.list_inputs_svc)
        for svc in self.list_inputs_svc:
            log.debug("Testing:"+str(svc))
            if str(svc) == 'None':
                continue
            next_steps = []
            inputs = []
            outputs = []
            queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
            PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
            PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
            PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>
            SELECT DISTINCT ?soft_profile ?soft ?address ?url ?service_description
            WHERE { 
            <%s> service:presents ?firstprofile .
            ?firstprofile profile:textDescription ?description . 
            ?firstprofile arcas:hasQuerySoftware ?soft_profile .
            OPTIONAL {?soft_profile rdfsns:label ?soft .}
            <%s> arcas:isAccessedThrough ?address .
            ?address rdfsns:isDefinedBy ?url .
            <%s> service:presents ?firstprofile .
            ?firstprofile profile:textDescription ?service_description .
            } 
            """ % (svc, svc, svc)
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result = tupleQuery.evaluate()
            with result:
                for binding_set in result:
                    soft_profile = binding_set.getValue("soft_profile")
                    soft = binding_set.getValue("soft")
                    address = binding_set.getValue("address")
                    url = binding_set.getValue("url")
                    service_description = binding_set.getValue("service_description")
            queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
            PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
            SELECT DISTINCT ?service                                                                             
            WHERE { <%s> arcas:hasOutput ?out .                 
            ?out arcas:isCombinedToParam ?p .
            ?out arcas:isCombinedToUnit ?u .
            ?out arcas:isCombinedToFormat ?f .
            ?suite arcas:isCombinedToParam ?p .
            ?suite arcas:isCombinedToUnit ?u .
            ?suite arcas:isCombinedToFormat ?f .
            ?service profile:hasInput ?suite .
            }                                                                                                                                  
            """ % (svc)
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result = tupleQuery.evaluate()
            with result:
                for binding_set in result:
                    new_step_found = 1
                    next_service = binding_set.getValue("service")
                    if str(next_service).replace("<", "").replace(">", "") not in new_list_svc:
                        new_list_svc.append(str(next_service).replace("<", "").replace(">", ""))
                        log.debug("Adding "+ str(next_service).replace("<", "").replace(">", "") + " To the list of operations")
                        next_steps.append(next_service)
            queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
            PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
            PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
            PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>
            SELECT DISTINCT ?out ?param_out ?label_out ?definition_out
            WHERE { <%s> arcas:hasOutput ?out .
            ?out arcas:isCombinedToParam ?param_out .
            ?param_out rdfs:label ?label_out .
            OPTIONAL {
            ?param_out rdfs:isDefinedBy ?definition_out .
            }
            }
            """ % (svc)
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result = tupleQuery.evaluate()
            with result:
                for binding_set in result:
                    agg_out = binding_set.getValue("out")
                    param_out = binding_set.getValue("param_out")
                    label_out = binding_set.getValue("label_out")
                    definition_out = binding_set.getValue("definition_out")
                    fd_o = 0
                    for output_scan in outputs:
                        if agg_out == output_scan[0]:
                            fd_o = 1
                    if fd_o == 0:
                        outputs.append([agg_out,param_out,label_out,definition_out])
            queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>                                                      
            PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>       
            PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>               
            PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>                                     
            SELECT DISTINCT ?in ?param_in ?in_definition ?in2 ?param_in2 ?in2_definition ?in3 ?param_in3 ?in3_definition
            WHERE
            {
            OPTIONAL {                                                                                                                              
                <%s> arcas:hasInput ?in .                                                                                                        
                ?in arcas:isCombinedToParam ?param_in .
                ?param_in rdfsns:isDefinedBy ?in_definition . 
            }                                                                                                             
            OPTIONAL { 
                <%s> service:presents ?firstprofile .
                ?firstprofile  arcas:hasInput ?in2 .
                ?in2 arcas:isCombinedToParam ?param_in2 .
                ?param_in2 rdfsns:isDefinedBy ?in2_definition .
            }
            OPTIONAL {
            <%s> profile:hasInput ?in3 .
            ?in3 arcas:isCombinedToParam ?param_in3 .
            ?param_in3 rdfsns:isDefinedBy ?in3_definition .
            }    
            }                                   
            """ % (svc, svc, svc)
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result = tupleQuery.evaluate()
            with result:
                for binding_set in result:
                    inp = binding_set.getValue("in")
                    param_in = binding_set.getValue("param_in")
                    inp2 = binding_set.getValue("in2")
                    param_in2 = binding_set.getValue("param_in2")
                    in_definition = binding_set.getValue("in_definition")
                    in2_definition = binding_set.getValue("in2_definition")
                    inp3 = binding_set.getValue("in3")
                    param_in3 = binding_set.getValue("param_in3")
                    in3_definition = binding_set.getValue("in3_definition")
                    fd_1 = 0
                    fd_2 = 0
                    fd_3 = 0
                    for input_scan in inputs:
                        if inp == input_scan[0]:
                            fd_1 = 1
                        if inp2 == input_scan[0]:
                            fd_2 = 1
                        if inp3 == input_scan[0]:
                            fd_3 = 1
                    if fd_1 == 0 :
                        inputs.append([inp,param_in,in_definition])
                    if fd_2 == 0 :
                        inputs.append([inp2,param_in2,in2_definition])
                    if fd_3 == 0:
                        inputs.append([inp3,param_in3,in3_definition])
            fd_svc = 0
            for svc_scan in self.operations:
                if svc_scan[0] == svc:
                    fd_svc = 1
            if fd_svc == 0:
                self.operations.append([svc,soft_profile,soft,address,url,service_description,outputs,inputs])
            log.debug("Removing "+svc+" from the list of input services")
            log.debug("Operations:")
            log.debug(self.operations)
            self.tested_services.append(svc)
            self.list_inputs_svc.remove(svc)
            for elt in new_list_svc:
                if elt not in self.tested_services:
                    log.debug("Adding:"+str(elt)+" to services list")
                    self.list_inputs_svc.append(elt)
        return new_step_found
    def return_suggestions(self):
        """
        This function goes through the dictionaries
        containing functionalities found in the ontology and
        returns the more relevant following the http request and
        the smilarity trigger self.close_enough
        """
        labeled_returns = []
        for key in self.concepts_dict:
            label = self.concepts_dict[key][1].encode('ascii', 'ignore').decode('ascii')
            if label in labeled_returns:
                continue
            else:
                labeled_returns.append(label)
            definition = self.concepts_dict[key][2].encode('ascii', 'ignore').decode('ascii')
            alternative = str(self.concepts_dict[key][3].encode('utf-8'))
            library = self.concepts_dict[key][4].encode('ascii', 'ignore').decode('ascii').split("#")[1].replace(">",
                                                                                                                 "")
            svc = self.concepts_dict[key][5].encode('ascii', 'ignore').decode('ascii').split("#")[1].replace(">", "")
            log.debug("Compare: " + self.Iseek + " with " + label)
            temp_label_score = StringDist.compare(self.Iseek, label)
            log.debug(temp_label_score)
            log.debug("Compare: " + self.Iseek + " with " + definition)
            temp_definition_score = StringDist.compare(self.Iseek, definition)
            log.debug(temp_definition_score)
            log.debug("Compare: " + self.Iseek + " with " + alternative)
            temp_alternative_score = StringDist.compare(self.Iseek, alternative)
            log.debug(temp_alternative_score)
            if temp_label_score > self.close_enough \
                    or temp_definition_score > self.close_enough \
                    or temp_alternative_score > self.close_enough:
                print("<service>")
                print("<label>" + label + "</label>")
                print("<definition>" + definition + "</definition>")
                print("<alternative>" + alternative + "</alternative>")
                print("<library>" + library + "</library>")
                print("<svc>" + svc + "</svc>")
                print("</service>")
    
    def backward_chain(self):
        """
        Backward chaining part of services composition, allowing multiple 
        inputs for a single service call.
        """
        line_back = 0
        new_list_svc = []
        log.debug("Entering backward chaining process")
        for service in self.operations:
            log.debug(str(service))
            svc = str(service[0])
            if svc in self.back_tested_services:
                continue
            else:
                self.back_tested_services.append(svc)
            inpt = str(service[5])
            log.debug("service: "+svc+" input: "+inpt)
            queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>                                                
            SELECT DISTINCT ?input
            WHERE { <%s> profile:hasInput ?input .}""" % (svc.replace("<","").replace(">",""))
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result = tupleQuery.evaluate()
            with result:
                for binding_set in result:
                    inpt = str(binding_set.getValue("input")).replace("<","").replace(">","")
                    log.debug("input found:"+inpt)
                    if inpt != "None":
                        inputs = []
                        outputs = []
                        queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>                                    
                        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>                                                     
                        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
                        PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>                                                                    
                        SELECT DISTINCT ?service  
                        WHERE { ?service arcas:hasOutput <%s> .}""" % (inpt)
                        log.debug(queryString)
                        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
                        result = tupleQuery.evaluate()
                        with result:
                            for binding_set in result:
                                service = str(binding_set.getValue("service")).replace("<","").replace(">","")
                                line_back = 1
                                log.debug("Service found:"+service)
                                queryString = """
                                PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
                                PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
                                PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
                                PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>
                                SELECT DISTINCT ?soft_profile ?soft ?address ?url ?service_description                                                                                               WHERE {                                                                                                                                                              <%s> service:presents ?firstprofile .                                                                                                                                ?firstprofile profile:textDescription ?description .                                                                                                                 ?firstprofile arcas:hasQuerySoftware ?soft_profile .                                                                                                                 OPTIONAL {?soft_profile rdfsns:label ?soft .}                                                                                                                        <%s> arcas:isAccessedThrough ?address .                                                                                                                              ?address rdfsns:isDefinedBy ?url .                                                                                                                                   <%s> service:presents ?firstprofile .                                                                                                                                ?firstprofile profile:textDescription ?service_description .                                                                                                         }                                                                                                                                                                    """ % (service, service, service)
                                log.debug(queryString)
                                tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
                                result = tupleQuery.evaluate()
                                with result:
                                    for binding_set in result:
                                        soft_profile = binding_set.getValue("soft_profile")
                                        soft = binding_set.getValue("soft")
                                        address = binding_set.getValue("address")
                                        url = binding_set.getValue("url")
                                        service_description = binding_set.getValue("service_description")
                                        queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
                                        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
                                        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
                                        PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>
                                        SELECT DISTINCT ?in ?param_in ?in2 ?param_in2 ?in_definition ?in2_definition ?in3 ?param_in3 ?in3_definition
                                        WHERE                                                                                                                        
                                        {
                                        OPTIONAL {                                                                                                                                                            <%s> arcas:hasInput ?in .                                                                                                                                            ?in arcas:isCombinedToParam ?param_in .                                                                                                                              ?param_in rdfsns:isDefinedBy ?in_definition .                                                                                                                        }                                                                                                                                                                    OPTIONAL {                                                                                                                                                           <%s> service:presents ?firstprofile .                                                                                                                                ?firstprofile  arcas:hasInput ?in2 .                                                                                                                                 ?in2 arcas:isCombinedToParam ?param_in2 .                                                                                                                            ?param_in2 rdfsns:isDefinedBy ?in2_definition .      
                                        }
                                        OPTIONAL {
                                        <%s> profile:hasInput ?in3 .
                                        ?in3 arcas:isCombinedToParam ?param_in3 .
                                        ?param_in3 rdfsns:isDefinedBy ?in3_definition .
                                        }     
                                        }               
                                        """ % (service, service, service)
                                        log.debug(queryString)
                                tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
                                result = tupleQuery.evaluate()
                                with result:
                                    for binding_set in result:
                                        inp = binding_set.getValue("in")
                                        param_in = binding_set.getValue("param_in")
                                        inp2 = binding_set.getValue("in2")
                                        param_in2 = binding_set.getValue("param_in2")
                                        in_definition= binding_set.getValue("in_definition")
                                        in2_definition= binding_set.getValue("in2_definition")
                                        inp3 = binding_set.getValue("in3")
                                        param_in3 = binding_set.getValue("param_in3")
                                        in3_definition = binding_set.getValue("in3_definition")
                                        inputs.append([inp,param_in,in_definition])
                                        inputs.append([inp2,param_in2,in2_definition])
                                        inputs.append([inp3,param_in3,in3_definition])
                                queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
                                PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
                                PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>                                                               
                                PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>                                       
                                SELECT DISTINCT ?out ?param_out ?label_out ?definition_out 
                                WHERE {                       
                                <%s> arcas:hasOutput ?out .
                                ?out arcas:isCombinedToParam ?param_out .
                                ?param_out rdfs:label ?label_out . 
                            OPTIONAL {
                                ?param_out rdfs:isDefinedBy ?definition_out .
                                }
                                }                                                                                                
                                """ % (service)
                                log.debug(queryString)
                                tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
                                result = tupleQuery.evaluate()
                                with result:
                                    for binding_set in result:
                                        agg_out = binding_set.getValue("out")
                                        param_out = binding_set.getValue("param_out")
                                        label_out = binding_set.getValue("label_out")
                                        definition_out = binding_set.getValue("definition_out")
                                        outputs.append([agg_out,param_out,label_out,definition_out])
                                fd_svc = 0
                                for svc_scan in self.operations:
                                    if svc_scan[0] == service:
                                        fd_svc = 1
                                if fd_svc == 0:
                                    self.operations.append([service,soft_profile,soft,address,url,service_description,outputs,inputs])
        return line_back


    def switch_case(self):
        """
        Calls the appropriate methods following 
        the use-case sent through http request
        """
        if self.usecase == "seek_operations":
            self.get_definitions()
            self.get_metadatas()
            self.render_best_data()
            for key in self.final_services:
                log.debug("cle final services:"+str(key).lstrip("<").rstrip(">"))
                self.list_inputs_svc.append(str(key).lstrip("<").rstrip(">"))
                break
            log.debug("Call get_operations")
            while self.get_operations() == 1:
                log.info("New operation Found")
                self.get_operations()
        log.info("No further operation")
        back_sack = 1
        while (back_sack):
            back_sack = self.backward_chain()
        log.info("Backward chaining comlplete")
        self.send_response()
        if self.usecase == "data":
            self.get_definitions()
            self.get_metadatas()
            self.render_best_data()
            self.send_response()
        if self.usecase == "functionality":
            self.get_implemented_operations_and_algos()
            self.return_suggestions()
        if self.usecase == "generic":
            self.get_general_topics()
        if self.usecase == "dataClaim":
            self.data_claim() 
    
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
            if "root_allegro = " in line and case == "ontologies":
                self.rootallegro = str(line.split("root_allegro = ")[1].replace("\n",""))
            if "onto_suffix = " in line and case == "ontologies":
                self.onto_suffix = str(line.split("onto_suffix = ")[1].replace("\n",""))
            if "host_port = "  in line and case == "dataverse":
                self.dataport = str(line.split("host_port = ")[1].replace("\n",""))
            if "host_url = "  in line and case == "dataverse":
                self.dataurl = str(line.split("host_url = ")[1].replace("\n",""))
            
    def __init__(self):
	
        try:
            os.system("rm ../logs/allegro_fcts.log")
        except:
            pass
        log.basicConfig(filename='../logs/allegro_fcts.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.read_config()
        self.form = cgi.FieldStorage()
        self.usecase = str(self.form.getvalue("case"))
        repo = str(self.form.getvalue("repo"))
        self.usecase = str(self.form.getvalue("case"))
        self.input_svc = str(self.form.getvalue("dataset"))
        self.list_inputs_svc = []
        self.list_inputs_svc.append(self.input_svc)
        self.Iseek = str(self.form.getvalue("query"))
        self.service = str(self.form.getvalue("service"))
        self.qual = str(self.form.getvalue("query"))
        self.output_svc = ""
        self.statement = "NONE"
        self.publisher = "Unknown"
        self.description = ""
        self.data_desc = "Not provided"
        self.csv_file = "general_file.csv"
        self.general_file = open("../html/TempFiles/" + self.csv_file, 'w')
        self.concepts_dict = {}
        self.data_dict = {}
        self.metadata_dict = {}

        self.operations = []
        self.citation = []
        self.publisher = []
        self.final_services = []
        self.citation = []
        self.services = []
        self.tested_services = []
        self.back_tested_services = []
        self.send_header()
        if repo == "all":
            log.debug("Seeking available repositories in catalog")
            server = AllegroGraphServer(host=self.host, port=self.port, user=self.user, password=self.password)
            catalog = server.openCatalog('')
            # log.info("Available repositories in catalog '%s':" % catalog.getName())
            # log.info("Available repositories in catalog:" % str(catalog.listRepositories()))
            for repo_name in catalog.listRepositories():
                self.repository = repo_name
                self.myont = self.rootiri + self.repository + ".rdf"
                log.debug("querying repo: " + str(repo_name))
                self.repo = self.open_connection(repo_name)[0]
                self.conn = self.open_connection(repo_name)[1]
                self.switch_case()
                # self.send_response()
                self.close_connection()
        else:
            self.repository = repo
            self.myont = self.rootiri + self.repository + ".rdf"
            self.repo = self.open_connection(repo)[0]
            self.conn = self.open_connection(repo)[1]
            self.switch_case()
            # self.send_response()
            self.close_connection()
        self.general_file.close()
        self.send_footer()


browse = Allegro()
