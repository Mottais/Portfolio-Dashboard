from flask import Flask, render_template, g
from models import AccesBDD

app = Flask(__name__)


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


# Définition de la route pour afficher le détail d'un projet
@app.route('/Tableau_de_bord_JARNOT/Projets/<int:projet_id>')
def detail_projet(projet_id):
    base_de_donnees = get_database()

    projets = base_de_donnees.get_all_projets()
    projet = base_de_donnees.get_info_projet_by_id(projet_id)
    ops_projet = base_de_donnees.get_ops_by_id_projet(projet_id)

    return render_template('Tableau_de_Bord.html', projets=projets, projet=projet, ops_projet=ops_projet)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
