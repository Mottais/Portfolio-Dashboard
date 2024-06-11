# PORTFOLIO/models.py
import MySQLdb


class AccesBDD:
    def __init__(self):
        print('Connexion à la base de données')
        self.connexion = MySQLdb.connect(
            host="localhost",
            port=3306,
            user='DEV',
            passwd='pw@DEV',
            db='TABLEAU_DE_BORD_JARNOT_DEV')

    def get_ops_by_id_projet(self, projet_id):
        curseur = self.connexion.cursor()
        curseur.execute(
            """
            SELECT nom_paquet, nom_etape, T_OPERATIONS.id,texte_op, statut_op
            FROM T_PROJETS
            INNER JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
            LEFT JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
            LEFT JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id
                                    AND T_OPERATIONS.id_etape = T_ETAPES.id
            WHERE T_PROJETS.id = %s
            ORDER BY nom_projet, ordre_paquet, ordre_etape
            """, (projet_id,))

        rows = curseur.fetchall()
        curseur.close()
        ops_projet = {}
        for paquet, etape, id, texte, statut in rows:
            if paquet not in ops_projet:
                ops_projet[paquet] = {}
            ops_projet[paquet][etape] = {'id': id, 'texte': texte, 'statut': statut}
        return ops_projet

    def connexion_close(self):
        print('Fermeture de la connexion à la base de données')
        self.connexion.close()