#  Projet : Gestion automatisée des utilisateurs Linux

##  Objectif
Ce projet permet d’automatiser la gestion des utilisateurs et des groupes sous Linux à l’aide d’un script Bash avec interface graphique Zenity.

---

##  Fonctionnalités

- Ajouter un utilisateur
- Supprimer un utilisateur
- Créer un groupe
- Ajouter un utilisateur à un groupe
- Lister tous les utilisateurs du système
- Vérification :
  - utilisateur existe déjà
  - groupe existe déjà
  - utilisateur déjà dans un groupe
- Enregistrement des actions dans un fichier log

---

##  Technologies utilisées

- Linux (Ubuntu)
- Bash (shell scripting)
- Zenity (interface graphique)
- Commandes système Linux (useradd, userdel, groupadd, usermod)

---

##  Exécution du projet

```bash
chmod +x gestion.sh
./gestion.sh
