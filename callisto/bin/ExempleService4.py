import sys
dic = {}
ignored_words_line = IgnoredWordsList_file.readlines()
list_ignored = []
for line in ignored_words_line:
    list_ignored.append(line.rstrip("\n"))

for line in AsciiTextFile_file.readlines():
    for ignore in list_ignored:
        line = line.replace(ignore,"")
    splitted = line.split(" ")
    for word in splitted:
        count = len(word.replace("\n","").replace(",",""))
        if count in dic.keys():
            dic[count] += 1
        else:
            dic[count] = 1
results_file = open('ExempleService4_results.txt','w')
for key in dic:
    results_file.write(str(key)+":"+str(dic[key])+"\n")

