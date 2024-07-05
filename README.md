# Portfolio-Dashboard


### TABLE DES MATIÈRES
- [DESCRIPTION](#description)
- [PREREQUIS](#prerequis)
- [INSTALLATION](#installation)
- [LANCEMENT](#lancement)
- [TESTS](#tests)
- [UTILISATION](#utilisation)
- [AUTEUR](#auteur)


### DESCRIPTION

Outil de visualisation et de mise à jour de l'avancement des projets pour les entreprises de construction utilisant le logiciel SEMA :
- pour et par tous les salariés,
- n'importe où (bureaux, ateliers, chantiers...),
- __et en temps réel__

Cliquez [ici](https://mottais.github.io/Landing_Pages/LandingPageFR.html) pour plus de détail.


### PREREQUIS
Avoir une licence SEMA

Avoir une licence Excel


### INSTALLATION

#### Cloner le dépôt :

    git clone https://github.com/Mottais/Portfolio-Dashboard.git

#### sur le serveur de l'entreprise
Copiez le fichier "Modèle_Tableau_de_Bord.xlsm" dans un dossier du serveur de l'entreprise.

Ce fichier doit être accéssible par le personnel qui utilise SEMA et le superviseur.

#### Dans SEMA
##### Dans les réglages généraux de SEMA [Alt + F7]: 
- précisez où se trouve le fichier modèle Excel.
- et où vous souhaitez exporter les fichiers Excel avec modèle.

![flowchart](https://github.com/Mottais/Images/blob/104796b92013e227484f5c27a16782dc049e1805/Portfolio-Dashboard/AF7.jpg)

<br>

##### Dans les listes SEMA :
Créez un nouvel onglet avec le fichier __'Liste_Tableau_de_Bord.DOT'__

<br><br><br>

#### Sur le Serveur de l'application (Ubuntu-20.04)

__installez Python Version: 3.8.10__

    sudo apt update
    sudo apt upgrade
    sudo apt install python3.8


__installez Flask Version: 3.0.3__

    pip install Flask==3.0.3


__installez FlaskSocketIO Version: 5.3.6__

    pip install flask-socketio==5.3.6


__installez Flask-Login Version: 0.6.3__

    pip install Flask-Login==0.6.3


__installez MySQLdb Version: 2.2.4__

    pip install mysqlclient==2.2.4

    
__installez MySQL Server Version: 8.0.37-0ubuntu0.20.04.3__ for Linux on x86_64 ((Ubuntu))

    sudo apt install mysql-server

__Créez la Base de donnée :__

    cat TABLEAU_DE_BORD_JARNOT_DEV_1_Création_Base_De_Donnees.sql | sudo mysql -u root -p

__Créez un utilisateur :__

    cat TABLEAU_DE_BORD_JARNOT_DEV_2_Création_Utilisateur_DEV.sql | sudo mysql -u root -p




### LANCEMENT

__Exécuter le proramme app.py à la racine du projet:__

		python3 app.py

### TESTS

__Exécuter les tests à la racine du projet :__

    python3 -m unittest discover -s tests



### UTILISATION

Visionnez cette vidéo :
[![Vidéo_Démo](https://github.com/Mottais/Images/blob/38d31e307ec85b56a0031eda92b31dc66bde537d/Portfolio-Dashboard/Acceuil_Demo_FR.jpg)](https://www.youtube.com/watch?v=vmoC8oMKvtE)

### AUTEUR

Yannick Mottais
