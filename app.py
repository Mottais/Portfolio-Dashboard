from flask import Flask, render_template, g, request, jsonify
from flask_socketio import SocketIO
from models import AccesBDD

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app)


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
    return render_template('Tableau_de_Bord.html', projets=projets)


# Définition de la route pour afficher le détail d'un projet
@app.route('/Tableau_de_bord_JARNOT/Projets/<int:projet_id>')
def detail_projet(projet_id):
    base_de_donnees = get_database()

    projets = base_de_donnees.get_all_projets()
    projet = base_de_donnees.get_info_projet_by_id(projet_id)
    ops_projet = base_de_donnees.get_ops_by_id_projet(projet_id)

    return render_template('Tableau_de_Bord.html', projets=projets, projet=projet, ops_projet=ops_projet)


# Définition de la route pour mettre à jour le statut de l'opération
@app.route('/Tableau_de_bord_JARNOT/update_statut/', methods=['PUT'])
def update_statut():
    # Récupération des données envoyées depuis le frontend
    operation_id = request.json['id']
    nouveau_statut = request.json['nouveau_statut']

    # Mise à jour du statut de l'opération dans la base de données
    base_de_donnees = get_database()
    success = base_de_donnees.update_statut_operation(operation_id, nouveau_statut)

    # Envoi de la réponse au frontend
    if success:
        socketio.emit('update_status', {'id': operation_id, 'nouveau_statut': nouveau_statut}, namespace='/')
        return jsonify({'success': True,
                        'message': f'Statut de l\'opération {operation_id} mis à jour avec succès'})
    else:
        return jsonify({'success': False,
                        'message': f'Echec de la mise à jour du statut de l\'op id:{operation_id}'})


if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000)
