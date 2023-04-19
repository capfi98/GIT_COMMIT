#!/bin/bash
echo 'Escribe la ruta local que desea subir a git (que no sea la carpeta en donde te encuentras*)'
echo './* para los archivos en donde te encuentras ahora'
read RUTA
echo 'Escribe el repositorio de git. Ex:https://github.com/user/name.git'
read WEB
git init
echo "ESTAS SEGURO DE LA RUTA? Y|N"
echo "$RUTA"
read ANSW
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
	echo "Tus datos"
	cat git_data.txt
	git push -u origin main
else
	exit 1
	echo "adios"
fi
