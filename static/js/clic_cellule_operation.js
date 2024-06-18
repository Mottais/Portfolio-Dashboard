// Décmaration des variables globales

// Valeur de progression pour le bouton "EN COURS"
let ValeurDeProgression = 10;

// Cellules du tableau avec un attribut 'data-statut' différent de 'None' c'est-à-dire les cellules qui ont une opération
const cells = document.querySelectorAll('td[data-statut]:not([data-statut="None"])');

// Eléments de la boîte de dialogue
const opSelect = document.getElementById('op_select');
const paquetSelect = document.getElementById('Paquet_select');
const etapeSelect = document.getElementById('Etape_select');
const textSelect = document.getElementById('Texte_select');
const statutSelect = document.getElementById('Statut_select');
const profilSelect = document.getElementById('Profil_select');
const compteSelect = document.getElementById('Compte_select');

// Fonction de gestionnaire d'événements
function miseAJourBoiteDeDialogue(cell) {
    // Vérification si l'ID de la cellule est différent de 'None'
    if (cell.id !== 'None') {
        // Mise à jour des valeurs de la boîte de dialogue avec les données de la cellule
        opSelect.textContent = cell.getAttribute('id');
        paquetSelect.textContent = cell.getAttribute('data-paquet');
        etapeSelect.textContent = cell.getAttribute('data-etape');
        textSelect.textContent = cell.textContent;
        statutSelect.textContent = cell.getAttribute('data-statut') + "%";
        statutSelect.setAttribute('title', 'Mis à jour par :'+ cell.getAttribute('data-compte'));
        profilSelect.textContent = cell.getAttribute('data-profil');
        compteSelect.textContent = cell.getAttribute('data-compte');

        // Supprime l'attribut 'selected' de l'élément actuellement sélectionné (s'il existe)
        if (document.querySelector('[selected="true"]')) {document.querySelector('[selected="true"]').removeAttribute('selected');}

        // création d'un attribut 'selected' pour la cellule cliquée avec la valeur 'true'
        cell.setAttribute('selected', 'true');

        let statut = cell.getAttribute('data-statut');

        if (statut == 0) {
            document.getElementById('bouton_A_FAIRE').style.visibility = 'hidden';
            document.getElementById('bouton_EN_COURS').style.visibility = 'visible';
            document.getElementById('bouton_FAIT').style.visibility = 'visible';
        }

        if (statut > 0 && statut < (100 - ValeurDeProgression)) {
            document.getElementById('bouton_A_FAIRE').style.visibility = 'visible';
            document.getElementById('bouton_EN_COURS').style.visibility = 'visible';
            document.getElementById('bouton_FAIT').style.visibility = 'visible';
        }

        if (statut >= (100 - ValeurDeProgression) && statut < 100) {
            document.getElementById('bouton_A_FAIRE').style.visibility = 'visible';
            document.getElementById('bouton_EN_COURS').style.visibility = 'hidden';
            document.getElementById('bouton_FAIT').style.visibility = 'visible';
        }

        if (statut == 100) {
            document.getElementById('bouton_A_FAIRE').style.visibility = 'visible';
            document.getElementById('bouton_EN_COURS').style.visibility = 'hidden';
            document.getElementById('bouton_FAIT').style.visibility = 'hidden';
        }
    }
}

// Ajout d'un gestionnaire d'événement pour chaque cellule
cells.forEach(function(cell) {
    cell.addEventListener('click', function() {
        miseAJourBoiteDeDialogue(cell);
    });
});
