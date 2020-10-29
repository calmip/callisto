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

import math

gamma = 1.4 #heat capacity ratio
R = 287 # specific gas constant for air (in J.kg^(-1).K^(-1))
T = 261.2153 # freestream temperature (in K)
Ma = 0.78 # freestream mach number
cs = math.sqrt(gamma*R*T) # freestream speed of sound (in m/s)
U = Ma*cs # freestream flow velocity (in m/s)
c = 0.15 # chord length (in m)
Fc = 0
f0 = 15.6 # fundamental frequency (enter 0 to plot no harmonics)
harmNbr = 2 #  number of harmonics

