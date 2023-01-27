import sys
dic = {}
for line in AsciiTextFile_file.readlines():
    splitted = line.split(" ")
    for word in splitted:
        count = len(word.replace("\n","").replace(",",""))
        if count in dic.keys() and count > 7:
            dic[count] += 1
        elif count > 7:
            dic[count] = 1
results_file = open('ExempleService2_results.txt','w')
for key in dic:
    results_file.write(str(key)+":"+str(dic[key])+"\n")

