#! /usr/bin/python3.6m 
# -*- coding: latin-1 -*-

import cgi
import os
import time
import logging as log
os.system("rm fft.log")
log.basicConfig(filename='fft.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
timer = str(time.time())

form = cgi.FieldStorage()
#C_p is the end of URI identifying the concept in the ontology that is the INPUT of our service.
# We need to know this URI.
#cp = str(form.getvalue("C_p").replace('https://callisto.calmip.univ-toulouse.fr/TempFiles/1598251892.130424','../callisto/TempFiles'))
inp = str(form.getvalue("Signal").replace('https://callisto.calmip.univ-toulouse.fr/TempFiles/','./TempFiles/'))
outputs = str(form.getvalue("outputs"))

os.system("python3 ./psd_fft_source.py " + inp + ">> ../html/callisto/TempFiles/"+timer+".csv")
log.debug("python3 ./psd_fft_source.py " + inp + ">> ../html/callisto/TempFiles/"+timer+".csv")
print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<"+outputs+">https://callisto.calmip.univ-toulouse.fr/TempFiles/"+str(timer)+".csv</"+outputs+">\n")
print ("</options>\n")

