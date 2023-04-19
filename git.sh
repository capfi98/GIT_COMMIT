#!/bin/env bash

# Nombre del script: git_commit.sh
# Descripción: Automatizacion de archivos a git, util para verificar versiones y guardar scripts
# Autor: Carlos Perez, cept.
# Fecha: 19/04/2023
# Versión:
#       v.1: Leer descripcion, depende de un archivo git_data con tus datos,
#	Ex:user:
#	user
#	token:
#	abcdefghijklmnopqrstuvwxyz123456789


#Ingresa tus datos de importancia, es importante que mantengas tus datos en un archivo "git_data.txt'

echo 'Nuevo o Existente, N|E?'
read RESP

if [ $RESP=="N" ]; then
	# Solicitar la ruta local a subir a Git
	echo 'Escribe la ruta local que desea subir a git (que no sea la carpeta en donde te encuentras*)'
	echo './* para los archivos en donde te encuentras ahora'
	read RUTA

	# Solicitar el repositorio de Git
	echo 'Escribe el repositorio de git. Ex:https://github.com/user/name.git'
	read WEB

	# Inicializar un repositorio de Git
	git init

	# Confirmar la ruta local ingresada
	echo "ESTAS SEGURO DE LA RUTA? Y|N"
	echo "$RUTA"
	read ANSW

	# Verificar la respuesta del usuario y agregar los cambios si la respuesta es afirmativa
	if [ $ANSW == "Y" ]; then
        	git add $RUTA
        	echo "Agrega un comentario al commit:"
        	read COMMIT
        	if [ -n "$COMMIT" ]; then
                	git commit -m "$COMMIT"
        	else
                	git commit
        	fi
        	git branch -M main
        	git remote add origin "$WEB"
        	echo "TUS DATOS"
        	cat git_data.txt
        	git push -u origin main
	else
        	# Si la respuesta es negativa, salir del script y mostrar un mensaje de despedida
        	exit 1
        	echo "adios"
	fi
elif [ $RESP=="E" ]; then
	# Solicitar la ruta local a subir a Git
        echo 'Escribe la ruta local que desea subir a git (que no sea la carpeta en donde te encuentras*)'
        echo './* para los archivos en donde te encuentras ahora'
        read RUTA

        # Solicitar el repositorio de Git
        echo 'Escribe el repositorio de git. Ex:https://github.com/user/name.git'
        read WEB

       # Confirmar la ruta local ingresada
        echo "ESTAS SEGURO DE LA RUTA? Y|N"
        echo "$RUTA"
        read ANSW

        # Verificar la respuesta del usuario y agregar los cambios si la respuesta es afirmativa
        if [ $ANSW == "Y" ]; then
		REMOTE=$(git config --get remote.origin.url)
		if [ "$WEB" == "$REMOTE" ]; then
    			# El control remoto ya existe
    			git branch -M main
    			echo "TUS DATOS"
    			cat git_data.txt
    			git push -u origin main
		else
    			# El control remoto no existe, agregarlo
    			git remote add origin "$WEB"
    			git branch -M main
    			echo "TUS DATOS"
    			cat git_data.txt
    			git push -u origin main
		fi
        else
                # Si la respuesta es negativa, salir del script y mostrar un mensaje de despedida
                exit 1
                echo "adios"
        fi
fi
