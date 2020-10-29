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
from rdflib import Namespace, URIRef, Literal
from franz.openrdf.vocabulary import RDFS
arcas = Namespace("http://www.callisto.calmip.univ-toulouse.fr/ARCAS.rdf#")
server=AllegroGraphServer(host="CallistoAllegro",port="{{allegro_port}}",user="{{allegro_user}}",password="{{allegro_password}}")
catalog = server.openCatalog('')
mode = Repository.ACCESS
repository = catalog.getRepository("demonstration",mode)
repository.initialize()
conn = repository.getConnection()
conn.addFile("/home/callisto/demonstration.nt",format="application/n-triples")
