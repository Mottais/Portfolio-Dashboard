// Initialisation de la visibilité des boutons de l'interface
document.getElementById('bouton_A_FAIRE').style.visibility = 'hidden';
document.getElementById('bouton_EN_COURS').style.visibility = 'hidden';
document.getElementById('bouton_FAIT').style.visibility = 'hidden';

// Initialisation de la boîte de dialogue
// Récupère le texte de l'élément 'Texte_select'
let Texte_select = document.getElementById('Texte_select').textContent;

// Vérifie si le texte indique qu'aucun projet n'est sélectionné
if (Texte_select.trim() == "Sélectionnez un projet dans le menu déroulant.") {
    // Si aucun projet n'est sélectionné, cache les éléments de la boîte de dialogue
    document.getElementById('Etape_select').style.display = "none";
    document.getElementById('Paquet_select').style.display = "none";
    document.getElementById('Statut_select').style.display = "none";
}
