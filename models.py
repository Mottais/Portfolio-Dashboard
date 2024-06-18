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

    def get_compte_by_id(self, compte_id):
        curseur = self.connexion.cursor()
        curseur.execute(
            """
            SELECT id, nom_compte, pw_compte FROM T_COMPTES
            WHERE   id = %s
            """, (compte_id,))

        compte = curseur.fetchone()
        curseur.close()

        if compte:
            return {'id': compte[0], 'nom': compte[1], 'pw': compte[2]}
        else:
            return {None}

    def get_compte_by_nom_pw(self, nom, pw):
        curseur = self.connexion.cursor()
        curseur.execute(
            """
            SELECT id, nom_compte, pw_compte FROM T_COMPTES
            WHERE nom_compte = %s AND pw_compte = %s
            """, (nom, pw))

        compte = curseur.fetchone()
        curseur.close()

        if compte:
            return {'id': compte[0], 'nom': compte[1], 'pw': compte[2]}
        else:
            return None

    def get_all_projets(self, nb_jour=7):
        # liste des projets pas finis ou finis depuis moins de nb_jour jours
        curseur = self.connexion.cursor()
        curseur.execute(
            """
            SELECT T_PROJETS.id, nom_projet, version_projet Version,
            SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) nb_ops_non_finies
            FROM T_PROJETS
            INNER JOIN T_PAQUETS ON T_PAQUETS.id_projet = T_PROJETS.id
            INNER JOIN T_ETAPES ON T_ETAPES.id_projet = T_PROJETS.id
            INNER JOIN T_OPERATIONS ON T_OPERATIONS.id_paquet = T_PAQUETS.id
                                    AND T_OPERATIONS.id_etape = T_ETAPES.id
            GROUP BY T_PROJETS.id, nom_projet, version_projet
            HAVING
            (SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) <> 0)
            OR
            (SUM(CASE WHEN statut_op <> 100 THEN 1 ELSE 0 END) = 0
            AND MAX(date_modif_op) > DATE_SUB(NOW(), INTERVAL %s DAY))
            """, (nb_jour,))

        rows = curseur.fetchall()
        curseur.close()

        projets = {}
        for id, nom, version, nb_ops_non_finies in rows:
            projets[id] = {'nom': nom, 'version': version, 'nb_ops_non_finies': nb_ops_non_finies}

        return projets

    def get_info_projet_by_id(self, projet_id):
        curseur = self.connexion.cursor()
        curseur.execute(
            """
            SELECT  id, nom_projet, version_projet, add_projet, cp_projet,
                    ville_projet
            FROM T_PROJETS
            WHERE   id = %s
            """, (projet_id,))

        row = curseur.fetchone()
        curseur.close()

        if row:
            return {
                'id': row[0],
                'nom': row[1],
                'version': row[2],
                'adresse': row[3],
                'cp': row[4],
                'ville': row[5]
            }
        else:
            return {None}

    def get_ops_by_id_projet(self, projet_id):
        curseur = self.connexion.cursor()
        curseur.execute(
            """
            SELECT nom_paquet, nom_etape, T_OPERATIONS.id,texte_op, statut_op, profil_op, compte_op
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
        for paquet, etape, id, texte, statut, profil_op, compte_op in rows:
            if paquet not in ops_projet:
                ops_projet[paquet] = {}
            ops_projet[paquet][etape] = {'id': id, 'texte': texte, 'statut': statut, 'profil': profil_op, 'compte': compte_op}
        return ops_projet

    def update_statut_operation(self, operation_id, nouveau_statut, nom_compte="qui?"):

        curseur = self.connexion.cursor()
        curseur.execute(
            """
            UPDATE T_OPERATIONS
            SET statut_op = %s, compte_op = %s
            WHERE id = %s;
            """, (nouveau_statut, nom_compte, operation_id,))

        nombre_lignes_modifiees = curseur.rowcount  # Nb lignes affectées par la mise à jour

        curseur.close()

        if nombre_lignes_modifiees == 1:
            self.connexion.commit()
            return True
        else:
            return False

    def connexion_close(self):
        print('Fermeture de la connexion à la base de données')
        self.connexion.close()
