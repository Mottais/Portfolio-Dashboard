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

            // Obtenez la valeur de cet élément à l'intérieur de cette fonction de clic
            const opValue = opSelect.textContent.trim();

            // Parcours de toutes les cellules pour désélectionner les autres
            cells.forEach(function(otherCell) {
                if (otherCell.id !== opValue) {
                    // Supprime l'attribut 'selected'
                    otherCell.removeAttribute('selected');
                }
            });

            // création d'un attribut 'selected' pour la cellule cliquée avec la valeur 'true'
            this.setAttribute('selected', 'true');

            let statut = this.getAttribute('data-statut');

            if (statut == 0) {
                document.getElementById('bouton_A_FAIRE').style.visibility = 'hidden';
                document.getElementById('bouton_EN_COURS').style.visibility = 'visible';
                document.getElementById('bouton_FAIT').style.visibility = 'visible';
            }

            if (statut > 0 && statut < 90) {
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
