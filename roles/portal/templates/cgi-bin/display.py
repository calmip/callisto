#! /usr/bin/python3.6m 
# -*- coding: latin-1 -*-
import matplotlib.pyplot as plt
import csv
import cgi
import os
import time
import logging as log
import sys
import pandas as pd
import numpy as np


timer = str(time.time())

form = cgi.FieldStorage()
#C_p is the end of URI identifying the concept in the ontology that is the INPUT of our service.
# We need to know this URI.
inp = str(form.getvalue("PSD").replace('{{callisto_name}}.{{callisto_topdomainname}}','../html//callisto/TempFiles/'))
outputs = str(form.getvalue("outputs"))

fields = ['Frequence', 'Puissance']
df = pd.read_csv(inp, sep=',', usecols=fields)
F = df.Frequence
Pxx = df.Puissance

fig, axs = plt.subplots()
axs.loglog(F, Pxx, linewidth=0.5)
plt.savefig('../html/callisto/TempFiles/'+str(timer)+'.png')

print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<"+outputs+">{{callisto_name}}.{{callisto_topdomainname}}/TempFiles/"+str(timer)+".png</"+outputs+">\n")
print ("</options>\n")
