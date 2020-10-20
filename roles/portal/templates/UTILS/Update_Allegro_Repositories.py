#! /usr/bin/python3.6m
# -*- coding: utf-8 -*-
import DataSetsToAllegro
update = DataSetsToAllegro.DatasetsToOntology()
results = update.get_details()
update.update_ontology(results)

