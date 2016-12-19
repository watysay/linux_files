#!/bin/bash
# objectif : récuperer une liste de fichiers dans une variable
# pour ensuite les copier dans une archive avec connaissance de leur absolute path

# etape 1 : lister les fichiers d'une manière ou d'une autre
# etape 2 : faire un tar de l'absolute path
# etape 3 : dé-tarer les fichiers avec l'option -C /

var="<liste de fichiers>"

# methode 1 :
tar -cvf test.tar $var
# methode 2 :
<moyen de liste : find, ls, grep, ...> | xargs tar -cvf test.tar
# ici transfert de l'archive
tar -xvf test.tar -C /

cwd="$(pwd)"
testdir=$cwd/testdir
echo $testdir
echo 
mkdir $testdir

for varr in $var
do
	echo $varr
	cp "$varr" "$PWD" 
done
echo

var=${var//Documents/scripts}
echo $var
echo

rm test.tar
echo tar -cvf test.tar $var 
echo
echo ========================
echo suppression
echo "$var" | xargs rm
ls -1
echo
echo ================
echo remise
ls -1
echo
