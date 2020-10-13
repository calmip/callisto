#! /usr/bin/python3.6m
# -*- coding: latin-1 -*-
import DataSetsToAllegro
update = DataSetsToAllegro.DatasetsToOntology()
results = update.get_details()
update.update_ontology(results)
update.close_connection()
