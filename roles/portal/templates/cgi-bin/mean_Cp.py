#! /usr/bin/python3.6m 
# -*- coding: latin-1 -*-

import cgi
import os
import time

timer = str(time.time())

form = cgi.FieldStorage()
#C_p is the end of URI identifying the concept in the ontology that is the INPUT of our service.
# We need to know this URI.
cp = str(form.getvalue("C_p").replace('{{callisto_name}}.{{callisto_topdomainname}}/TempFiles/1598251892.130424','../callisto/TempFiles'))
outputs = str(form.getvalue("outputs"))

output = os.system("python3 ./mean_Cp_source.py " + cp)
