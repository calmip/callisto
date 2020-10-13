#! /usr/bin/python3.6m
# -*- coding: latin-1 -*-
from franz.openrdf.sail.allegrographserver import AllegroGraphServer
from franz.openrdf.repository.repository import Repository
from rdflib import Namespace, URIRef, Literal
arcas = Namespace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#")
server=AllegroGraphServer(host="CallistoAllegro",port="{{allegro_port}}",user="{{allegro_user}}",password="{{allegro_password}}")
catalog = server.openCatalog('')
mode = Repository.ACCESS
repository = catalog.getRepository("demonstration",mode)
repository.initialize()
conn = repository.getConnection()
conn.addFile("/home/callisto/demonstration.nt",format="application/n-triples")
labels = conn.createURI("<http://www.w3.org/2000/01/rdf-schema#label>")
get_data = conn.createURI(arcas.get_dataset)
conn.add(get_data,"<http://www.w3.org/2000/01/rdf-schema#label>",Literal("get_dataset.py"))

