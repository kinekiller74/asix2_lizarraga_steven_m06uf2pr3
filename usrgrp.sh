#!/bin/bash

clear
if (( $EUID != 0 ))
then
  echo "This script must be run as a root"
  exit 1 
fi

function menu(){
	clear
	echo  "Menu"
	echo  "1. Crear un usuari "
	echo  "2. Crear un grup "
	echo  "3. Afegeix un usuari a un grup"
	echo  "4. Treieu un usuari d'un grup"
	read opcio
	case $opcio in
	
		1)
			crusr
		;;
		2)
			cgrp
		;;
		3)
			afegr
		;;
		3)
			esbgr
		;;
	esac
	
}

function crusr(){
	clear
	echo -n "Don'm el nom d'un usuari: "
	read nomuser
	echo -n "UID user: "
	read uid
	useradd $nomuser -u $uid > /dev/null
	if (( $? != 0 ))
		then
			echo "No s'ha pogut crear el nou usuari"
		exit 1
	else
		echo "L'usuari ha estat creat"
	fi
	echo -n "Vol continuar treballant? 's' per si o 'n' per no: "
	read opcio
	case $opcio in
	
		s)
			menu
		;;
		n)
			exit 1
		;;
		
	esac
}
	
function cgrp(){
	clear
	echo -n "Nom del nou grup d'usuaris: "
	read nom_grup
	echo -n "GID del nou grup d'usuaris: "
	read gid 
	groupadd -g $gid $nom_grup 2> /dev/null
	if (( $? != 0 ))
		then
			echo "No s'ha pogut crear el nou grup d'usuaris"
		exit 1
	else
		echo "El grup ha estat creat"
		cat /etc/group | grep $nom_grup	
	fi
	echo -n "Vol continuar treballant? 's' per si o 'n' per no: "
	read opcio
	case $opcio in
		s)
			menu
		;;
		n)
			exit 1
		;;	
	esac
}
	
function afegr(){
	clear
	echo -n "Nom del grup: "
	read nom_grup
	echo -n "Nom de l'usuari: "
	read nom_usuari
	usermod -a -G $nom_grup $nom_usuari
	echo -n "Vol continuar treballant? 's' per si o 'n' per no: "
	read opcio
	case $opcio in
		s)
			menu
		;;
		n)
			exit 1
		;;	
	esac
}

function esbgr(){
	clear
	echo -n "Nom del grup que vol eliminar: "
	read nom_grup
	echo -n "Nom de l'usuari: "
	read nom_usuari
	userdel $nom_usuari $nom_grup
	
	echo -n "Vol continuar treballant? 's' per si o 'n' per no: "
	read opcio
	case $opcio in
		s)
			menu
		;;
		n)
			exit 1
		;;	
	esac
}
menu