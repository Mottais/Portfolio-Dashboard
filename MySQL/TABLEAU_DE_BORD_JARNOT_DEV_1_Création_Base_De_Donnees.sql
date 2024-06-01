-- A exécuter dans la console :
-- cat TABLEAU_DE_BORD_JARNOT_DEV_1_Création_Base_De_Donnees.sql | mysql -u root -proot
CREATE DATABASE IF NOT EXISTS TABLEAU_DE_BORD_JARNOT_DEV;

USE TABLEAU_DE_BORD_JARNOT_DEV;

-- Supprimer les tables si elles existent

DROP TABLE IF EXISTS T_OPERATIONS;
DROP TABLE IF EXISTS T_ETAPES;
DROP TABLE IF EXISTS T_PAQUETS;
DROP TABLE IF EXISTS T_PROJETS;


-- Création des tables

CREATE TABLE IF NOT EXISTS T_PROJETS (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom_projet VARCHAR(64) NOT NULL UNIQUE,
    version_projet VARCHAR(8),
    add_projet VARCHAR(128) NOT NULL,
    cp_projet CHAR(8) NOT NULL,
    ville_projet VARCHAR(64) NOT NULL,
    dessinateur_projet VARCHAR(64) NOT NULL
    );

CREATE TABLE IF NOT EXISTS T_ETAPES (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_projet INT NOT NULL,
    nom_etape VARCHAR(64) NOT NULL,
    ordre_etape INT NOT NULL,
    UNIQUE (id_projet, nom_etape),
    FOREIGN KEY (id_projet) REFERENCES T_PROJETS(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS T_PAQUETS (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_projet INT NOT NULL,
    nom_paquet VARCHAR(64) NOT NULL,
    ordre_paquet INT NOT NULL,
    UNIQUE (id_projet, nom_paquet),
    FOREIGN KEY (id_projet) REFERENCES T_PROJETS(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS T_OPERATIONS (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_creation_op TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modif_op TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    id_paquet INT NOT NULL,
    id_etape INT NOT NULL,
    profil_op VARCHAR(64) NOT NULL,
    texte_op VARCHAR(1024),
    statut_op INT DEFAULT NULL,
    compte_op VARCHAR(64),
    UNIQUE (id_paquet, id_etape),
    FOREIGN KEY (id_paquet) REFERENCES T_PAQUETS(id) ON DELETE CASCADE,
    FOREIGN KEY (id_etape) REFERENCES T_ETAPES(id) ON DELETE CASCADE
    );


SHOW TABLES;
