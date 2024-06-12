// Décmaration des variables globales

// Valeur de progression pour le bouton "EN COURS"
ValeurDeProgression = 10;

// Cellules du tableau avec un attribut 'data-statut' différent de 'None' c'est-à-dire les cellules qui ont une opération
const cells = document.querySelectorAll('td[data-statut]:not([data-statut="None"])');

// Eléments de la boîte de dialogue
const opSelect = document.getElementById('op_select');
const paquetSelect = document.getElementById('Paquet_select');
const etapeSelect = document.getElementById('Etape_select');
const textSelect = document.getElementById('Texte_select');
const statutSelect = document.getElementById('Statut_select');

// Ajout d'un gestionnaire d'événement pour chaque cellule
cells.forEach(function(cell) {
    cell.addEventListener('click', function() {
        // Vérification si l'ID de la cellule est différent de 'None'
        if (this.id !== 'None') {
            // Mise à jour des valeurs de la boîte de dialogue avec les données de la cellule
            opSelect.textContent = this.getAttribute('id');
            paquetSelect.textContent = this.getAttribute('data-paquet');
            etapeSelect.textContent = this.getAttribute('data-etape');
            textSelect.textContent = this.textContent;
            statutSelect.textContent = this.getAttribute('data-statut') + "%";

            // Supprime l'attribut 'selected' de l'élément actuellement sélectionné (s'il existe)
            if (document.querySelector('[selected="true"]')) {document.querySelector('[selected="true"]').removeAttribute('selected');}

            // création d'un attribut 'selected' pour la cellule cliquée avec la valeur 'true'
            this.setAttribute('selected', 'true');

            let statut = this.getAttribute('data-statut');

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

            if (statut >= 90 && statut < 100) {
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
    });
});
