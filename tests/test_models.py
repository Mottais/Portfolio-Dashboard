import unittest
import MySQLdb
from datetime import datetime
from models import AccesBDD
import os

class TestAccesBDD(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.base_de_donnees = AccesBDD('TABLEAU_DE_BORD_JARNOT_TEST')
        cls._execute_sql_script('./MySQL/TABLEAU_DE_BORD_JARNOT_TEST_1_Créat_BD_et_ajout_données.sql')

    @classmethod
    def tearDownClass(cls):
        cls.base_de_donnees.connexion_close()

    @classmethod
    def _execute_sql_script(cls, script_path):
        # Connexion à la base de données
        conn = MySQLdb.connect(
            host="localhost",
            port=3306,
            user='DEV',
            passwd='pw@DEV',
            db='TABLEAU_DE_BORD_JARNOT_TEST'
        )
        cursor = conn.cursor()
        
        # Lire le fichier SQL
        with open(script_path, 'r') as file:
            sql_script = file.read()
        
        # Exécuter le script SQL
        for statement in sql_script.split(';'):
            if statement.strip():
                cursor.execute(statement)
        
        # Valider les modifications et fermer la connexion
        conn.commit()
        cursor.close()
        conn.close()

    def test_get_compte_by_id_existant(self):
        # test de la fonction get_compte_by_id avec id existant
        compte = self.base_de_donnees.get_compte_by_id(1)
        self.assertEqual(compte, {'id': 1, 'nom': 'admin', 'pw': 'pwadmin'})

    def test_get_compte_by_id_inexistant(self):
        # test de la fonction get_compte_by_id avec id inexistant
        compte = self.base_de_donnees.get_compte_by_id(5)
        self.assertNotEqual(compte, {None})

    def test_get_compte_by_id_non_valide(self):
        # test de la fonction get_compte_by_id avec id non valide
        compte = self.base_de_donnees.get_compte_by_id('non_valid_id')
        self.assertEqual(compte, {None})

    def test_get_compte_by_nom_pw_existant(self):
        # test de la fonction get_compte_by_nom_pw avec nom et pw existant
        compte = self.base_de_donnees.get_compte_by_nom_pw('admin', 'pwadmin')
        self.assertEqual(compte, {'id': 1, 'nom': 'admin', 'pw': 'pwadmin'})

    def test_get_profils_user_existant(self):
        # test de la fonction get_profils_user avec nom existant
        profils = self.base_de_donnees.get_profils_user('admin')
        self.assertEqual(profils, ['Atelier Bois', 'Atelier Zinguerie', 'Magazin', 'Chauffeur', 'Chantier', 'Conducteur travaux'])

    def test_get_profils_user_non_existant(self):
        # test de la fonction get_profils_user avec nom inexistant
        profils = self.base_de_donnees.get_profils_user('toto')
        self.assertEqual(profils, ['Atelier Zinguerie'])

    def test_get_all_projets_avant_01012024(self):
        # test de la fonction get_all_projets date avant 01/01/2024
        nb_jours = (datetime.today() - datetime(2024, 1, 1)).days
        liste_prj_en_cours = self.base_de_donnees.get_all_projets(nb_jours + 1)
        self.assertEqual(len(liste_prj_en_cours), 3)

    def test_get_all_projets_apres_01012024(self):
        # test de la fonction get_all_projets date après 01/01/2024
        nb_jours = (datetime.today() - datetime(2024, 1, 1)).days
        liste_prj_en_cours = self.base_de_donnees.get_all_projets(nb_jours)
        self.assertEqual(len(liste_prj_en_cours), 2)
        self.assertEqual(liste_prj_en_cours[0]['nb_ops_non_finies'], 3)
        self.assertEqual(liste_prj_en_cours[0], {'id': 1, 'nom': 'Projet TEST A', 'version': None, 'nb_ops_non_finies': 3})

    def test_get_all_projets_parametre_non_valide(self):
        # test de la fonction get_all_projets avec un paramètre non valide
        liste_prj_en_cours = self.base_de_donnees.get_all_projets('non_valid_nb_jours')
        self.assertEqual(len(liste_prj_en_cours), 2)

    def test_get_info_projet_by_id_existant(self):
        # test de la fonction get_info_projet_by_id avec id existant
        info_prj = self.base_de_donnees.get_info_projet_by_id(1)
        self.assertEqual(info_prj, {'id': 1, 'nom': 'Projet TEST A', 'version': None, 'adresse': '123 Rue des Fleurs', 'cp': '35000', 'ville': 'RENNES'})

    def test_get_info_projet_by_id_inexistant(self):
        # test de la fonction get_info_projet_by_id avec id inexistant
        info_prj = self.base_de_donnees.get_info_projet_by_id(4)
        self.assertEqual(info_prj, {None})

    def test_get_info_projet_by_id_non_valide(self):
        # test de la fonction get_info_projet_by_id avec id non valide
        info_prj = self.base_de_donnees.get_info_projet_by_id('non_valid_id')
        self.assertEqual(info_prj, {None})

    def test_get_ops_by_id_projet_existant(self):
        # test de la fonction get_ops_by_id_projet avec id existant
        liste_op_prj = self.base_de_donnees.get_ops_by_id_projet(3)
        self.assertEqual(len(liste_op_prj), 19)

    def test_get_ops_by_id_projet_non_valide(self):
        # test de la fonction get_ops_by_id_projet avec id non valide
        liste_op_prj = self.base_de_donnees.get_ops_by_id_projet('non_valid_id')
        self.assertEqual(len(liste_op_prj), 0)

    def test_update_statut_operation(self):
        # test de la update_statut_operation
        liste_prj_en_cours = self.base_de_donnees.get_all_projets(0)
        self.assertEqual(len(liste_prj_en_cours), 2)
        self.base_de_donnees.update_statut_operation(7, 100, 'testeur')
        self.base_de_donnees.update_statut_operation(8, 100, 'testeur')
        self.base_de_donnees.update_statut_operation(9, 100, 'testeur')
        liste_prj_en_cours = self.base_de_donnees.get_all_projets(0)
        self.assertEqual(len(liste_prj_en_cours), 1)
        self.base_de_donnees.update_statut_operation(9, 99, 'testeur')
        liste_prj_en_cours = self.base_de_donnees.get_all_projets(0)
        self.assertEqual(len(liste_prj_en_cours), 2)

if __name__ == '__main__':
    unittest.main()
