Installing CALLISTO
===================

Pre-requisites
--------------

 - Callisto can be installed on your laptop (gnu/linux based) for tests and development
 - Callisto should be installed on a gnu/linux based server (tested on Ubuntu) for production
 - Callisto lives in different lxd containers, SO you should first install lxd:

### Installing lxd: ###

First install snap on your system (using adpt-get, yum etc)

Then install lxd:

    snap install lxd

Configure lxd:

    lxd init

Callisto uses ansible to deploy the application on several lxd containers (centOs7 based). So Ansible should be installed on the host (release 2.9.11 required):

    sudo -H pip3 install ansible==2.9.11

Installing Callisto (base containers)
-------------------------------------

Copy the file vars.yml.dist:

    cp vars.yml.dist vars.yml

 - Edit the file vars.yml: at least choose laptop or server for the variable "callisto_living_on"
 - If installing on server, there are other variables to set (domain name, mail addresses etc)

Managing the certificates:

If installing on your laptop, you can use the self-signed certificates:

    cp roles/proxy/files/cert.pem.dist roles/proxy/files/ssl
    cp roles/proxy/files/key.pem.dist  roles/proxy/files/ssl

If installing on a server, you should get secure certificates for the domains:
 - {{ callisto_url }}
 - dataverse.{{ callisto_url }}
 - allegro.{{ callisto_url }}

Then run the follwing command to create the containers and deploy Callisto on them:

    ansible-playbook -i inventory callisto.yml 

If this does not work with a password related message, add the -K switch to the above command:

    ansible-playbook -i inventory callisto.yml -K

Partial installs can be done with the --tags switch (have a look to callisto.yml to know the tags):

    ansible-playbook -i inventory --tags proxy callisto.yml -K


Installing dataverse:
---------------------

Dataverse can be easily installed with the ansible role provided by Dataverse:

    
    cd ../
    git clone https://github.com/GlobalDataverseCommunityConsortium/dataverse-ansible.git dataverse
    cd dataverse

Change the file called inventory as follows:

    [dataverse]
    CallistoDataverse ansible_connection=lxd

Run ansible-playbook:

    ansible-playbook -i dataverse/inventory dataverse/dataverse.pb -e dataverse/defaults/main.yml

Return to base directory and run the installation:
    cd ../
    ansible-playbook -v -i dataverse/inventory dataverse/dataverse.pb -e dataverse/defaults/main.yml

Installing the demonstration repository:
/usr/local/dvn/data/

Installing Allegro:
-------------------

Retrieve the CallistoAllegro container IP:

    lxc list

Go to the Allegro container:

    ssh root@YYY.YYY.YYY.YYY

Allegro will need openssl :

    yum install openssl

Get the Allegro rpm:

    wget https://franz.com/ftp/pri/acl/ag/ag7.0.3/linuxamd64.64/agraph-7.0.3-1.x86_64.rpm

Install the rpm:

    rpm -i agraph-7.0.3-1.x86_64.rpm

Configure Allegro:

    /usr/bin/configure-agraph
    (Doing so, make sure to use the password and user for agraph that you specified in callisto vars.yml configuration file)    

Enable Allegro for automatic start:

    chkconfig agraph on

Start Allegro:

    systemctl start agraph 

Running Callisto
----------------
- Point your browser to the callisto url defined in vars.yml, in https

### Running on your laptop: ###
When visiting https://callisto-local.mylaptop the FIRST TIME your browser will send a warning because
there is an autosigned certificate: Please accept the risk

Then click the menu link "valid dataverse certif" to validate the autosigned certificate of the dataverse url. This is required to be able to use
dataverse from an iframe, as it is the normal use of dataverse in Callisto

Your browser will not warn you anymore

License
-------
To be defined

Author Information
------------------

Thierry Louge thierry.louge@toulouse-inp.fr
Emmanuel Courcelle emmanuel.courcelle@toulouse-in.fr

