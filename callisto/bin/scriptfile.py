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
import ReadConfig

readconf = ReadConfig()
timer = str(time.time())
form = cgi.FieldStorage()
outputs = str(form.getvalue("outputs"))

inp = str(form.getvalue("MyNewTerm16").replace(readconf.portalhost,'..'+readconf.portalhtml+readconf.portaltemp))
... your script goes here ...
myresult = "Result of your script (either file or any kind of variable such as array, string, float...)"

print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<"+outputs+">"+myresult+"</"+outputs+">\n")
print ("</options>\n")
