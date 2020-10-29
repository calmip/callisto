Installing CALLISTO
===================

Pre-requisites
--------------

 - Callisto can be installed on your laptop (gnu/linux based) for tests and development
 - Callisto should be installed on a gnu/linux based server (tested on Ubuntu) for production
 - Callisto lives in different lxd containers, SO you should first install lxd:

### Installing lxd: ###

First install snap on your system (using apt-get, yum etc)

Then install lxd:

    sudo snap install lxd

Configure lxd:

    lxd init

Callisto uses ansible to deploy the application on several lxd containers (centOs7 based). So Ansible should be installed on the host (release 2.9.11 required):

    sudo -H pip3 install ansible==2.9.11

Installing Callisto (base containers)
-------------------------------------

**Copy** the file vars.yml.dist:

    cp vars.yml.dist vars.yml

 - **Edit** the file vars.yml: 
   - choose **laptop** or **server** for the variable `callisto_living_on`
   - Choose and write credentials for the use of Allegro software (`allegro_user` and `allegro_password`)
   - `ssh_wanted`: if true, your ssh public key shall be copied to the containers, to easily enter the containers. This is only convenient if you are a developer. Default is false
   - If installing on **server**, there are other variables to set (`callisto_url`, mail addresses and some other stuff)

**Managing** the certificates:

*If installing on your laptop*, you can use the self-signed certificates:

    cp roles/proxy/files/cert.pem.dist roles/proxy/files/ssl/cert.pem
    cp roles/proxy/files/key.pem.dist  roles/proxy/files/ssl/key.pem

*If installing on a server*, you should get secure certificates for the domains (a `*.{{ callisto_url }}` certificate is OK):
 - {{ callisto_url }}
 - dataverse.{{ callisto_url }}
 - allegro.{{ callisto_url }}
Copy the certificate and the 

**Run the following command** to create the containers and deploy Callisto on them:

    ansible-playbook -i inventory callisto.yml 

If this does not work with a password related message, add the -K switch to the above command:

    ansible-playbook -i inventory callisto.yml -K

Partial installs can be done with the `--tags` switch (have a look to `callisto.yml` to know the tags):

    ansible-playbook -i inventory --tags proxy callisto.yml -K

Installing dataverse:
---------------------

Dataverse can be easily installed thanks to the ansible role provided by Dataverse:

    cd ../
    git clone https://github.com/GlobalDataverseCommunityConsortium/dataverse-ansible.git dataverse
    cd dataverse

**Change** the file called inventory as follows:

    [dataverse]
    CallistoDataverse ansible_connection=lxd

**Return** to base directory and **run** the command:
    cd ../
    ansible-playbook -v -i dataverse/inventory dataverse/dataverse.pb -e dataverse/defaults/main.yml

Installing the demonstration repository in dataverse:
-----------------------------------------------------

**Enter** the Dataverse container:

    lxc exec CallistoDataverse bash

**Execute** the following commands inside the container:

    cd /
    tar xvfz 10.5072.tgz
    systemctl stop payara 
    dropdb -U postgres dvndb 
    createdb -U postgres dvndb 
    psql -U postgres dvndb -f 10.5072.sql
    systemctl start payara 
    curl http://localhost:8080/api/admin/index/clear 
    curl http://localhost:8080/api/admin/index

Installing Allegro:
-------------------

**Enter** the Allegro container:

    lxc exec CallistoAllegro bash 

**Get** the Allegro rpm:

    wget https://franz.com/ftp/pri/acl/ag/ag7.0.3/linuxamd64.64/agraph-7.0.3-1.x86_64.rpm

**Install** the rpm:

    rpm -i agraph-7.0.3-1.x86_64.rpm

**Configure** Allegro:

    /usr/bin/configure-agraph
    (Doing so, make sure to use the password and user for agraph that you specified in callisto vars.yml configuration file)    

**Enable** Allegro for automatic start:

    chkconfig agraph on

**Start** Allegro:

    systemctl start agraph 

Loading demonstration repository
---------------------------------

**Enter** the Portal container:

    lxc exec CallistoPortal bash

**Load** the demonstration repository:

    /usr/local/bin/initialize_demonstration_repository.py

Running Callisto
----------------
- Point your browser to the callisto url defined in vars.yml (variable `callisto_url`)

### Running on your laptop: ###

When visiting https://callisto-local.mylaptop the *FIRST TIME* your browser will send a warning because
there is an autosigned certificate: Please accept the risk

Then click the menu link "valid dataverse certif" to validate the autosigned certificate of the dataverse url. This is required to be able to use
dataverse from an iframe, as it is the normal use of dataverse in Callisto

Your browser will not warn you anymore

License
-------
Callisto is covered by the GNU AFFERO GENERAL PUBLIC LICENSE version 3
Please read the LICENSE.txt file

Author Information
------------------
Thierry Louge thierry.louge@toulouse-inp.fr
Emmanuel Courcelle emmanuel.courcelle@toulouse-in.fr
