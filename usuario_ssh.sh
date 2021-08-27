#! /bin/bash

#conexion
read -p "introduce el dominio al que te quieres conectar: " dominio
read -p "que usuario deseas utilizar?" usuario
read -p "cuantos usurios deseas crear? " num

for ((i = 1 ; i <= $num ; i++)); do
    read -p "introduce el nombre de usuario numero $i: " usu_temp
    read -p "introduce la clave pueblica del usuario numero $i: " clave
    #creacion de usurio
    ssh -o "StrictHostKeyChecking no" $usuario@$dominio "sudo adduser $usu_temp -G stratians;
        echo '$usu_temp ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers;
        sudo mkdir /home/$usu_temp/.ssh;
        echo '$clave' | sudo tee -a /home/$usu_temp/.ssh/authorized_keys;
        sudo chown -R $usu_temp:stratians /home/$usu_temp/.ssh; exit; exit"
done
