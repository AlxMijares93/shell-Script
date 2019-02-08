#!/bin/bash

rm -rf datos.txt #eliminamos los archivos previos
rm -rf conexiones.csv #eliminamos los archivos previos
for i in $(ls); #listamos los archivos del directorio para generar nuestro foreach
do
	fecha=$(cut -f2 -d"_" <<< $i); #extraemos la fecha y la hora del nombre del log
	hora=$(cut -f3 -d"_" <<< $i | cut -f1 -d".") #extraemos la fecha y la hora del nombre del log
  # de cada log hacemos la busqueda de acuerdo al criterio pasado como argumento desde la linea de comando
	cat $i | grep $1 | awk -v fecha="$fecha" -v hora="$hora" '{
		print fecha","hora","$2","$5","$7,$8","$11 >> "datos.txt"
	} '
done
#Eliminamos las cadenas que no son necesarias para el script
sed 's/Destination: //' datos.txt | sed 's/,Source//' > conexiones.csv

