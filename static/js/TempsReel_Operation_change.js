    let socket = io();

    // Test la connexion au serveur WebSocket
    // socket.on('connect', function() {
    //   alert('La connexion au serveur WebSocket établie avec succès');
    // });

    socket.on('update_status', function(data) {
        // alert(`événement 'update_status' reçu avec id: ${data.id} et statut: ${data.nouveau_statut}`);
        let operationId = data.id;
        let nouveauStatut = data.nouveau_statut;
        let compte = data.compte;

        let cell = document.getElementById(operationId);
        if (cell) {
          // alert(`Cellule trouvée pour id: ${operationId} et mis àjour dans cette page`);
          cell.dataset.statut = nouveauStatut;
          cell.dataset.compte = compte;
          // cell.innerText = nouveauStatut;
          let elementSelected = document.querySelector('[selected="true"]');
          if (elementSelected.id == operationId) { miseAJourBoiteDeDialogue(elementSelected)}
        } // else {
        //   alert(`Cellule non trouvée pour id: ${operationId}`);
        // }
      });
