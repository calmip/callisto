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
