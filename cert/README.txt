1/ laptop installations
-----------------------
We use autosigned (not secure) certificates to make the browser happy. You can re-generate the certificates 
if necessary (but it should not):

Generating autosigned certificate for laptop installations:

    openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes -keyout key.pem -days 3560 -out cert.pem -config local.cnf 

Checking that everything is OK:

    openssl x509 -noout -text -in cert.pem 

Copying the certificate and the key: 
    
    cp key.pem cert.pem ../roles/proxy/files/ssl

2/ Server installations
-----------------------

You should have your own certificate (see with your institutions), valid for the domains;
* {{callisto_url}}
* dataverse.{{callisto_url}}
* allegro.{{callisto_url}}

OR a star certificate ({{callisto_url}} and *.{{callisto_url}}

Copy the certificate, the key AND the chain to the directory  ../roles/proxy/files/ssl The files should be renamed to key.pem and cert.pem

Emmanuel (emmanuel.courcelle@toulouse-inp.fr)

