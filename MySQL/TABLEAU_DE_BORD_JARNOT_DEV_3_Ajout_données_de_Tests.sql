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


-- Insérer nouveau(x) compte
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('admin', 'pwadmin');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('toto', 'toto');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('Tristan', 'pwTristan');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('Didier', 'pwDidier');
INSERT INTO T_COMPTES (nom_compte, pw_compte) VALUES ('Jordan', 'pwJordan');


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

-- Liste des projets avec les opérations
SELECT nom_projet, T_PROJETS.id, nom_paquet, nom_etape, statut_op, compte_op, date_modif_op, texte_op
    FROM T_PROJETS
    LEFT JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
    LEFT JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
    INNER JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id AND T_OPERATIONS.id_etape = T_ETAPES.id
    WHERE  T_PROJETS.id = 1
    ORDER BY date_modif_op;

-- Liste des projets non finis et nombre d'opérations total
SELECT T_PROJETS.id, nom_projet "Projets non finis", version_projet, COUNT(T_OPERATIONS.id) "nb op pas finis"
    FROM T_PROJETS
    INNER JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
    INNER JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
    INNER JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id AND T_OPERATIONS.id_etape = T_ETAPES.id
    WHERE statut_op <> 100
    GROUP BY T_PROJETS.id, nom_projet, version_projet;


-- Liste des projets avec nb opérations ,finis, à finir et date de dernière modification
SELECT T_PROJETS.id, nom_projet AS "Projets", version_projet Version, COUNT(T_OPERATIONS.id) "Nb op",
SUM(CASE WHEN statut_op = 100 THEN 1 ELSE 0 END) AS "dont finies",
SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) AS "dont à finir",
MAX(T_OPERATIONS.date_modif_op) AS "date derniere modif opération"
FROM T_PROJETS
INNER JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
INNER JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
INNER JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id AND T_OPERATIONS.id_etape = T_ETAPES.id
GROUP BY T_PROJETS.id, nom_projet, version_projet;

-- Liste des projets terminés depuis moins de 7 jours
SELECT T_PROJETS.id, nom_projet AS "Projets finis", version_projet Version
FROM T_PROJETS
INNER JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
INNER JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
INNER JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id AND T_OPERATIONS.id_etape = T_ETAPES.id
GROUP BY T_PROJETS.id, nom_projet, version_projet
HAVING
SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) = 0
AND MAX(T_OPERATIONS.date_modif_op) > DATE_SUB(NOW(), INTERVAL 7 DAY);

-- Liste des projets PAS terminés
SELECT T_PROJETS.id, nom_projet AS "Projets PAS finis", version_projet Version
FROM T_PROJETS
INNER JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
INNER JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
INNER JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id AND T_OPERATIONS.id_etape = T_ETAPES.id
GROUP BY T_PROJETS.id, nom_projet, version_projet
HAVING
SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) <> 0;


-- Liste des projets PAS terminés ou terminés depuis moins de 7 jours
-- Les projet terminés en fin de liste
SELECT T_PROJETS.id, nom_projet AS "Projet Tableau de bord", version_projet Version,
SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) AS "Nb op à finir"
FROM T_PROJETS
INNER JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
INNER JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
INNER JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id AND T_OPERATIONS.id_etape = T_ETAPES.id
GROUP BY T_PROJETS.id, nom_projet, version_projet
HAVING
-- Projet PAS terminés
(SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) <> 0)
OR
-- Projet terminés depuis moins de 7 jours
(SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) = 0
AND MAX(T_OPERATIONS.date_modif_op) > DATE_SUB(NOW(), INTERVAL 7 DAY))

ORDER BY
    CASE WHEN SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) <> 0 THEN 1 ELSE 2 END ASC,
    T_PROJETS.id DESC;







