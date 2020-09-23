import jellyfish
import decimal

def compare (desc1,desc2):
    """
    """
    #d1, d2 list of words
    valueline = 0
    try:
        d1 = str(desc1).split(" ")
    except: 
        d1 = desc1
    try:
        d2 = str(desc2).split(" ")
    except:
        d2 = desc2
    #d1 = [x for x in d1 if x != '']
    #d2 = [x for x in d2 if x != '']
    #print "compare entry"
    #print d1
    #print unicode(d1,encoding="utf-8")
    #print(type(d1))
    #print d2
    #print(type(d2))
    #print "d1 len:" + str(len(d1))
    #print "d2 len:" + str(len(d2))
    if len(d1) > len(d2):
##        print "d1 > d2"
        for cpt in range (len(d1) - len (d2)):
            d2.append("###")
    if len(d2) > len(d1):
##        print "d2 > d1"
        for cpt in range (len(d2) - len (d1)):
            d1.append("###")
##    print d1
##    print d2
    for word in d1:
        valueword = 0
        for word2 in d2:
            mesure1 = 0
            mesure2 = 0
            mesure3 = 0
            try:
                #dist = jellyfish.levenshtein_distance(unicode(word,encoding="utf-8"),unicode(word2,encoding="utf-8"))
                dist = jellyfish.levenshtein_distance(str(word),str(word2))
                #print dist
                if len(word)>len(word2):
                    mesure1 = 1-(float(dist) / len(word))
                    #print mesure1
                else:
                    try:
                        mesure1 = 1-(float(dist) / len(word2))
                        #print mesure1
                    except:
                        #print "pb lev 2"
                        pass
            except Exception as e:
                #print "pb lev:" +str(e)
                dist = 1
            try:
                mesure2 = jellyfish.jaro_winkler(str(word),str(word2))
                #print mesure2
            except Exception as e:
                #print "pb JW:" + str(e)
                pass
            try:
                mesure3 = jellyfish.jaro_distance(str(word),str(word2))
                #print mesure3
            except Exception as e:
                #print "pb J:" + str(e)
                pass
            try:
##                print (str(max(mesure1,mesure2,mesure3)))
                if (mesure1 > 0.7 or mesure2 > 0.85 or mesure3 > 0.85) and max(mesure1,mesure2,mesure3) > valueword:
                    valueword = max(mesure1,mesure2,mesure3)
##                    print("NEW VALUEWORD "+ word + " " + word2+ " " + str(valueword))
            except:
                #print("pb on measures\n")
                pass
        valueline += valueword
##        print "valueline: " + str(valueline)
##    print decimal.Decimal(valueline)
##    print decimal.Decimal(max(len(d1),len(d2)))
    try:
        caseline = decimal.Decimal(valueline) / decimal.Decimal(max(len(d1),len(d2)))
    except:
        caseline = 0
##    print caseline
    return caseline

def compare_Word2vec (desc1,desc2,model):
    
    #d1, d2 list of words
    valueline = 0
    d1 = list(desc1)
    d2 = list(desc2)
    d1 = [x for x in d1 if x != '']
    d2 = [x for x in d2 if x != '']
##        print "compare Word2Vec entry"
##        print d1
##        print d2
##    print "d1 len:" + str(len(d1))
##    print "d2 len:" + str(len(d2))
    if len(d1) > len(d2):
##        print "d1 > d2"
        for cpt in range (len(d1) - len (d2)):
            d2.append("###")
    if len(d2) > len(d1):
##        print "d2 > d1"
        for cpt in range (len(d2) - len (d1)):
            d1.append("###")
    #print d1
    #print d2
    for word in d1:
        valueword = 0
        for word2 in d2:
            try:
                mesure1 = model.similarity(word,word2)
                #print (word +" vs. "+word2+" result " + str(mesure1))
            except Exception as e:
                #print "error in model"
                #print(traceback.format_exc())
                mesure1 = 0
            if mesure1 > valueword:
                valueword = mesure1
##                    print("NEW VALUEWORD "+ word + " " + word2+str(valueword))
        valueline += valueword
##    print decimal.Decimal(valueline)
##    print decimal.Decimal(max(len(d1),len(d2)))
    try:
        caseline = decimal.Decimal(valueline) / decimal.Decimal(max(len(d1),len(d2)))
    except:
        caseline = 1000
##        print caseline
    return caseline
