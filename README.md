Installing CALLISTO
===================

Pre-requisites
--------------

 - Callisto can be installed on your laptop (gnu/linux based) for tests and development
 - Callisto should be installed on a gnu/linux based server (tested on Ubuntu) for production
 - Callisto lives in different lxd containers, SO you should first install lxd:

 - If not already done install the package manager snap

 - Install lxd: snap install lxd
 - Configure lxd: lxd init

 - Callisto uses ansible to deploy the application on several lxd containers (centOs7 based). So Ansible should be installed on the host:
 - apt install ansible

Installing Callisto
-------------------

- Edit the file vars.yml: at least choose laptop or server for the variable "callisto_living_on"
- If installing on server, there are other variables to set (domain name, mail addresses etc)
- Then run ansible-playbook -i inventory callisto.yml to create the containers and deploy Callisto on them

       - If this does not work with a password related message, add the -K switch to the above command
       - Partial installs can be done with the --tags switch (have a look to callisto.yml to know the tags)

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

