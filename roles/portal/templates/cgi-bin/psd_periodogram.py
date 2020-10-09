#! /usr/bin/python3.6m 
# -*- coding: latin-1 -*-

import cgi
import os
import time
import logging as log
os.system("rm fft.log")
log.basicConfig(filename='periodogram.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
timer = str(time.time())

form = cgi.FieldStorage()
#C_p is the end of URI identifying the concept in the ontology that is the INPUT of our service.
# We need to know this URI.
inp = str(form.getvalue("Signal").replace('{{callisto_name}}.{{callisto_topdomainname}}/TempFiles/','./TempFiles/'))
outputs = str(form.getvalue("outputs"))

os.system("python3 ./psd_periodogram_source.py " + inp + ">> ../html/callisto/TempFiles/"+timer+".csv")
log.debug("python3 ./psd_periodogram_source.py " + inp + ">> ../html/callisto/TempFiles/"+timer+".csv")
print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<"+outputs+">{{callisto_name}}.{{callisto_topdomainname}}/TempFiles/"+str(timer)+".csv</"+outputs+">\n")
print ("</options>\n")

