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

