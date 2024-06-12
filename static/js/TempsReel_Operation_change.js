    var socket = io();

    // Test la connexion au serveur WebSocket
    // socket.on('connect', function() {
    //   alert('La connexion au serveur WebSocket établie avec succès');
    // });

    socket.on('update_status', function(data) {
        // alert(`événement 'update_status' reçu avec id: ${data.id} et statut: ${data.nouveau_statut}`);
        var operationId = data.id;
        var nouveauStatut = data.nouveau_statut;

        var cell = document.getElementById(operationId);
        if (cell) {
          // alert(`Cellule trouvée pour id: ${operationId} et mis àjour dans cette page`);
          cell.dataset.statut = nouveauStatut;
          // cell.innerText = nouveauStatut;
        } // else {
        //   alert(`Cellule non trouvée pour id: ${operationId}`);
        // }
      });
