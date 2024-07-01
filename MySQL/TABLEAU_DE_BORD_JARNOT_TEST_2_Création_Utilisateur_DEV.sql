-- A exécuter dans la console :
-- cat TABLEAU_DE_BORD_JARNOT_TEST_2_Création_Utilisateur_DEV.sql | sudo mysql -u root -pyannick



CREATE USER IF NOT EXISTS 'DEV'@'localhost' IDENTIFIED BY 'pw@DEV';
GRANT ALL PRIVILEGES ON TABLEAU_DE_BORD_JARNOT_TEST.* TO 'DEV'@'localhost';
FLUSH PRIVILEGES;