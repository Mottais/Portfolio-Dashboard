from flask import Flask, render_template, g, request, jsonify, redirect, flash
from flask_socketio import SocketIO
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from models import AccesBDD

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
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
    base_de_donnees = get_database()
    compte = base_de_donnees.get_compte_by_id(user_id)
    if compte:
        return Utilisateur(compte['id'], compte['nom'], compte['pw'])
    return None


@app.route('/login', methods=['GET', 'POST'])
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        nom = request.form.get('nom')
        mot_de_passe = request.form.get('mot_de_passe')

        base_de_donnees = get_database()
        compte = base_de_donnees.get_compte_by_nom_pw(nom, mot_de_passe)

        if compte:
            login_user(Utilisateur(compte['id'], compte['nom'], compte['pw']), remember=False)
            return redirect('/Tableau_de_bord_JARNOT/Projets/')
        else:
            flash('Connexion échouée. Vérifiez vos identifiants.', category='error')
    return render_template('login.html')


@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect('/login')


# Fonction pour obtenir la connexion à la base de données
def get_database():
    if '_database' not in g:
        g._database = AccesBDD()
    return g._database


# Définition de la fonction pour fermer la connexion à la base de données
@app.teardown_appcontext
def close_database_connection(exception=None):
    base_de_donnees = getattr(g, '_database', None)
    if base_de_donnees is not None:
        base_de_donnees.connexion_close()


# Définition de la route pour afficher la liste des projets en cours
@app.route('/Tableau_de_bord_JARNOT/Projets/')
def tableau_de_bord():
    base_de_donnees = get_database()
    projets = base_de_donnees.get_all_projets()
    return render_template('Tableau_de_Bord.html', projets=projets, name=current_user.nom)


# Définition de la route pour afficher le détail d'un projet
@app.route('/Tableau_de_bord_JARNOT/Projets/<int:projet_id>')
@login_required
def detail_projet(projet_id):
    base_de_donnees = get_database()

    projets = base_de_donnees.get_all_projets()
    projet = base_de_donnees.get_info_projet_by_id(projet_id)
    ops_projet = base_de_donnees.get_ops_by_id_projet(projet_id)

    return render_template('Tableau_de_Bord.html', projets=projets, projet=projet, ops_projet=ops_projet, name=current_user.nom)


# Définition de la route pour mettre à jour le statut de l'opération
@app.route('/Tableau_de_bord_JARNOT/update_statut/', methods=['PUT'])
def update_statut():
    # Récupération des données envoyées depuis le frontend
    operation_id = request.json['id']
    nouveau_statut = request.json['nouveau_statut']

    # Mise à jour du statut de l'opération dans la base de données
    base_de_donnees = get_database()
    success = base_de_donnees.update_statut_operation(operation_id, nouveau_statut, current_user.nom)

    # Envoi de la réponse au frontend
    if success:
        socketio.emit('update_status', {'id': operation_id, 'nouveau_statut': nouveau_statut, 'compte': current_user.nom}, namespace='/')
        return jsonify({'success': True,
                        'message': f'Statut de l\'opération {operation_id} mis à jour avec succès'})
    else:
        return jsonify({'success': False,
                        'message': f'Echec de la mise à jour du statut de l\'op id:{operation_id}'})


if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000)
