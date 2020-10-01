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

Callisto uses ansible to deploy the application on several lxd containers (centOs7 based). So Ansible should be installed on the host:

    apt install ansible

Installing Callisto (base containers)
-------------------------------------

Copy the file vars.yml.dist:

    cp vars.yml.dist vars.yml

 - Edit the file vars.yml: at least choose laptop or server for the variable "callisto_living_on"
 - If installing on server, there are other variables to set (domain name, mail addresses etc)

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
    git clone https://github.com/GlobalDataverseCommunityConsortium/dataverse-ansible
    cd dataverse-ansible

Retrieve the CallistoDataverse container IP:

    lxc list

Change the file called inventory as follows (change xxx with the CallistoDataverse IP):

    [dataverse]
    CallistoDataverse container_addr=xxx.xxx.xxx.xxx ansible_connection=lxd

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
- Point your browser to the callisto url defined in vars.yml 

License
-------
To be defined

Author Information
------------------

Thierry Louge thierry.louge@toulouse-inp.fr
Emmanuel Courcelle emmanuel.courcelle@toulouse-in.fr

