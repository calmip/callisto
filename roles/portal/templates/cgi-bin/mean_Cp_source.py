################################################################################################
# mean_Cp
# first written: 24/07/17
# last edited: 13/05/20
# author: Jean-Baptiste To
################################################################################################

#from pylab import *
import csv
import numpy as np
import math
import io
import os
import sys
import logging as log
os.system("rm mean_cp_source.log")
log.basicConfig(filename='mean_cp_source.log', level=log.DEBUG, format='%(levelname)s:%(asctime)s %(message)s ')
#Getting the input file
input_url = sys.argv[1] # e.g. MODELXXXXXXXXX__NAMEY_alfaZ.csv
os.system ("wget "+input_url+" --no-check-certificate -O "+input_url.replace("{{callisto_name}}.{{callisto_topdomainname}}/TempFiles/",""))
# Renaming files
input_file = input_url.replace("{{callisto_name}}.{{callisto_topdomainname}}/TempFiles/","")# e.g. MODELXXXXXXXXX__NAMEY_alfaZ.csv
log.info("input_file: "+input_file)
file_extension = input_file[input_file.rfind("."):] # whatever is after dot is the extension
base_name = input_file[input_file.find("__") + 2:-len(file_extension)]
# creating intermediary files for each step
output_file1 = base_name + "_test1" + file_extension #you get NAMEY_alfaZ_test1.csv
output_file2 = base_name + "_test2" + file_extension 
output_file3 = base_name + "_test3" + file_extension 
output_file4 = base_name + "_test4" + file_extension 
output_file5 = base_name + "_test5" + file_extension 

# First, remove all the unwanted rows containing character strings that are repeated throughout the file
strings_to_remove = ['X/C','Y/C','Z/C','TAP_NAME','KP','MX']

with open(input_file,'r') as oldfile, open(output_file1,'w') as newfile:
	for line in oldfile:
		if not any(strings_to_remove in line for strings_to_remove in strings_to_remove):
			newfile.write(line)

# Create another spreadsheet that contains the transposed array
Trans = zip(*csv.reader(open(output_file1,'r')))
csv.writer(open(output_file2,'w')).writerows(Trans)

# Create another spreadsheet containing all the previous data minus rows containing string "54626" - gets rid of invalid data
with open(output_file2,'r') as oldfile, open(output_file3,'w') as newfile:
	for line in oldfile:
		if '54626' not in line:
			newfile.write(line)

# Create another spreadsheet without first line which represents number of realizations
with open(output_file3,'r') as oldfile, open(output_file4,'w') as newfile:
	next(oldfile) # skip header line
	for line in oldfile:
		newfile.write(line)

# Create last spreadsheet containing all the previous data but transposed to recover same structure as initial data sheet.
Trans = zip(*csv.reader(open(output_file4,'r')))
csv.writer(open(output_file5,'w')).writerows(Trans)

# Remove all intermediary files
os.remove(output_file1)
os.remove(output_file2)
os.remove(output_file3)
os.remove(output_file4)

# Rename EG1126_alfa4_2_test5.csv into EG1126_alfa4_final for example
output_file6 = base_name + "_test6" + file_extension
output_file7 = base_name + ' test7' + file_extension
output_file8 = base_name + '_mean' + file_extension

# Create another spreadsheet that contains the transposed array
Trans = zip(*csv.reader(open(output_file5,'r')))
csv.writer(open(output_file6,'w')).writerows(Trans)

def line_averages(csv_file):
    with open(csv_file, 'r') as filename: 
        avLines= [] 
        for line in filename:
            stripped_line  = line.strip() # remove spaces at beginning and end
            stripped_line  = stripped_line.split(',')# split line based on commas
            stripped_line  = stripped_line[-10:] # only retains 10 last elements
            line_sum = sum(float(i) for i in stripped_line)
            avLines.append(line_sum/len(stripped_line)) 
        return avLines

list_avg = line_averages(output_file6)

def add_column_in_csv(inputt,outputt,transform_row):
	with open(inputt,'r') as read_obj, open(outputt,'w') as write_obj:
		csv_reader = csv.reader(read_obj)
		csv_writer = csv.writer(write_obj)
		for row in csv_reader:
			transform_row(row,csv_reader.line_num)
			csv_writer.writerow(row)
			
add_column_in_csv(output_file6,output_file7,lambda row, line_num: row.append(list_avg[line_num - 1]))

# Create another spreadsheet that contains the transposed array
Trans = zip(*csv.reader(open(output_file7,'r')))
csv.writer(open(output_file8,'w')).writerows(Trans)

os.remove(output_file5)
os.remove(output_file6)
os.remove(output_file7)
os.system ("cp "+output_file8+" ../html/callisto/TempFiles")
print ("Content-Type: text/xml\n")
print ("<options>\n")
print("<mean_Cp>{{callisto_name}}.{{callisto_topdomainname}}/TempFiles/"+str(output_file8)+"</mean_Cp>\n")
print ("</options>\n")
