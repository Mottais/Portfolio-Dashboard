// Initialisation des boutons de l'interface
document.getElementById('bouton_A_FAIRE').style.visibility = 'hidden';
document.getElementById('bouton_EN_COURS').style.visibility = 'hidden';
document.getElementById('bouton_FAIT').style.visibility = 'hidden';

// Initialisation de la boîte de dialogue
let Texte_select = document.getElementById('Texte_select').textContent;
if (Texte_select.trim() == "Sélectionnez un projet dans le menu déroulant.") {
  document.getElementById('Etape_select').style.display = "none";
  document.getElementById('Paquet_select').style.display = "none";
  document.getElementById('Statut_select').style.display = "none";
}

