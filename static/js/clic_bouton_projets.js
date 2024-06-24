// Description: Gestion de l'affichage et la mise à jour du menu déroulant des projets

var dropdown = document.getElementById('dropdown');
var listeProjets = document.getElementById('listeProjets');

function mettreAJourListeProjets() {
  // Supprimer les éléments existants de la liste
  while (listeProjets.firstChild) {
    listeProjets.removeChild(listeProjets.firstChild);
  }

  // Récup les projets depuis le serveur
  fetch('/Tableau_de_bord_JARNOT/Liste_Projets/')
    .then(response => response.json())
    .then(data => {
      // Remplit la liste des projets avec les données récupérées
      data.forEach(function(prj) {
        var li = document.createElement('li');
        var a = document.createElement('a');
        a.href = "/Tableau_de_bord_JARNOT/Projets/" + prj.id;
        a.textContent = prj.nom + " (" + prj.nb_ops_non_finies + ")";
        li.appendChild(a);
        listeProjets.appendChild(li);
      });
    })
    .catch(error => console.error('Erreur lors de la récupération des projets:', error));
}

// Gestion de l'affichage et la mise à jour du menu déroulant à chaque clic sur le bouton "Projets"
dropdown.addEventListener('click', function() {
  if (listeProjets.style.display === 'none') {
    mettreAJourListeProjets();
    listeProjets.style.display = 'block';
  } else {
    listeProjets.style.display = 'none';
  }
});
