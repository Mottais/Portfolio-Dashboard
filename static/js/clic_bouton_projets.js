// Description: Gestion de l'affichage et la mise à jour du menu déroulant des projets

// Sélectionne l'élément avec l'ID 'dropdown' pour gérer les clics sur le menu déroulant
var dropdown = document.getElementById('dropdown');

// Sélectionne l'élément contenant la liste des projets
var listeProjets = document.getElementById('listeProjets');

// Fonction pour mettre à jour la liste des projets
function mettreAJourListeProjets() {
  // Supprime les éléments existants de la liste
  while (listeProjets.firstChild) {
    listeProjets.removeChild(listeProjets.firstChild);
  }

  // Récupère les projets depuis le serveur
  fetch('/Tableau_de_bord_JARNOT/Liste_Projets/')
    .then(response => response.json()) // Convertit la réponse en format JSON
    .then(data => {
      // Remplit la liste des projets avec les données récupérées
      data.forEach(function(prj) {
        var li = document.createElement('li'); // Crée un nouvel élément de liste
        var a = document.createElement('a'); // Crée un nouvel élément de lien
        a.href = "/Tableau_de_bord_JARNOT/Projets/" + prj.id; // Définit l'URL du lien
        a.textContent = prj.nom + " (" + prj.nb_ops_non_finies + ")"; // Définit le texte du lien
        li.appendChild(a); // Ajoute le lien à l'élément de liste
        listeProjets.appendChild(li); // Ajoute l'élément de liste à la liste des projets
      });
    })
    .catch(error => console.error('Erreur lors de la récupération des projets:', error)); // Gestion des erreurs
}

// Gestion de l'affichage et la mise à jour du menu déroulant à chaque clic sur le bouton "Projets"
dropdown.addEventListener('click', function() {
  // Vérifie l'état actuel de l'affichage de la liste des projets
  if (listeProjets.style.display === 'none') {
    // Si la liste est cachée, la mettre à jour et l'afficher
    mettreAJourListeProjets();
    listeProjets.style.display = 'block';
  } else {
    // Sinon, cacher la liste
    listeProjets.style.display = 'none';
  }
});
