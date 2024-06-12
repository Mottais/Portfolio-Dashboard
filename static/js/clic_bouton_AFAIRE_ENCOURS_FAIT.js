// Définition de la fonction à exécuter au clic sur le bouton "A FAIRE", "EN COURS" ou "FAIT"
function boutonsAFAIRE_ENCOURS_FAIT_Click(progression) {

    // id de l'opération sélectionné dans le tableau
    const idToChange = opSelect.textContent;

    // Sélection de la cellule opération sélectionnée
    const cellToChange = document.getElementById(idToChange);

    // Si cellule sélectionnée trouvée
    if (cellToChange) {
        // calcul du nouveau statut : ancien statut + progression (min 0, max 100)
        const nouveau_statut = Math.min(parseInt(Math.max(parseInt(cellToChange.dataset.statut) + progression, 0)), 100);
        // ajout info dans console
        console.log(`Demande attribution statut à ${nouveau_statut}% pour l'opération id:${idToChange}`);

        // Envoi de la requête PUT au serveur pour mettre à jour le statut de l'opération
        fetch('/Tableau_de_bord_JARNOT/update_statut/', {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: idToChange, nouveau_statut: nouveau_statut })
        })
        .then(response => response.json())
        .then(return_update_statut_from_app => {
            if (return_update_statut_from_app.success) {
                console.log(return_update_statut_from_app.message);
                // Mise à jour de l'attribut data-statut de la cellule avec le nouveau statut
                cellToChange.dataset.statut = nouveau_statut;
                // mise à jour de l'affichage du statut dans la bôite de dialogue
                statutSelect.textContent = cellToChange.dataset.statut + '%';
            } else {
                console.error(return_update_statut_from_app.message);
            }
        })
        .catch(error => console.error('Erreur lors de la mise à jour du statut:', error));
    // Si cellule sélectionnée n'est pas trouvée
    } else {
        // Vérification si l'ID est un nombre
        if (isNaN(idToChange)) {
            // NaN = Not a Number --> Affichage d'un message si l'ID n'est pas un nombre
            alert(`Sélectionnez une cellule`);
        } else {
            // Affichage d'un message si aucune cellule n'a été trouvée avec cet ID
            console.log(`Aucune cellule trouvée avec l'ID ${idToChange}`);
            alert(`Aucune cellule trouvée avec l'ID ${idToChange}`);
        }
    }
}

// Sélection de l'élément bouton "A FAIRE"
const boutonA_Faire = document.getElementById('bouton_A_FAIRE');

// Ajout d'un gestionnaire d'événement click au bouton "A FAIRE"
boutonA_Faire.addEventListener('click', function() {
    // Définition de la progression
    const progression = -100;
    // Appel de la fonction avec la progression en tant qu'argument
    boutonsAFAIRE_ENCOURS_FAIT_Click(progression);
});

// Sélection de l'élément bouton "FAIT"
const boutonFAIT = document.getElementById('bouton_FAIT');

// Ajout d'un gestionnaire d'événement click au bouton "FAIT"
boutonFAIT.addEventListener('click', function() {
    // Définition de la progression
    const progression = 100;
    // Appel de la fonction avec la progression en tant qu'argument
    boutonsAFAIRE_ENCOURS_FAIT_Click(progression);
});

// Sélection de l'élément bouton "EN COURS"
const boutonEN_COURS = document.getElementById('bouton_EN_COURS');

// Ajout d'un gestionnaire d'événement click au bouton "EN COURS"
boutonEN_COURS.addEventListener('click', function() {
    // Définition de la progression
    const progression = 10;
    // Appel de la fonction avec la progression en tant qu'argument
    boutonsAFAIRE_ENCOURS_FAIT_Click(progression);
});


