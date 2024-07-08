// Fonction pour afficher la modale des réglages
function montrerReglages() {
    document.getElementById('modaleReglages').style.display = 'block';
}

// Fonction pour cacher la modale des réglages
function cacherReglages() {
    document.getElementById('modaleReglages').style.display = 'none';
}

// Fonction pour gérer l'affichage de l'étape
function AffichageEtape(button) {
    // Vérifie si le bouton contient la classe 'active'
    if (button.classList.contains('active')) {
        // Supprime la classe 'active' et masque l'élément 'Etape_select'
        button.classList.remove('active');
        document.getElementById('Etape_select').style.display = 'none';
        localStorage.setItem('etatBoutonEtape', 'inactif');  // Stocke l'état dans localStorage
    } else {
        // Ajoute la classe 'active' et affiche l'élément 'Etape_select'
        button.classList.add('active');
        document.getElementById('Etape_select').style.display = 'flex';
        localStorage.setItem('etatBoutonEtape', 'actif');  // Stocke l'état dans localStorage
    }
}

// Fonction pour gérer l'affichage du paquet
function AffichagePaquet(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Paquet_select').style.display = 'none';
        localStorage.setItem('etatBoutonPaquet', 'inactif');  // Stocke l'état dans localStorage
    } else {
        button.classList.add('active');
        document.getElementById('Paquet_select').style.display = 'flex';
        localStorage.setItem('etatBoutonPaquet', 'actif');  // Stocke l'état dans localStorage
    } 
}

// Fonction pour gérer l'affichage du profil
function AffichageProfil(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Profil_select').style.display = 'none';
        localStorage.setItem('etatBoutonProfil', 'inactif');  // Stocke l'état dans localStorage
    } else {
        button.classList.add('active');
        document.getElementById('Profil_select').style.display = 'flex';
        localStorage.setItem('etatBoutonProfil', 'actif');  // Stocke l'état dans localStorage
    } 
}

// Fonction pour gérer l'affichage du compte
function AffichageCompte(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Compte_select').style.display = 'none';
        localStorage.setItem('etatBoutonCompte', 'inactif');  // Stocke l'état dans localStorage
    } else {
        button.classList.add('active');
        document.getElementById('Compte_select').style.display = 'flex';
        localStorage.setItem('etatBoutonCompte', 'actif');  // Stocke l'état dans localStorage
    } 
}

// Fonction pour gérer l'affichage du statut
function AffichageStatut(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Statut_select').style.display = 'none';
        localStorage.setItem('etatBoutonStatut', 'inactif');  // Stocke l'état dans localStorage
    } else {
        button.classList.add('active');
        document.getElementById('Statut_select').style.display = 'flex';
        localStorage.setItem('etatBoutonStatut', 'actif');  // Stocke l'état dans localStorage
    } 
}

// Restaurer l'état des boutons d'affichage au chargement de la page en fonction des valeurs stockées dans le localStorage
// Vérifie si chaque bouton a été enregistré comme "actif" dans le localStorage et simule un clic pour restaurer l'état
if (localStorage.getItem('etatBoutonPaquet') === 'actif') { document.getElementById('bouton_AffichagePaquet').click(); }
if (localStorage.getItem('etatBoutonEtape') === 'actif') { document.getElementById('bouton_AffichageEtape').click(); }
if (localStorage.getItem('etatBoutonProfil') === 'actif') { document.getElementById('bouton_AffichageProfil').click(); }
if (localStorage.getItem('etatBoutonCompte') === 'actif') { document.getElementById('bouton_AffichageCompte').click(); }
if (localStorage.getItem('etatBoutonStatut') === 'actif') { document.getElementById('bouton_AffichageStatut').click(); }

