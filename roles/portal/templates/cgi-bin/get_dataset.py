#! /usr/bin/python3.6m 
# -*- coding: latin-1 -*-

import cgi
import os
import time

timer = str(time.time())

form = cgi.FieldStorage()
url = str(form.getvalue("url"))
outputs = str(form.getvalue("outputs"))
key =  str(form.getvalue("ApiKeyValue"))
os.system ("wget "+url+key+" --no-check-certificate -O TempFiles/"+timer)
os.system ("cp TempFiles/"+timer+" ../html/callisto/TempFiles")
print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<"+outputs+">https://callisto.calmip.univ-toulouse.fr/TempFiles/"+timer+"</"+outputs+">\n")
print ("</options>\n")
