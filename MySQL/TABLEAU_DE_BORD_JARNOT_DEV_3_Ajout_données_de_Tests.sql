-- A exécuter dans la console :
-- cat TABLEAU_DE_BORD_JARNOT_DEV_3_Ajout_données_de_Tests.sql | mysql -u DEV -ppw@DEV

USE TABLEAU_DE_BORD_JARNOT_DEV;

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
    VALUES (3, 2 , 'Atelier Bois', '', 0,'moi');


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
INSERT INTO T_OPERATIONS ( id_etape, id_paquet, profil_op, texte_op, statut_op, compte_op)
    VALUES (7, 7, 'Atelier Bois', 'A FAIRE', 0,'moi');





-- Lister les noms des tables dans la base de données
SHOW TABLES;





-- Imprimer
SELECT 'LISTE des PROJETS' AS ''; # Affiche u commentaire
SELECT * FROM T_PROJETS ORDER BY id;




SELECT 'PAQUETS des PROJETS' AS ''; # Affiche u commentaire
SELECT nom_projet, nom_paquet FROM T_PROJETS
    LEFT JOIN T_PAQUETS ON id_projet = T_PROJETS.id
    ORDER BY nom_projet, nom_paquet;

SELECT 'ETAPES des PROJETS' AS ''; # Affiche u commentaire
SELECT nom_projet, nom_etape
    FROM T_PROJETS
    LEFT JOIN T_ETAPES ON id_projet = T_PROJETS.id
    ORDER BY nom_projet, nom_etape;


SELECT 'OPERATIONS PROJETS A' AS ''; # Affiche u commentaire
SELECT nom_projet, T_PROJETS.id, ordre_paquet, nom_paquet, T_PAQUETS.id, ordre_etape, nom_etape, T_ETAPES.id, statut_op, compte_op, texte_op
    FROM T_PROJETS
    LEFT JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
    LEFT JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
    LEFT JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id AND T_OPERATIONS.id_etape = T_ETAPES.id
    WHERE nom_projet LIKE '%A%'
    ORDER BY ordre_paquet, ordre_etape;


    SELECT '*****   TABLEAU_DE_BORD_JARNOT_DEV  prêt pour le test *****' AS ''; # Affiche u commentaire
    SELECT '' AS '***********************************************************';


