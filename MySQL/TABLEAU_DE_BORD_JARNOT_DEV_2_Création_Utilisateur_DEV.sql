-- A exécuter dans la console :
-- cat TABLEAU_DE_BORD_JARNOT_DEV_2_Création_Utilisateur_DEV.sql | mysql



CREATE USER IF NOT EXISTS 'DEV'@'localhost' IDENTIFIED BY 'pw@DEV';
GRANT ALL PRIVILEGES ON TABLEAU_DE_BORD_JARNOT_DEV.* TO 'DEV'@'localhost';
FLUSH PRIVILEGES;
