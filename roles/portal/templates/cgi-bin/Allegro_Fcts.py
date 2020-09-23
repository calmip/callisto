#! /usr/bin/python3.6m 
# -*- coding: latin-1 -*-
import StringDist
from franz.openrdf.sail.allegrographserver import AllegroGraphServer
from franz.openrdf.repository.repository import Repository
from franz.openrdf.vocabulary import RDF
from franz.openrdf.query.query import QueryLanguage
import cgi, os
import logging as log

class Allegro(object):
    """
    """
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
    
    def send_header(self):
        print ("Content-Type: text/xml\n")
        print ("<options>\n")
        print ("<case>"+self.usecase+"</case>")
        print("<csvschemafile>" + self.csv_file + "</csvschemafile>\n")
    def send_footer(self):
        print ("</options>")

    def send_response(self):
        """
        Construit le document xml resultat et le passe a l'interface .js (par print).
        """
        if self.usecase == "seek_operations":
            self.general_file.write("source,target\n")
            nom_svc = self.input_svc.replace(">","").replace("<","").split("#")[1]
            url_soft = self.get_soft_and_url("<"+self.input_svc+">")
            try:
                soft = str(url_soft[0]).replace(">","").replace("<","").replace("\"","")
                url = str(url_soft[1])
                out_svc = str(self.operations[0][4]).replace(">","").replace("<","").split("#")[1]
                out_svc_definition = str(self.operations[0][6]).replace(">","").replace("<","")
                svc_definition = str(self.operations[0][7]).replace(">","").replace("<","")
                print ("<service>\n")
                print ("<url>"+url+"</url>\n")
                print ("<soft>"+soft+"</soft>\n")
                print ("<ontology_id>"+self.input_svc.replace(">","").replace("<","")+"</ontology_id>\n")
                print ("<nom>S0</nom>\n")
                print ("<output>"+out_svc+"</output>\n")
                print ("<output_definition>"+out_svc_definition+"</output_definition>\n")
                print ("<information>ToBD</information>\n")
                print ("<definition>ToBD</definition>\n")
                print ("<profdef>"+svc_definition+"</profdef>\n")
            except:
                print ("<service>\n")
                print ("<url>void</url>\n")
                print ("<soft>void</soft>\n")
                print ("<ontology_id>"+self.input_svc.replace(">","").replace("<","")+"</ontology_id>\n")
                print ("<nom>S0</nom>\n")
                print ("<output>void</output>\n")
                print ("<output_definition>void</output_definition>\n")
                print ("<information>ToBD</information>\n")
                print ("<definition>ToBD</definition>\n")
                print ("<profdef>void</profdef>\n")
                out_svc_definition = ""
            self.general_file.write("service:S0,"+out_svc_definition.replace(">","").replace("<","").split("#")[1]+"\n")
            try:
                in_svc = self.operations[0][5].replace(">","").replace("<","").split("#")[1]
                print ("<input>"+str(self.operations[0][5]).replace(">","").replace("<","").split("#")[1]+"</input>\n")
                print ("<input_definition>"+str(self.operations[0][5]).replace(">","").replace("<","").split("#")[1]+"</input_definition>\n")
                self.general_file.write(in_svc+",service:S0\n")
            except:
                try:
                    in_svc = str(self.operations[0][5]).replace(">","").replace("<","").split("#")[1]
                    print ("<input>"+str(self.operations[0][5]).replace(">","").replace("<","").split("#")[1]+"</input>\n")
                    print ("<input_definition>"+str(self.operations[0][5]).replace(">","").replace("<","").split("#")[1]+"</input_definition>\n")
                    self.general_file.write(in_svc+","+"service:S0\n")
                except:
                    print ("<input>void</input>\n")
                    print ("<input_definition>void</input_definition>\n")
                
            print ("</service>\n")
            cpt_op = 0
            for operation in self.operations:
                cpt_op += 1
                url_soft = self.get_soft_and_url(operation[0])
                soft = str(url_soft[0]).replace(">","").replace("<","").replace("\"","")
                url = str(url_soft[1])
                out_svc_definition = str(operation[6]).replace(">","").replace("<","").replace('\"','')
                print ("<service>\n")
                print ("<url>"+url+"</url>\n")
                print ("<soft>"+soft+"</soft>\n")
                print ("<ontology_id>"+str(operation[0]).replace(">","").replace("<","")+"</ontology_id>\n")
                print ("<nom>S"+str(cpt_op)+"</nom>\n")
                print ("<information>"+str(operation[1]).replace(">","").replace("<","")+"</information>\n")
                print ("<output>"+str(operation[1]).replace(">","").replace("<","").split("#")[1]+"</output>\n")
                print ("<input>"+str(operation[4]).replace(">","").replace("<","").split("#")[1]+"</input>\n")
                try:
                    print ("<input_definition>"+ out_svc_definition.split("#")[1]+"</input_definition>\n")
                except:
                    print ("<input_definition>"+ out_svc_definition+"</input_definition>\n")
                try:
                    print ("<output_definition>"+str(operation[2].encode('utf8')).replace(">","").replace("<","")+"</output_definition>\n")
                except:
                    print ("<output_definition>"+str(operation[1]).replace(">","").replace("<","").split("#")[1]+"</output_definition>\n") 
                print ("<profdef>"+str(operation[3])+"</profdef>\n")
                nom_svc = str(operation[0]).replace(">","").replace("<","").split("#")[1]
                out_svc = str(operation[2]).replace(">","").replace("<","")
                in_svc = str(operation[6]).replace(">","").replace("<","")
                self.general_file.write("service:S"+str(cpt_op)+","+out_svc+"\n")
                try:
                    self.general_file.write(in_svc.split("#")[1]+","+"service:S"+str(cpt_op)+"\n")
                except:
                    self.general_file.write(in_svc+","+"service:S"+str(cpt_op)+"\n")
                print ("</service>\n")
        if self.usecase == "generic":            
            for key in self.services:
                print ("<service>\n")
                print ("<nom>"+key.replace(">","").replace("<","")+"</nom>\n")
                log.info("<generic statement>"+str(self.services[key][0]).replace("&","&amp;").replace(">","").replace("<","")+"</statement>")
                print ("<statement>"+str(self.services[key][0]).replace("&","&amp;").replace(">","").replace("<","")+"</statement>\n")
                print ("<claim>"+str(self.services[key][2]).replace(">","").replace("<","")+"</claim>\n")
                print ("</service>\n")
        if self.usecase == "data":
            sent=[]
            for key in self.final_services:
                if str(key) not in sent:
                    log.debug("send_response:"+str(key))
                    url_soft = self.get_soft_and_url(str(key))
                    soft = str(url_soft[0])
                    url = str(url_soft[1])
                    description = str(url_soft[2])
                    print ("<service>\n")
                    print ("<nom>\""+str(key).lstrip("<").rstrip(">")+"\"</nom>\n")
                    print ("<description>"+str(description.encode('utf8')).replace("\\n","").replace("\\r","").replace("\\","")+"</description>\n")
                    print("<soft>"+soft+"</soft>\n")
                    print("<url>"+url+"</url>")
                    print ("</service>\n")
                sent.append(str(key))     
        if self.usecase == "getDetails":
            print ("<service>\n")
            log.info("<statement Getdetails>"+self.statement+"</statement>")
            print ("<statement>"+self.statement+"</statement>\n")
            print ("<publisher>"+self.publisher+"</publisher>\n")
            print ("<description>"+str(self.description.encode('utf8'))+"</description>\n")
            print ("<datadesc>"+self.data_desc+"</datadesc>\n")
            print ("</service>\n")
        if self.usecase == "functionality":
            for key in self.services:
                print ("<service>\n")
                print ("<nom>"+str(key)+"</nom>\n")
                print ("</service>\n")
        if self.usecase == "about":
            print ("<service>\n")
            for cit in self.citation:
                print ("<citation>"+str(cit)+"</citation>\n")
            for pub in self.publisher:
                print ("<publisher>"+str(pub)+"</publisher>\n")
            print ("</service>\n")
        if self.usecase == "dataClaim":
            print ("<service>\n")
            print ("<url>"+self.url+"</url>\n")
            print ("</service>\n")

    

    def get_general_topics(self):
        """
        Returns claims identified by their sentences, or semantic qualifiers
        best fitting the loose query expressed by the user
        """
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX myont: <https://{{callisto_name}}.{{callisto_topdomainname}}/%s.rdf#>
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
        }""" % (self.repository)
        log.debug(queryString)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        #print(result)
        statements = []
        citations = []
        qualifiers = []
        list_bindings = {}
        ok_claims = []
        with result:
            for binding_set in result:
                #print("<service>")
                log.debug(binding_set)
                citation = str(binding_set.getValue("cit"))
                statement = str(binding_set.getValue("statement"))
                qualifier = str(binding_set.getValue("qualifier"))
                qual =  str(binding_set.getValue("qual"))
                #service = str(binding_set.getValue("service"))
                claim = str(binding_set.getValue("claim")).split("#")[1].replace(">","")
                log.debug("claim: " + claim)
                log.debug("Iseek: " + self.Iseek)
                temp_statement_score = StringDist.compare(statement, self.Iseek)
                temp_qualifier_score = StringDist.compare(qualifier, self.Iseek)
                log.debug("statement: " + statement + " score: " + str(temp_statement_score))
                log.debug("qualifier: " + qualifier  + " score: " + str(temp_qualifier_score))
                #This is a loose query. We don't need the closer match, but every match considered close enough.
                if temp_statement_score > self.close_enough or temp_qualifier_score > self.close_enough :
                    log.debug(ok_claims)
                    ok_claims.append(claim)
                    log.debug(ok_claims)
                #print("</service>")
        for claim in ok_claims:
            log.debug(claim)
            queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            PREFIX myont: <https://{{callisto_name}}.{{callisto_topdomainname}}/%s.rdf#>
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
            ?dataurl rdf:type	arcas:AccessUrl.
            ?dataurl rdfs:isDefinedBy ?dataval.
            }""" % (self.repository,claim,claim,claim)
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result2 = tupleQuery.evaluate()
            qualifiers = []
            print("<service>")
            for binding_set in result2:
                #log.debug(binding_set)
                citation = str(binding_set.getValue("cit"))
                statement = str(binding_set.getValue("statement"))
                qualifier = str(binding_set.getValue("qualifier"))
                qual =  str(binding_set.getValue("qual")).replace("\"","")
                url = str(binding_set.getValue("url"))
                dataval = str(binding_set.getValue("dataval"))
                print("<claim>"+claim+"</claim>")
                print("<statement>"+statement+"</statement>")
                print("<citation>"+citation.encode('ascii', 'ignore').decode('ascii').replace("&"," and ")+"</citation>")
                try:
                    print("<qualifier>"+qualifier.split("#")[1].replace("<","").replace(">","")+"</qualifier>")
                except:
                    print("<qualifier>"+qualifier+"</qualifier>")
                try:
                    filtered_qual = qual.split("#")[1].replace("<","").replace(">","")
                    if filtered_qual in qualifiers:
                        continue
                    else:
                        print("<qual>"+qual.split("#")[1].replace("<","").replace(">","")+"</qual>")
                        qualifiers.append(filtered_qual)
                except:
                    if qual in qualifiers:
                        continue
                    else:
                        print("<qual>"+qual+"</qual>")
                        qualifiers.append(qual)
                print("<url>"+url.replace("https://{{callisto_name}}.{{callisto_topdomainname}}","")+"</url>")
                print("<urldata>"+dataval+"</urldata>")
            print("</service>")
                
        return
                            
    def get_implemented_operations_and_algos(self):
        """
        Renvoie les definitions, termes alternatifs et labels des concepts
        representant des operations / algorithmes /process de l'ontologie
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
        result = tupleQuery.evaluate();
        log.debug(queryString)
        with result:
            for binding_set in result:
                count += 1
                self.concepts_dict[count]=["","" ,"" , "", "", ""]
                concept = str(binding_set.getValue("concept"))
                self.concepts_dict[count][0] = concept
                label = str(binding_set.getValue("label"))
                self.concepts_dict[count][1] = label
                definition = str(binding_set.getValue("definition"))
                self.concepts_dict[count][2] = definition
                alternative = str(binding_set.getValue("alternative"))
                self.concepts_dict[count][3] = alternative
                library =  str(binding_set.getValue("library"))
                self.concepts_dict[count][4] = library
                svc =  str(binding_set.getValue("svc"))
                self.concepts_dict[count][5] = svc
                #print("%s %s %s %s" % (concept, label, definition, alternative))
    def get_operations_and_algos(self):
        """
        Renvoie les definitions, termes alternatifs et labels des concepts
        representant des operations / algorithmes /process de l'ontologie
        """
        count = 0
        # * makes the request transitive: subClassOf explores every subclass of specified class
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
        PREFIX edamontology: <http://edamontology.org/>
        PREFIX obo: <http://purl.obolibrary.org/obo/>
        PREFIX arcas:<http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        SELECT DISTINCT ?concept ?label ?definition ?alternative
        WHERE { 
        {?concept rdfs:subClassOf* edamontology:operation_0004.
        ?concept oboInOwl:hasDefinition ?definition.?concept rdfs:label ?label.}
        UNION {?concept rdfs:subClassOf* obo:BFO_0000007. 
        OPTIONAL {?concept obo:IAO_0000115 ?definition.} 
        OPTIONAL {?concept obo:IAO_0000118 ?alternative.}
        OPTIONAL {?concept rdfs:label ?label.}} 
        UNION {?concept rdfs:subClassOf* obo:IAO_0000064. 
        OPTIONAL {?concept obo:IAO_0000115 ?definition.}
        OPTIONAL {?concept rdfs:label ?label.}
        OPTIONAL {?concept obo:IAO_0000118 ?alternative.}}
        UNION {?svc arcas:hasOperation ?operation.
              ?operation rdfs:isDefinedBy ?definition.
               OPTIONAL {?operation rdfs:label ?label.}
              }}"""
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate();
        log.debug(queryString)
        with result:
            for binding_set in result:
                count += 1
                self.concepts_dict[count]=["","" ,"" , ""]
                concept = str(binding_set.getValue("concept"))
                self.concepts_dict[count][0] = concept
                label = str(binding_set.getValue("label"))
                self.concepts_dict[count][1] = label
                definition = str(binding_set.getValue("definition"))
                self.concepts_dict[count][2] = definition
                alternative = str(binding_set.getValue("alternative"))
                self.concepts_dict[count][3] = alternative
                #print("%s %s %s %s" % (concept, label, definition, alternative))

    def render_best_data(self):
        """
        """
        definition_score = 0
        best_definition = 0
        best_definition_key = 0
        output_score = 0
        best_output = 0
        best_output_key = 0
        keyword_score = 0
        best_keyword = 0
        best_keyword_key = 0
        self.output_svc = self.Iseek
        tested = []
        for key in self.data_dict:
            log.debug("key:"+str(key))
            val = str(str(self.data_dict[key]).encode('utf-8'))
            log.debug("value:"+val)
            if self.data_dict[key][1] in tested:
                continue
            tested.append(self.data_dict[key][1])
            to_compare = str(str(self.data_dict[key][1]).encode('utf-8')).replace(">","").replace("<","").replace(self.myont,"")
            temp_definition_score = StringDist.compare(self.Iseek, to_compare)
            log.debug("for data definition compare: "+self.Iseek+" with: "+to_compare+" score: "+str(temp_definition_score))
            log.debug("lowered:"+self.Iseek.lower())
            log.debug("lowered"+to_compare.lower())
            if self.Iseek.lower() in to_compare.lower() and temp_definition_score < 0.5:
                log.debug("Match found. Setting sim to 0.5") 
                temp_definition_score = 0.5
                if self.data_dict[key][0] not in  self.final_services:
                    self.final_services.append(self.data_dict[key][0])
            #print("for data definition compare: "+self.Iseek+" with: "+str(self.data_dict[key][1])+" score: "+str(temp_definition_score))
            if temp_definition_score > definition_score :
                definition_score = temp_definition_score
                if definition_score > best_definition:
                    best_definition_key = key
                    best_definition = definition_score
                    

            to_compare = str(str(self.data_dict[key][4]).encode('utf-8')).replace(">","").replace("<","").replace(self.myont,"")
            temp_output_score = StringDist.compare(self.Iseek, to_compare)
            log.debug("for data otuput compare: "+self.Iseek+" with: "+to_compare+" score: "+str(temp_output_score))
            #print("for data definition compare: "+self.Iseek+" with: "+str(self.data_dict[key][4])+" score: "+str(temp_output_score))
            if temp_output_score > output_score :
                output_score = temp_output_score
                if output_score > best_output:
                    best_output_key = key
                    best_output = output_score
            
            to_compare = str(str(self.data_dict[key][2]).encode('utf-8')).replace(">","").replace("<","").replace(self.myont,"")
            temp_keyword_score = StringDist.compare(self.Iseek, to_compare)
            log.debug("for data keyword compare: "+self.Iseek+" with: "+to_compare+" score: "+str(temp_keyword_score))
            #print("for data keyword compare: "+self.Iseek+" with: "+str(self.data_dict[key][2])+" score: "+str(temp_keyword_score))
            if temp_keyword_score > keyword_score :
                keyword_score = temp_keyword_score
                if keyword_score > best_keyword:
                    best_keyword_key = key
                    best_keyword= output_score 
        try:
            best_choice = str(self.data_dict[best_keyword_key][0])
            log.debug("best choice candidate:"+best_choice)
            log.debug("Keyword best choice:" + best_choice)
            #print(("Keyword best choice:" +str(self.data_dict[best_keyword_key][0].replace("http://www.callisto.calmip.univ-toulouse.fr/callisto/ARCAS.rdf#", ""))))
            self.best_keyword_key = best_keyword_key
            if best_choice not in  self.final_services:
                self.final_services.append(best_choice)
        except:
            log.debug("No keyword related to this information")

        try:
            best_choice = str(self.data_dict[best_definition_key][0])
            log.debug("best choice candidate:"+best_choice)
            log.debug("Definition best choice:" + best_choice)
            
            self.best_definition_key = best_definition_key
            if best_choice not in  self.final_services:
                self.final_services.append(best_choice)
        except:
            log.debug("No definition related to this information")
        
        
    def get_soft_and_url(self, index):
        """
        gets software and url for service passed as index
        """
        queryString = """PREFIX myont: <https://{{callisto_name}}.{{callisto_topdomainname}}/%s.rdf#>
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
        }}""" %(self.repository,index,index,index)
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
                log.debug("description:"+str(description))
        return[soft, return_url,description]
    
    def handle_general_query(self):
        """
        """
        services = self.get_general_topics()
        log.debug (str(services))
        for key in services:
            if len(services[key][0]) > 0:
                log.debug("Statements linked to service:"+str(key)+" is: "+str(services[key][0]))
            if len(services[key][1]) > 0:
                for qualifier in range(len(services[key][1])):
                    value = services[key][1][qualifier]
                    log.debug("A qualifier retained for service:"+str(key)+" is: "+value)
                    queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\
                    PREFIX myont: <https://{{callisto_name}}.{{callisto_topdomainname}}/%s.rdf#>\
                    PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>\
                    PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>\
                    PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>\
                    PREFIX mp:<http://purl.org/mp/>\
                    SELECT DISTINCT ?statement ?claim\
                    WHERE { \
                    ?service arcas:hasOutput ?out.\
                    ?out arcas:isCombinedToParam ?param.\
                    ?param mp:supports ?claim.\
                    ?claim mp:statement ?statement.\
                    }" % (self.repository)
                    tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
                    result = tupleQuery.evaluate()
                    with result:
                        for binding_set in result:
                            claim =  str(binding_set.getValue("claim"))
                            statement = str(binding_set.getValue("statement"))
                            log.info(type(statement))
                            if statement not in services[key][2]:
                                services[key][2].append(claim)
                                
                            log.debug("This service states that:"+statement)
                            if statement not in services[key][0]:
                                services[key][0].append(statement)
                            
        self.services = services
        return

    def data_claim(self):
        """
        """
        log.debug("Constructing URL")
        queryString = """PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX myont: <https://{{callisto_name}}.{{callisto_topdomainname}}/%s.rdf#>
        PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
        PREFIX mp:<http://purl.org/mp/>
        SELECT DISTINCT ?svc ?desc ?param ?url ?soft 
        WHERE {
        myont:%s mp:qualifiedBy ?qual.
        ?svc arcas:hasOutput ?out.
        ?out arcas:isCombinedToParam ?qual.
       	?svc service:presents ?profile.
        ?profile profile:textDescription ?desc.
  	?profile arcas:hasInput ?input_agg.
        ?input_agg arcas:isCombinedToParam ?param.
        ?profile arcas:hasQuerySoftware ?soft.
        ?svc arcas:isAccessedThrough ?accessurl.
        ?accessurl rdfs:isDefinedBy ?url.
        }""" %(self.repository.upper(),self.claim)
        log.debug(queryString)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        dict_svcs = {}
        with result:
            for binding_set in result:
                list_param = []
                log.debug("exploring binding sets")
                service = binding_set.getValue("svc")
                log.debug(service)
                svc = str(service).split("#")[1].replace("<","").replace(">","")
                log.debug(svc)
                desc = str(binding_set.getValue("desc"))
                log.debug(desc)
                url = str(binding_set.getValue("url")).replace("192.168.0.233:8080","dataverse.callisto.calmip.univ-toulouse.fr").replace("\"","")
                log.debug(url)
                soft = str(binding_set.getValue("soft"))
                log.debug(soft)
                if svc not in dict_svcs:
                    dict_svcs[svc] = []
                    dict_svcs[svc].append(desc)
                    dict_svcs[svc].append(url)
                    dict_svcs[svc].append(soft)
                param = str(binding_set.getValue("param")).split("#")[1].replace("<","").replace(">","")
                log.debug(param)
                list_param.append(param)
            dict_svcs[svc].append(list_param)
        for key in dict_svcs:
            log.debug(key)
            print("<service>")
            print("<nom>"+key+"</nom>")
            print("<description>"+dict_svcs[key][0]+"</description>")
            print("<soft>"+dict_svcs[key][2]+"</soft>")
            print("<url>"+dict_svcs[key][1]+"</url>")
            params = dict_svcs[key][3]
            for param in params:
                 print("<input>"+param+"</input>")
            print("</service>")

    def about_claim(self):
        """
        """
        log.debug("Constructing URL")
        queryString = """
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>\
        PREFIX edamontology: <http://edamontology.org/>\
        PREFIX obo: <http://purl.obolibrary.org/obo/>\
        PREFIX myont: <https://{{callisto_name}}.{{callisto_topdomainname}}/%s.rdf#>\
        PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>\
        PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>\
        PREFIX mp:<http://purl.org/mp/>\
        SELECT DISTINCT ?citation ?publisher WHERE { \
        ?attribution mp:supports <%s>.\
        ?attribution mp:qualifiedBy ?ref.\
        ?ref mp:citation ?citation.\
        ?attribution mp:attributedTo ?pub.\
        ?pub rdfs:isDefinedBy ?publisher.}""" %(self.repository.upper(),self.claim)
        log.debug(queryString)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                citation = binding_set.getValue("citation")
                publisher = binding_set.getValue("publisher")
                
                if citation not in self.citation:
                    self.citation.append(citation)
                if publisher not in self.publisher:
                    self.publisher.append(publisher)
               
    def get_definitions(self):
        """
        Renvoie les definitions, termes alternatifs et labels des donnes
        representant des outputs de services dans l'ontologie
        """
        log.debug("Seeking data definitions")
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
        ?profile arcas:hasQuerySoftware "http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#get_dataset".
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
                #log.info("binding_set:"+str(binding_set))
                count += 1
                self.data_dict[count]=["", "", "", "", "", ""]
                self.data_dict[count][2]=binding_set.getValue("label")
                self.data_dict[count][1]=binding_set.getValue("description")
                self.data_dict[count][0]=binding_set.getValue("service")
                self.data_dict[count][4]=binding_set.getValue("output_definition")
                            
    def get_details(self):
        """
        gets details for service passed as index
        """
        queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\
        PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>\
        PREFIX edamontology: <http://edamontology.org/>\
        PREFIX obo: <http://purl.obolibrary.org/obo/>\
        PREFIX myont: <https://{{callisto_name}}.{{callisto_topdomainname}}/%s#.rdf>\
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
        ?claim mp:statement ?statement}}" %(self.repository,self.service,self.service)
        tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
        result = tupleQuery.evaluate()
        with result:
            for binding_set in result:
                self.statement  = binding_set.getValue("statement")
                self.publisher = binding_set.getValue("publisher")
                self.description = binding_set.getValue("description")
                self.data_desc = binding_set.getValue("datadesc")
        
    def get_operations(self):
        """
        """
        new_step_found = 0
        new_list_svc = []
        for svc in self.list_inputs_svc:
            queryString = """PREFIX profile: <http://www.daml.org/services/owl-s/1.2/Profile.owl#>
            PREFIX service: <http://www.daml.org/services/owl-s/1.2/Service.owl#>
            PREFIX arcas: <http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#>
            PREFIX rdfsns: <http://www.w3.org/2000/01/rdf-schema#>
            SELECT DISTINCT ?service ?information ?definition ?profdef ?param_out ?param_in ?label_first_out ?firstdef
            WHERE { 
            <%s> arcas:hasOutput ?out .
            <%s> service:presents ?firstprofile .
            OPTIONAL {
            ?firstprofile arcas:hasInput ?in2 .
            ?in2 arcas:isCombinedToParam ?param_in .
            }
            ?firstprofile profile:textDescription ?firstdef.
            ?out arcas:isCombinedToParam ?param_out .
            ?out arcas:isCombinedToFormat ?format_out .
            ?out arcas:isCombinedToUnit ?unit_out .
            ?param_out rdfsns:isDefinedBy ?label_first_out .
            ?service profile:hasInput ?out2 .
            ?out2 arcas:isCombinedToParam ?param_out .
            ?service arcas:hasOutput ?out3 .
            ?out3 arcas:isCombinedToParam ?information .
            ?information rdfsns:isDefinedBy ?definition.
            ?service service:presents ?profile .
            ?profile  profile:textDescription ?profdef.
            }""" % (svc,svc)
            log.debug(queryString)
            tupleQuery = self.conn.prepareTupleQuery(QueryLanguage.SPARQL, queryString)
            result = tupleQuery.evaluate()
            with result:
                for binding_set in result:
                    new_step_found = 1
                    service  = binding_set.getValue("service")
                    information = binding_set.getValue("information")
                    definition = binding_set.getValue("definition")
                    profdef =  binding_set.getValue("profdef")
                    input_svc = binding_set.getValue("param_out")
                    param_in = binding_set.getValue("param_in")
                    label_first_out = binding_set.getValue("label_first_out")
                    firstdef = binding_set.getValue("firstdef")
                    #self.operations.append([service,information,definition,profdef,input_svc,param_in,label_first_out,firstdef])
                    if str(service).replace("<","").replace(">","") not in self.tested_services:
                        new_list_svc.append(str(service).replace("<","").replace(">",""))
                        self.tested_services.append(str(service).replace("<","").replace(">",""))
                        self.operations.append([service,information,definition,profdef,input_svc,param_in,label_first_out,firstdef])
            self.list_inputs_svc.remove(svc)
        for elt in new_list_svc:
            self.list_inputs_svc.append(elt)
        return new_step_found
        
    def return_suggestions(self):
        """
        """
        labeled_returns = []
        for key in self.concepts_dict:
            label = str(self.concepts_dict[key][1].encode('utf-8'))
            label = self.concepts_dict[key][1].encode('ascii', 'ignore').decode('ascii')
            if label in labeled_returns:
                continue
            else:
                labeled_returns.append(label)
            definition = self.concepts_dict[key][2].encode('ascii', 'ignore').decode('ascii')
            alternative = str(self.concepts_dict[key][3].encode('utf-8'))
            library = self.concepts_dict[key][4].encode('ascii', 'ignore').decode('ascii').split("#")[1].replace(">","")
            svc = self.concepts_dict[key][5].encode('ascii', 'ignore').decode('ascii').split("#")[1].replace(">","")
            log.debug("Compare: "+self.Iseek+" with " + label)
            temp_label_score = StringDist.compare(self.Iseek,label)
            log.debug(temp_label_score)
            log.debug("Compare: "+self.Iseek+" with " + definition)
            temp_definition_score = StringDist.compare(self.Iseek,definition)
            log.debug(temp_definition_score)
            log.debug("Compare: "+self.Iseek+" with " + alternative)
            temp_alternative_score = StringDist.compare(self.Iseek,alternative)
            log.debug(temp_alternative_score)
            if temp_label_score > self.close_enough or temp_definition_score > self.close_enough or temp_alternative_score > self.close_enough:
                print("<service>")
                print("<label>"+label+"</label>")
                print("<definition>"+definition+"</definition>")
                print("<alternative>"+alternative+"</alternative>")
                print("<library>"+library+"</library>")
                print("<svc>"+svc+"</svc>")
                print("</service>")           
            
    
    def switch_case(self):
        """
        """ 
        if self.usecase == "seek_operations":
            log.debug("Call get_operations")
            while self.get_operations() == 1:
                self.get_operations()
            self.send_response()
            log.debug("Leaving switch")
        if self.usecase == "data":
            self.get_definitions()
            self.render_best_data()
            self.send_response()
        if self.usecase == "getDetails":
            self.get_details()
        if self.usecase == "functionality":
            self.get_implemented_operations_and_algos()
            self.return_suggestions()
        if self.usecase == "generic":
            self.get_general_topics()
        if self.usecase == "about":
            self.about_claim()
        if self.usecase == "dataClaim":
            self.data_claim()       
            
    def __init__(self):
        os.system("rm allegro_fcts.log")
        log.basicConfig(filename='allegro_fcts.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
        self.host = "192.168.0.80"
        self.port = 10035
        self.user = "callisto"
        self.password = "ouiouioui123"
        self.close_enough = 0.28
        self.form = cgi.FieldStorage()
        self.usecase = str(self.form.getvalue("case"))
        repo = str(self.form.getvalue("repo"))
        self.usecase = str(self.form.getvalue("case"))
        self.input_svc = str(self.form.getvalue("dataset"))
        self.list_inputs_svc = []
        self.list_inputs_svc.append(self.input_svc)
        self.Iseek = str(self.form.getvalue("query"))
        self.service = str(self.form.getvalue("service"))
        self.claim = str(self.form.getvalue("claim"))
        self.output_svc = ""
        self.statement = "NONE"
        self.publisher = "Unknown"
        self.description = ""
        self.data_desc = "Not provided"
        self.csv_file = "general_file.csv"
        self.general_file = open("../html/callisto/"+self.csv_file, 'w')
        self.concepts_dict = {}
        self.data_dict = {}
        
        self.operations=[]
        self.citation=[]
        self.publisher=[]
        self.final_services = []
        self.citation=[]
        self.services = []
        self.tested_services = []
        
        self.send_header()
        if repo == "all":
            log.debug("Seeking available repositories in catalog")
            server=AllegroGraphServer(host=self.host,port=self.port,user=self.user,password=self.password)
            catalog = server.openCatalog('')
            #log.info("Available repositories in catalog '%s':" % catalog.getName())
            #log.info("Available repositories in catalog:" % str(catalog.listRepositories()))
            for repo_name in catalog.listRepositories():
                self.repository = repo_name.upper()
                self.myont = "https://{{callisto_name}}.{{callisto_topdomainname}}"+self.repository+".rdf"
                log.debug("querying repo: "+str(repo_name))
                self.repo = self.open_connection(repo_name)[0]
                self.conn = self.open_connection(repo_name)[1]
                self.switch_case()
                #self.send_response()
                self.close_connection()
        else:
            self.repository = repo.upper()
            self.myont = "https://{{callisto_name}}.{{callisto_topdomainname}}"+self.repository+".rdf"
            self.repo = self.open_connection(repo)[0]
            self.conn = self.open_connection(repo)[1]
            self.switch_case()
            #self.send_response()
            self.close_connection()
        self.general_file.close()
        self.send_footer()

browse = Allegro()

