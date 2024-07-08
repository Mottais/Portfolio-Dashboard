// Sélectionne l'élément <ul> à l'intérieur de l'élément avec l'ID 'nom_compte'
let nom_compte = document.querySelector('#nom_compte ul');

// Ajoute un écouteur d'événements 'click' à l'élément avec l'ID 'nom_compte'
document.getElementById('nom_compte').addEventListener('click', function() {
  // Vérifie l'état actuel de l'affichage de l'élément <ul>
  if (nom_compte.style.display === 'block') {
    // Si l'élément est actuellement affiché, le cacher
    nom_compte.style.display = 'none';
  } else {
    // Sinon, afficher l'élément
    nom_compte.style.display = 'block';
  }
});
