from flask import Flask, render_template, g, request, jsonify, redirect, flash
from flask_socketio import SocketIO
from flask_login import LoginManager, UserMixin, login_user
from flask_login import login_required, logout_user, current_user
from models import AccesBDD
from dotenv import load_dotenv
import os

# Charger les variables d'environnement depuis le fichier .env
load_dotenv()

app = Flask(__name__)
# Utilisation de la clé secrète depuis les variables d'environnement
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')
socketio = SocketIO(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'


class Utilisateur(UserMixin):
    def __init__(self, id, nom, mot_de_passe):
        self.id = id
        self.nom = nom
        self.mot_de_passe = mot_de_passe


@login_manager.user_loader
def load_user(user_id):
    """
    Charge l'utilisateur actuel à partir de la base de données.

    :param user_id: Identifiant de l'utilisateur
    :return: Objet Utilisateur si trouvé, sinon None
    """
    base_de_donnees = get_database()
    compte = base_de_donnees.get_compte_by_id(user_id)
    if compte:
        return Utilisateur(compte['id'], compte['nom'], compte['pw'])
    return None


@app.route('/login', methods=['GET', 'POST'])
@app.route('/', methods=['GET', 'POST'])
def login():
    """
    Gère l'authentification de l'utilisateur.

    :return: Redirection vers le tableau de bord si l'authentification réussit,
             sinon affiche un message d'erreur
    """
    if request.method == 'POST':
        nom = request.form.get('nom')
        mot_de_passe = request.form.get('mot_de_passe')

        base_de_donnees = get_database()
        compte = base_de_donnees.get_compte_by_nom_pw(nom, mot_de_passe)

        if compte:
            login_user(Utilisateur(compte['id'], compte['nom'], compte['pw']),
                       remember=False)
            return redirect('/Tableau_de_bord_JARNOT/Projets/')
        else:
            flash('Connexion échouée. Vérifiez vos identifiants.',
                  category='error')
    return render_template('login.html')


@app.route('/logout')
@login_required
def logout():
    """
    Déconnecte l'utilisateur actuel.

    :return: Redirection vers la page de connexion
    """
    logout_user()
    return redirect('/login')


# Fonction pour obtenir la connexion à la base de données
def get_database():
    """
    Récupère l'objet AccesBDD depuis l'objet global g ou le crée si inexistant.

    :return: Objet AccesBDD
    """
    if '_database' not in g:
        g._database = AccesBDD()
    return g._database


# Définition de la fonction pour fermer la connexion à la base de données
@app.teardown_appcontext
def close_database_connection(exception=None):
    """
    Ferme la connexion à la base de données à la fin de la requête.

    :param exception: Exception en cours
    """
    base_de_donnees = getattr(g, '_database', None)
    if base_de_donnees is not None:
        base_de_donnees.connexion_close()


# Définition de la route pour retourner la liste des projets en cours
@app.route('/Tableau_de_bord_JARNOT/Liste_Projets/')
def Liste_Projets():
    """
    Renvoie la liste des projets en cours au format JSON.

    :return: Liste des projets en cours
    """
    base_de_donnees = get_database()
    projets = base_de_donnees.get_all_projets()
    return jsonify(projets)


# Définition de la route pour afficher le détail d'un projet
@app.route('/Tableau_de_bord_JARNOT/Projets/<int:projet_id>')
@app.route('/Tableau_de_bord_JARNOT/Projets/')
@login_required
def detail_projet(projet_id=0):
    """
    Affiche page Tableau_de_Bord.html avec les détails d'1 projet si id fourni.

    :param projet_id: Identifiant du projet (optionnel)
    :return: Template HTML avec les détails du projet et opérations associées
    """
    base_de_donnees = get_database()
    liste_profils = base_de_donnees.get_profils_user(current_user.nom)
    if projet_id > 0:
        projet = base_de_donnees.get_info_projet_by_id(projet_id)
        ops_projet = base_de_donnees.get_ops_by_id_projet(projet_id)
        return render_template('Tableau_de_Bord.html', name=current_user.nom,
                               liste_profils=liste_profils,
                               projet=projet, ops_projet=ops_projet)
    else:
        return render_template('Tableau_de_Bord.html', name=current_user.nom,
                               liste_profils=liste_profils)


# Définition de la route pour mettre à jour le statut de l'opération
@app.route('/Tableau_de_bord_JARNOT/update_statut/', methods=['PUT'])
def update_statut():
    """
    Met à jour le statut d'une opération spécifique.

    :return: Réponse JSON indiquant le succès ou l'échec de la mise à jour
    """
    # Récupération des données envoyées depuis le frontend
    operation_id = request.json['id']
    nouveau_statut = request.json['nouveau_statut']

    # Mise à jour du statut de l'opération dans la base de données
    base_de_donnees = get_database()
    success = base_de_donnees.update_statut_operation(operation_id,
                                                      nouveau_statut,
                                                      current_user.nom)

    # Envoi de la réponse au frontend
    if success:
        # Émet événement 'update_status' à tous clients connectés via Socket.IO
        socketio.emit('update_status',
                      {'id': operation_id, 'nouveau_statut': nouveau_statut,
                                        'compte': current_user.nom}, namespace='/')
        # Retourner une réponse JSON indiquant le succès de la mise à jour
        return jsonify({'success': True,
                        'message': f'Statut de l\'opération {operation_id} '
                                   'mis à jour avec succès'})
    else:
        # Retourner une réponse JSON indiquant l'échec de la mise à jour
        return jsonify({'success': False,
                        'message': f'Echec de la mise à jour du statut de '
                                   'l\'op id:{operation_id}'})


if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000)
