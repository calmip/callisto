#! /usr/bin/python3
# -*- coding: utf-8 -*-
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
import cgi
import ReadConfig
import os
readconf = ReadConfig.ReadConfig()
form = cgi.FieldStorage()
outputs = str(form.getvalue("outputs"))

inp = str(form.getvalue("textualcontent").replace(readconf.portalhost+readconf.portaltemp,'../html/'+readconf.portaltemp))
input_file = open(inp,'r',encoding="utf-8")

# ------- Beginning of your script. You may change things from here
import sys
dic = {}
for line in input_file.readlines():
    splitted = line.split(" ")
    for word in splitted:
        count = len(word.replace("\n","").replace(",",""))
        if count in dic.keys():
            dic[count] += 1
        else:
            dic[count] = 1
results_file = open('ExempleService1_results.txt','w')
for key in dic:
    results_file.write(str(key)+":"+str(dic[key])+"\n")

# ------- Ending of your script. You should not change things after this line

os.system("mv ExempleService1_results.txt ../html/"+readconf.portaltemp+"ExempleService1_results.txt")
print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<"+outputs+">"+readconf.portalhost+readconf.portaltemp+"ExempleService1_results.txt</"+outputs+">\n")
print ("</options>\n")
