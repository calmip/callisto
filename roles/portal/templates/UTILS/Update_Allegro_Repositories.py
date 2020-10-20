<<<<<<< HEAD
#! /usr/bin/python3.6m
# -*- coding: utf-8 -*-
=======
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

>>>>>>> 64e825357351fa9fa663e196514929b787f3605c
import DataSetsToAllegro
update = DataSetsToAllegro.DatasetsToOntology()
results = update.get_details()
update.update_ontology(results)
<<<<<<< HEAD
=======
update.close_connection()
>>>>>>> 64e825357351fa9fa663e196514929b787f3605c

