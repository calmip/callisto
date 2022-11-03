#! /bin/bash

# map the current user in the host to the root in the container
printf "uid $(id -u) 0\ngid $(id -g) 0" | lxc config set CallistoPortal raw.idmap -

# Create the share in CallistoPortal (we share the subdirectory callisto of the cloned tree) and restart the container:
lxc config device add CallistoPortal CallistoPortal-disk disk source=$(cd .. && pwd)/callisto path=/usr/local/callisto
lxc restart CallistoPortal

# sleep 15s (should be enough for the container to restart)
sleep 15

# Create a file
echo "THIS DIRECTORY IS SHARED BETWEEN THE HOST AND THE CONTAINER CallistoPortal\n" > ../callisto/.SHARED.txt
echo "PLEASE REMOVE THIS FILE IF YOU WANT TO SHARE THE DIRECTORY AGAIN !\n" >> ../callisto/.SHARED.txt


