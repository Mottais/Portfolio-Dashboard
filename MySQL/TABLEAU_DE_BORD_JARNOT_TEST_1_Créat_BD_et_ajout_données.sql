-- A exécuter dans la console :  TABLEAU_DE_BORD_JARNOT_DEV
-- cat TABLEAU_DE_BORD_JARNOT_TEST_1_Créat_BD_et_ajout_données.sql | sudo mysql
CREATE DATABASE IF NOT EXISTS TABLEAU_DE_BORD_JARNOT_TEST;

USE TABLEAU_DE_BORD_JARNOT_TEST;

-- Supprimer les tables si elles existent

DROP TABLE IF EXISTS T_OPERATIONS;
DROP TABLE IF EXISTS T_ETAPES;
DROP TABLE IF EXISTS T_PAQUETS;
DROP TABLE IF EXISTS T_PROJETS;
DROP TABLE IF EXISTS T_COMPTE_PROFIL;
DROP TABLE IF EXISTS T_COMPTES;
DROP TABLE IF EXISTS T_PROFILS;


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

CREATE TABLE IF NOT EXISTS T_COMPTES (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom_compte VARCHAR(64) NOT NULL UNIQUE,
    pw_compte VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS T_PROFILS (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom_profil VARCHAR(64) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS T_COMPTE_PROFIL (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_compte INT NOT NULL,
    id_profil INT NOT NULL,
    date_creation_comp_prof TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modif_comp_prof TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (id_compte, id_profil),
    FOREIGN KEY (id_compte) REFERENCES T_COMPTES(id) ON DELETE CASCADE,
    FOREIGN KEY (id_profil) REFERENCES T_PROFILS(id) ON DELETE CASCADE
);

SHOW TABLES;








-- Insérer des données dans la table T_PROJETS
INSERT INTO
T_PROJETS (nom_projet, add_projet, cp_projet, ville_projet, dessinateur_projet)
VALUES ('Projet TEST A', '123 Rue des Fleurs', '35000', 'RENNES', 'Philippe');

INSERT INTO
T_PROJETS (nom_projet, add_projet, cp_projet, ville_projet, dessinateur_projet)
VALUES ('Projet TEST B', '123 Rue des Champs', '53000', 'LAVAL', 'Philippe');

INSERT INTO
T_PROJETS (nom_projet, add_projet, cp_projet, ville_projet, dessinateur_projet)
VALUES ('Projet TEST C', '123 Rue des Arbres', '35000', 'RENNES', 'Julien');



-- Insérer des données dans la table T_ETAPES
-- Projet TEST A
INSERT INTO T_ETAPES (id_projet, nom_etape, ordre_etape) VALUES
    (1, 'ETAPE1', 10),
    (1, 'ETAPE2', 20),
    (1, 'ETAPE3', 30),

-- Projet TEST B
    (2, 'ETAPE1', 10),
    (2, 'ETAPE2', 20),
    (2, 'ETAPE3', 30),

-- Projet TEST C
    (3, 'ETAPE1', 10),
    (3, 'ETAPE2', 20),
    (3, 'ETAPE3', 30),
    (3, 'ETAPE4', 40),
    (3, 'ETAPE5', 50),
    (3, 'ETAPE6', 60),
    (3, 'ETAPE7', 70),
    (3, 'ETAPE8', 80),
    (3, 'ETAPE9', 90),
    (3, 'ETAPE10', 100)
    ;

-- Projet TEST A
INSERT INTO T_PAQUETS (id_projet, nom_paquet, ordre_paquet) VALUES
    (1, 'PAQ A1', 10),
    (1, 'PAQ A2', 20),
    (1, 'PAQ A3', 30),

-- Projet TEST B
    (2, 'PAQ B1', 10),
    (2, 'PAQ B2', 20),
    (2, 'PAQ B3', 30),

-- Projet TEST C
    (3, 'PAQ C1', 10),
    (3, 'PAQ C2', 20),
    (3, 'PAQ C3', 30),
    (3, 'PAQ C4', 40),
    (3, 'PAQ C5', 50),
    (3, 'PAQ C6', 60),
    (3, 'PAQ C7', 70),
    (3, 'PAQ C8', 80),
    (3, 'PAQ C9', 90),
    (3, 'PAQ C10', 100),
    (3, 'PAQ C11', 110),
    (3, 'PAQ C12', 120),
    (3, 'PAQ C13', 130),
    (3, 'PAQ C14', 140),
    (3, 'PAQ C15', 150),
    (3, 'PAQ C16', 160),
    (3, 'PAQ C17', 170),
    (3, 'PAQ C18', 180),
    (3, 'PAQ C19', 190);

-- Insérer des données dans la table T_OPERATIONS pour Projet TEST A
INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (1, 1, 'Atelier Bois', 'VOIR LISTE', 0,'moi');
INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (1, 2, 'Atelier Bois', 'VOIR LISTE', 0,'moi');

INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (1, 3, 'Atelier Bois', 'VOIR LISTE', 0,'moi');

INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (2, 1 , 'Atelier Bois', '', 0,'moi');

INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (2, 2 , 'Atelier Bois', '', 0,'moi');

INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (3, 2 , 'Atelier Bois', '', 100,'moi');


UPDATE T_OPERATIONS
     SET statut_op = 100, compte_op = 'lui'
     WHERE id = 1;

UPDATE T_OPERATIONS
     SET statut_op = 100, compte_op = 'lui'
     WHERE id = 2;


-- Insérer des données dans la table T_OPERATIONS pour Projet TEST B
INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (4, 4, 'Atelier Bois', 'A FAIRE', 0,'moi');
INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (4, 6, 'Atelier Bois', 'A FAIRE', 0,'moi');

INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (6, 6 , 'Atelier Bois', 'A FAIRE', 0,'moi');


-- Insérer des données dans la table T_OPERATIONS pour Projet TEST C
INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op, date_modif_op)
    VALUES (7, 7, 'Atelier Bois', 'A FAIRE', 100,'moi', '2024-01-01 00:42:27');


-- Insérer nouveau(x) compte
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('admin', 'pwadmin');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('toto', 'toto');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('Tristan', 'pwTristan');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('Didier', 'pwDidier');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('Jordan', 'pwJordan');

-- Insérer nouveau(x) profil
INSERT INTO T_PROFILS (nom_profil) VALUES
    ("Atelier Bois"),
    ("Atelier Zinguerie"),
    ("Magazin"),
    ("Chauffeur"),
    ("Chantier"),
    ("Conducteur travaux");

-- Insérer nouveau(x) compte-profil

INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (1, 1);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (1, 2);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (1, 3);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (1, 4);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (1, 5);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (1, 6);   

INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (2, 2);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (3, 3);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (4, 4);
INSERT INTO T_COMPTE_PROFIL (id_compte, id_profil) VALUES (5, 5);

SELECT * FROM T_PROJETS;