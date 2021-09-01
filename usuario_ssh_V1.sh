#!/bin/bash

i=0
document=usu.txt
while read line; do
    if [ $i -eq 0 ]; then
        domain=`echo "$line" | cut -d "," -f1`
        usu_conct=`echo "$line" | cut -d "," -f2`
        i=1
    else
        usu_create=`echo $line | cut -d "," -f1`
        ssh_key=`echo $line | cut -d "," -f2`
        if [[ $ssh_key != "" ]]; then
                ssh -o "StrictHostKeyChecking no" $usu_conct@$domain "sudo adduser $usu_create -G stratians;
                    echo '$usu_create ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers;
                    sudo mkdir /home/$usu_create/.ssh;
                    echo '$ssh_key' | sudo tee -a /home/$usu_create/.ssh/authorized_keys;
                    sudo chown -R $usu_create:stratians /home/$usu_create/.ssh; exit; exit"
        fi
    fi
done < $document
usu_create=`echo $line | cut -d "," -f1`
ssh_key=`echo $line | cut -d "," -f2`
if [[ $ssh_key != "" ]]; then
    ssh -o "StrictHostKeyChecking no" $usu_conct@$domain "sudo adduser $usu_create -G stratians;
        echo '$usu_create ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers;
        sudo mkdir /home/$usu_create/.ssh;
        echo '$ssh_key' | sudo tee -a /home/$usu_create/.ssh/authorized_keys;
        sudo chown -R $usu_create:stratians /home/$usu_create/.ssh; exit; exit"
fi