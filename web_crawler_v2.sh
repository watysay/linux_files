#! /bin/bash

# web crawler v2 - Bash edition
# part 1 : récuperer la recherche
# part 2 : faire la requete google
# part 3 : récupérer les liens
# part 4 : ouvrir les onglets

# TODO : créer les fichiers temporaires dans un dossier particulier

# part 0 : variables et constantes
tmp_file="testfilegoogle"
base_req="http://www.google.fr/search?q="
nb_liens_a_suivre=3
liste_liens="tmp_liste_liens"

# part 1 : récuperer la recherche
echo nb arguments : $#
echo arguments : $*

# $0 = chemin du lancement + nom du script
# utiliser basename pour le nom du script
# $* = tous les arguments
# $# = nb arguments ?

if [[ $# > 0 ]]
then
    echo $*
    
else
    echo Pas de recherche
    # TODO : demander un input
fi

# partie de la requete : mot1+mot2+...
req=$(echo $* | tr ' ' '+')



# recuperation du html de la recherche
wget -q -U 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:50.0) Gecko/20100101 Firefox/50.0' $base_req$req -O $tmp_file

# creation du fichier de liens
grep "h3 class=\"r\"><a" $tmp_file | sed -r 's;(<h3 class="r"><a href=);\n;g' | sed -r 's:"([^"]*)".*:\1:g' | tail -n +2 > $liste_liens
# explications :
# grep "h3 class=\"r\"><a" $tmp_file : récupère seulement les lignes contenant les liens
# sed -r 's;(<h3 class="r"><a href=);\n;g' : remplace la partie juste avant le lien par un retour à la ligne
# sed -r 's:"([^"]*)".*:\1:g' : recuperation de seulement le lien
# tail -n +2 > $liste_liens : la premiere ligne est foireuse, permet de créer seulement les 10 premiers liens

base_google='http://www.google.fr/url?q='

# utilisation de nb_liens_a_suivre
for lien in $(head -n $nb_liens_a_suivre $liste_liens)
do
    #echo $lien
    
    # ouverture des onglets
    firefox -new-tab $lien
done


exit
grep "h3 class=\"r\"><a" testrechgoogle | sed -r 's;(<h3 class="r"><a href=);\n;g' | tail -n +2 | sed -r 's:"([^)]*).*:\1:g' | sed -r "s:^([^\"]*)\" onmousedown=\"return rwt\(this,'','','','[0-9]','([0-9a-zA-Z_]+)','','([0-9a-zA-Z_]+)'.*:\1 \2 \3:g"



