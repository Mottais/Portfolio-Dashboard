// Initialisation du socket.io
let socket = io();

// Écouteur d'événement pour recevoir les mises à jour de statut depuis le serveur
socket.on('update_status', function(data) {
    // Récupération des données de l'événement
    let operationId = data.id;
    let nouveauStatut = data.nouveau_statut;
    let compte = data.compte;

    // Sélection de la cellule correspondante dans le tableau
    let cell = document.getElementById(operationId);
    if (cell) {
        // Mise à jour des attributs dataset de la cellule
        cell.dataset.statut = nouveauStatut;
        cell.dataset.compte = compte;

        // Vérification si une cellule est actuellement sélectionnée
        let elementSelected = document.querySelector('[selected="true"]');
        if (elementSelected && elementSelected.id === operationId) {
            // Si la cellule sélectionnée correspond à celle mise à jour, mettre à jour la boîte de dialogue
            miseAJourBoiteDeDialogue(elementSelected);
        }
    }
});
