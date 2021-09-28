Installing CALLISTO
===================

Pre-requisites
--------------

 - Callisto can be installed on your laptop (gnu/linux based) for tests and development
 - Callisto should be installed on a gnu/linux based server (tested on Ubuntu) for production
 - Callisto lives in different lxd containers, SO you should first install lxd
 - Callisto uses ansible to deploy the programs in the lxc containers: ansible should be installed on the host
 - The Callisto software should be downloaded on the host

### Installing lxd: ###

First install snap on your system (using apt-get, yum etc)

Then install lxd:

    sudo snap install lxd

Configure lxd:

    lxd init

**Here is a mini-tutorial about lxc:**

To enter the CallistoPortal container:

    lxc exec CallistoPortal bash

To exit from the CallistoPortal container:

    exit

or

    CTRL-D

A more complete documentation about lxd can be found here: https://ubuntu.com/tutorials/introduction-to-lxd-projects#1-overview

### Installing Ansible: ###

Callisto uses ansible to deploy the application on several lxd containers (centOs7 based). So Ansible should be installed on the host (release 2.9.11 required):

    sudo -H pip3 install ansible==2.9.11

### Downloading Callisto: ###

    git clone https://github.com/calmip/callisto

in the following, `$WORKDIR` means: the directory where you cloned callisto

Installing Callisto (base containers)
-------------------------------------

**Copy** the file vars.yml.dist:

```
cd $WORKDIR/install
cp vars.yml.dist vars.yml
```

**Edit** the file vars.yml: 

- choose **laptop** or **server** for the variable `callisto_living_on`
- Choose and write credentials for the use of Allegro software (`allegro_user` and `allegro_password`)
- `ssh_wanted`: if true, your ssh public key shall be copied to the containers, to easily enter the containers. This is only convenient if you are a developer. Default is false
- If installing on **server**, there are other variables to set (`callisto_url`, mail addresses and some other stuff)

**Managing** the certificates:

- *If installing on your laptop*, you can use the self-signed certificates:
    
    ```
    cd $WORKDIR/install
    cp roles/proxy/files/cert.pem.dist roles/proxy/files/ssl/cert.pem
    cp roles/proxy/files/key.pem.dist  roles/proxy/files/ssl/key.pem
    ```

- *If installing on a server*, you should get a secure certificate for the domains (a `*.{{ callisto_url }}` certificate is OK):
   - {{ callisto_url }}
   - dataverse.{{ callisto_url }}
   - allegro.{{ callisto_url }}
   - Copy the certificate, the key and the chain to the directory `roles/proxy/files/ssl`
   - See also the file `certificates/README.txt` (there is a certificate to get for Shibboleth configuration)

**Run the following command** to create the containers:

    cd $WORKDIR/install
    ansible-playbook -i inventory callisto.yml -K

Partial installs can be done with the `--tags` switch (have a look to `callisto.yml` to know the tags):

    cd $WORKDIR/install
    ansible-playbook -i inventory --tags proxy callisto.yml -K

## Installing Callisto (the code):

Create and edit the callisto configuration file. Please choose a user name and a password as Allegro administrator.

```
cd $WORKDIR/callisto/etc
cp callisto_conf.cfg.dist callisto_conf.cfg
vi callisto_conf.cfg 
```

### Configuring directory sharing between the host and CallistoPortal container:

Because the callisto tree is in the host, you must share it  with the CallistoPortal container. This operation cannot be automated with Ansible, it should be executed in four steps:

1. Prepare the mapping between the uid/gid in the host and in the containers (you'll have to restart lxd daemon, thus all containers will be restarted)

   ```
   # printf "lxd:$(id -u):1\nroot:$(id -u):1\n" | sudo tee -a /etc/subuid
   lxd:1000:1
   root:1000:1
   
   # printf "lxd:$(id -g):1\nroot:$(id -g):1\n" | sudo tee -a /etc/subgid
   lxd:1000:1
   root:1000:1
   
   sudo systemctl restart snap.lxd.daemon
   ```

1. Map the current user in the host to root in the container:
   ```
   printf "uid $(id -u) 0\ngid $(id -g) 0" | lxc config set CallistoPortal raw.idmap -
   ```
   
1. Create the share in `CallistoPortal` (we share the subdirectory `callisto` of the cloned tree) and restart the container:

   ```
   cd $WORKDIR
   lxc config device add CallistoPortal CallistoPortal-disk disk source=$(pwd)/callisto path=/usr/local/callisto
   lxc restart CallistoPortal   
   ```

1. Check that the sharing is up:
   ```
      # lxc exec CallistoPortal -- ls -l /usr/local/callisto/
      total 20
      drwxr-xr-x  2 1000 1000 4096 Sep  9 12:35 bin
      drwxr-xr-x  3 1000 1000 4096 Sep  9 12:43 cgi-bin
      drwxr-xr-x  2 1000 1000 4096 Sep  9 11:44 etc
      drwxr-xr-x 10 1000 1000 4096 Sep  9 12:24 html
      drwxr-xr-x  2 1000 1000 4096 Sep  9 12:38 logs
   ```
   
    

Installing dataverse:
---------------------

Dataverse can be installed thanks to the ansible role provided by Dataverse:

    cd $WORKDIR/..
    git clone https://github.com/GlobalDataverseCommunityConsortium/dataverse-ansible.git dataverse
    cd dataverse
    git checkout 3b0277a0ad5bcb717dd2fd186fe9162fd157bfe9

**Change** the file called inventory as follows:

    [dataverse]
    CallistoDataverse ansible_connection=lxd

**Modify** the file  called default/main.yml:

    port: 443 (line 20)

**Return** to base directory and **run** the command:

    cd $WORKDIR/../dataverse
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

    cd /usr/local/callisto/bin
    ./initialize_demonstration_repository.py

## Working with open data

The users can manage an open data repository with Callisto (ie data accessible through the Internet without authentication, but with an oid), as long as you did choose a server install. But you should do some more configuration tasks in order to prepare things:

- Enter inside the CallistoDataverse container, and edit a file (2 lines to complete, replace CallistoDataverse with a real fqdn and URL (please expand {{callisto_URL}}):

  ```
  lxc exec CallistoDataverse bash
  vi /usr/local/payara5/glassfish/domains/domain1/config/domain.xml
   L.269 --> <jvm-options>-Ddataverse.fqdn=dataverse.{{callisto_URL}}</jvm-options>
   L.278 --> <jvm-options>-Ddataverse.siteUrl=https://dataverse.{{callisto_URL}}</jvm-options>
  ```
  Then restart the container:
  ```
  lxc restart CallistoDataverse
  ```
  
- Enter inside the CallistoProxy container, and edit a file (1 line to complete, expanding {{authority}} and {{shoulder}}). This is important to let the published data pass across the authentication system:

  ```
  lxc exec CallistoProxy bash
  vi /etc/httpd/conf.d/dataverse.conf
   L. 93 --> RewriteCond %{QUERY_STRING} !persistentId=doi:{{authority}}/{{shoulder}}
  ```

  Then restart the container:

  ```
  lxc restart CallistoProxy
  ```
- Read the dataverse documentation about the doi and open data: https://guides.dataverse.org/en/latest/installation/config.html?highlight=doi

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
