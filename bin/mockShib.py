#! /usr/bin/python3

import sys
import subprocess

#
# This Q&D script can be used to "mock" Callisto, making beleive Callisto
# that we were authenticated by Shibboleth
#
# Usage: python3 mockShib.py login
#        python3 mockShib.py logout
#

def Usage():
    print ("Usage: python3 mockShib.py login")
    print ("       python3 mockShib.py logout")


if len(sys.argv) != 2:
    Usage()
    exit(1)

if sys.argv[1] == 'login':
    givenName = input("Enter your givenName      : ")
    sn        = input("Enter your surName        : ")
    mail      = input("Enter your mail           : ")
    print            ("Your eppn is              : " + mail)
    print            ("Shib-Identity-Provider is : mockShib")
    print

    print ("Now creating the headers.conf file")
    with open("headers.conf","w") as f:
        f.write ("RequestHeader set AJP_sn: {0}\n".format(sn))
        f.write ("RequestHeader set AJP_givenName: {0}\n".format(givenName))
        f.write ("RequestHeader set AJP_mail: {0}\n".format(mail))
        f.write ("RequestHeader set AJP_eppn: {0}\n".format(mail))
        f.write ("RequestHeader set AJP_Shib-Identity-Provider: mockShib\n")

    print ("Now pushing headers.conf to the container CallistoProxy")
    subprocess.run(["lxc","file","push","headers.conf","CallistoProxy/etc/httpd/conf.d/mockShib/headers.conf"])

    print ("Now restarting apache on the container CallistoProxy")
    subprocess.run(["lxc","exec","CallistoProxy","apachectl","restart"])
    print ("Done")
    print ("To logout try python3 mockShib logout")

elif sys.argv[1] == 'logout':
    print ("Now removing headers.conf from the container CallistoProxy")
    subprocess.run(["lxc","exec","CallistoProxy","rm","/etc/httpd/conf.d/mockShib/headers.conf"])

    print ("Now restarting apache on the container CallistoProxy")
    subprocess.run(["lxc","exec","CallistoProxy","apachectl","restart"])

else:
    Usage()



