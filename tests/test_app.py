# commande a éxécuter pour lancer les tests à la racine du projet:
# python3 -m unittest discover -s tests
# remarque : placer le fichier test_app.py dans le dossier racine du projet
# pour pouvoir tester le fichier en mode débogage dans VSCode

import unittest
from unittest.mock import patch
from app import app, AccesBDD


class BasicTests(unittest.TestCase):

    def setUp(self):
        self.app = app
        self.client = self.app.test_client()
        self.app.config['TESTING'] = True

    def test_login_get(self):
        # Test de la route /login en mode GET
        response = self.client.get('/login')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'<title>Login</title>', response.data)

    # Simulation méthode get_compte_by_nom_pw retournant compte fictif
    @patch.object(AccesBDD, 'get_compte_by_nom_pw',
                  return_value={'id': 1, 'nom': 'test_user', 'pw': 'test_pw'})
    def test_login_post(self, mock_get_compte):
        # Test de la route /login en mode POST avec un compte fictif
        response = self.client.post('/login',
                                    data=dict(nom='test_user', pw='test_pw'))
        # Redirection 302 attendue après une connexion réussie
        self.assertEqual(response.status_code, 302)
        self.assertIn('/Tableau_de_bord_JARNOT/Projets/',
                      response.headers['Location'])

    def test_login_post_admin(self):
        # Test de la route /login en mode POST avec le compte administrateur
        response = self.client.post(
            '/login', data=dict(nom='admin', mot_de_passe='pwadmin'))
        # Redirection 302 attendue après une connexion réussie
        self.assertEqual(response.status_code, 302)
        self.assertIn('/Tableau_de_bord_JARNOT/Projets/',
                      response.headers['Location'])

    @patch.object(AccesBDD, 'get_compte_by_nom_pw', return_value=None)
    def test_login_post_invalid(self, mock_get_compte):
        # Test de la route /login en mode POST avec un compte inexistant
        response = self.client.post(
            '/login', data=dict(nom='wrong_user', mot_de_passe='wrong_pw'))
        self.assertEqual(response.status_code, 200)
        # Encodage UTF-8 car le texte contient des caractères spéciaux
        self.assertIn('Connexion échouée. Vérifiez vos identifiants.'.encode(
            'utf-8'), response.data)

    def test_login_post_invalid_pw(self):
        # Test de la route /login en mode POST avec un mot de passe incorrect
        response = self.client.post(
            '/login', data=dict(nom='wrong_user', pw='wrong_pw'))
        self.assertEqual(response.status_code, 200)
        self.assertIn('Connexion échouée. Vérifiez vos identifiants.'.encode(
            'utf-8'), response.data)

    def test_logout(self):
        # Test de la route /logout
        self.client.post('/login', data=dict(nom='test_user',
                         mot_de_passe='test_pw'), follow_redirects=True)
        response = self.client.get('/logout', follow_redirects=True)
        self.assertIn(b'Login', response.data)

    def test_liste_projetsx(self):
        # Test de la route /Tableau_de_bord_JARNOT/Liste_Projets/
        response = self.client.get('/Tableau_de_bord_JARNOT/Liste_Projets/')
        self.assertEqual(response.status_code, 200)
        self.assertTrue(response.is_json)

    @patch.object(AccesBDD, 'get_compte_by_nom_pw',
                  return_value={'id': 1, 'nom': 'test_user', 'pw': 'test_pw'})
    def test_detail_projet(self, mock_get_compte):
        # Test de la route /Tableau_de_bord_JARNOT/Projets/1
        self.client.post('/login', data=dict(nom='test_user', pw='test_pw'))
        response = self.client.get('/Tableau_de_bord_JARNOT/Projets/1')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'<title>PORTFOLIO TABLEAU</title>', response.data)
        self.assertIn('text/html', response.headers['Content-Type'])

    @patch.object(AccesBDD, 'get_compte_by_nom_pw',
                  return_value={'id': 1, 'nom': 'test_user', 'pw': 'test_pw'})
    def test_detail_projet_sans_id(self, mock_get_compte):
        # Test de la route /Tableau_de_bord_JARNOT/Projets/ sans id
        self.client.post('/login', data=dict(nom='test_user', pw='test_pw'))
        response = self.client.get('/Tableau_de_bord_JARNOT/Projets/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'<title>PORTFOLIO TABLEAU</title>', response.data)
        self.assertIn('text/html', response.headers['Content-Type'])

    @patch.object(AccesBDD, 'get_compte_by_nom_pw',
                  return_value={'id': 1, 'nom': 'test_user', 'pw': 'test_pw'})
    def test_detail_projet_sans_errone(self, mock_get_compte):
        # Test de la route /Tableau_de_bord_JARNOT/Projets/ id erroné
        self.client.post('/login', data=dict(nom='test_user', pw='test_pw'))
        response = self.client.get('/Tableau_de_bord_JARNOT/Projets/id_errone')
        self.assertEqual(response.status_code, 404)
        self.assertIn(b'<title>404 Not Found</title>', response.data)

    @patch.object(AccesBDD, 'get_compte_by_nom_pw',
                  return_value={'id': 1, 'nom': 'test_user', 'pw': 'test_pw'})
    def test_update_statut(self,mock_get_compte):
        # Test de la route /Tableau_de_bord_JARNOT/update_statut/
        self.client.post('/login', data=dict(nom='test_user', pw='test_pw'))
        response = self.client.put('/Tableau_de_bord_JARNOT/update_statut/',
                                   json={'id': 1, 'nouveau_statut': 101})
        self.assertEqual(response.status_code, 200)
        print(response.json)
        self.assertTrue(response.is_json)
        self.assertTrue(response.json['success'])
        self.client.post('/login', data=dict(nom='test_user', pw='test_pw'))
        # modification du statut de l'op pour pouvoir relancer le test sans echec
        response = self.client.put('/Tableau_de_bord_JARNOT/update_statut/',
                                   json={'id': 1, 'nouveau_statut': 100})

    @patch.object(AccesBDD, 'get_compte_by_nom_pw',
                  return_value={'id': 1, 'nom': 'test_user', 'pw': 'test_pw'})
    def test_update_statut_id_inconnu(self, mock_get_compte):
        # Test de la route /Tableau_de_bord_JARNOT/update_statut/ id inconnu
        self.client.post('/login', data=dict(nom='test_user', pw='test_pw'))
        response = self.client.put('/Tableau_de_bord_JARNOT/update_statut/',
                                   json={'id': 9999999999999, 'nouveau_statut': 100})
        self.assertEqual(response.status_code, 200)
        print(response.json)
        self.assertFalse(response.json['success'])

    # @patch.object(AccesBDD, 'get_compte_by_nom_pw',
    #               return_value={'id': 1, 'nom': 'test_user', 'pw': 'test_pw'})
    # def test_update_statut_id_errone(self, mock_get_compte):
    #     self.client.post('/login', data=dict(nom='test_user', pw='test_pw'))
    #     response = self.client.put('/Tableau_de_bord_JARNOT/update_statut/',
    #                                json={'id': 1, 'nouveau_statut': 'texte'})
    #     self.assertEqual(response.status_code, 200)
    #     print(response.json)
    #     self.assertFalse(response.json['success'])


if __name__ == "__main__":
    unittest.main()
