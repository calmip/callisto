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

import cgi
import os
import time
import logging as log
import ReadConfig

readconf = ReadConfig.ReadConfig()
timer = str(time.time())
os.system("rm "+readconf.portalog+"get_dataset.log")
os.system("touch "+readconf.portalog+"get_dataset.log")

#log.basicConfig(filename=readconf.portalog+'get_dataset.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')

form = cgi.FieldStorage()
url = str(form.getvalue("url")).replace("\"","")
outputs = str(form.getvalue("outputs"))
logfile=open(readconf.portalog+"get_dataset.log",'w')
logfile.write("\n url:"+url)
logfile.write("\n outputs:"+outputs)
#log.debug(url)
#log.debug(outputs)

key =  str(form.getvalue("ApiKey")).replace(" ","").replace("\"","")
ord = "wget "+url+key+" --no-check-certificate -O TempFiles/"+timer
ordre=ord.replace("None","")
#log.debug(ordre)
logfile.write("\n ordre:"+ordre)
os.system (ordre)
os.system ("cp TempFiles/"+timer+" .."+readconf.portalhtml+"TempFiles")
print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<"+outputs+">"+readconf.portalhost+readconf.portaltemp+timer+"</"+outputs+">\n")
print ("</options>\n")
logfile.close()
