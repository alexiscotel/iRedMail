# swaks : Envoyez des mails depuis vos scripts sans MTA

SWAKS pour SWiss Army Knife for SMTP, est un client SMTP, qui permet d'envoyer facilement des mails via des scripts bash.
Avec lui, pas besoin d'installer postfix et de le configurer en relais SMTP !

# Sommaire
- [Installation](#installation)
- [Configuration](#configuration)
- [Utilisation](#utilisation)
- [Script - swaks-conf](#script---swaks-conf)



## Installation
```sh
apt update && apt upgrade && apt install swaks
```

## Configuration
Editer le fichier `/etc/hosts` pour ajouter l'association IP ndd :
```
10.10.200.231 mail.homux.me
```

Créer un fichier de configuration de swaks à la racine de l'utilisateur :
```sh
nano $HOME/.swaksrc
```
pour y mettre les options suivantes :
```
-s mail.homux.me:587
-tls
-au postmaster@homux.me
-ap password
-f postmaster@homux.me
```
**Options** :
- -t : Destinataire (to)
- -s : SMTP à utiliser
- -tls : On active le mode TLS (STARTTLS)
- -au : Identifiant pour s'authentifier sur le SMTP (Auth Username)
- -ap : Mot de passe pour s'authentifier sur le SMTP (Auth Password)
- -f : Expéditeur (From). important sinon c'est envoyé depuis user@serveur !

## Utilisation
```sh
swaks -t test@homux.me --body "contenu du message" --h-subject "Sujet du message"
```

```sh
swaks -t test@homux.me --body ~/message.txt --h-subject "Message de test"
```

## Script - swaks-conf
Ce script permet de configurer un client smtp sur une machine à partir des paramètres fournis

**Usage**
```sh
bash swaks-conf --smtp-port "587" --smtp-ip "10.10.200.231" --smtp-name "mail.homux.me" --username "postmaster@homux.me" --password "password"
```

**Paramètres**
```sh
--smtp-port   : SMTP port to use (25 or 587)
--smtp-ip     : IP of mail server
--smtp-name   : mail server associated domain name
--username   : username (email address) used to send messages
--password   : password used with username
```