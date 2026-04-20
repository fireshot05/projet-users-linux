#!/bin/bash

LOG="log.txt"

log_action() {
    echo "$(date) - $1" >> $LOG
}

user_exists() {
    id "$1" &>/dev/null
}

group_exists() {
    getent group "$1" &>/dev/null
}

user_in_group() {
    id -nG "$1" | grep -qw "$2"
}

while true
do

CHOIX=$(zenity --list \
--title="Gestion Linux" \
--column="Option" \
"Ajouter utilisateur" \
"Supprimer utilisateur" \
"Créer groupe" \
"Ajouter user à groupe" \
"Lister utilisateurs" \
"Quitter")

case $CHOIX in

"Ajouter utilisateur")
USER=$(zenity --entry --title="Utilisateur" --text="Nom utilisateur :")

if user_exists "$USER"; then
    zenity --error --text="Utilisateur existe déjà !"
    log_action "Tentative ajout user existant : $USER"
else
    sudo useradd "$USER"
    zenity --info --text="Utilisateur ajouté : $USER"
    log_action "Utilisateur ajouté : $USER"
fi
;;

"Supprimer utilisateur")
USER=$(zenity --entry --title="Utilisateur" --text="Nom utilisateur :")

if user_exists "$USER"; then
    sudo userdel "$USER"
    zenity --info --text="Utilisateur supprimé : $USER"
    log_action "Utilisateur supprimé : $USER"
else
    zenity --error --text="Utilisateur inexistant"
fi
;;

"Créer groupe")
GROUP=$(zenity --entry --title="Groupe" --text="Nom groupe :")

if group_exists "$GROUP"; then
    zenity --error --text="Groupe existe déjà !"
    log_action "Tentative création groupe existant : $GROUP"
else
    sudo groupadd "$GROUP"
    zenity --info --text="Groupe créé : $GROUP"
    log_action "Groupe créé : $GROUP"
fi
;;

"Ajouter user à groupe")
USER=$(zenity --entry --title="Utilisateur" --text="User :")
GROUP=$(zenity --entry --title="Groupe" --text="Groupe :")

if ! user_exists "$USER"; then
    zenity --error --text="Utilisateur inexistant"
elif ! group_exists "$GROUP"; then
    zenity --error --text="Groupe inexistant"
elif user_in_group "$USER" "$GROUP"; then
    zenity --warning --text="Utilisateur déjà dans ce groupe"
else
    sudo usermod -aG "$GROUP" "$USER"
    zenity --info --text="$USER ajouté à $GROUP"
    log_action "$USER ajouté au groupe $GROUP"
fi
;;

"Lister utilisateurs")
USERS=$(cut -d: -f1 /etc/passwd)
zenity --text-info --title="Liste utilisateurs" --width=400 --height=500 <<< "$USERS"
log_action "Liste utilisateurs affichée"
;;

"Quitter")
log_action "Programme terminé"
exit
;;

esac

done
