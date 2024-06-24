function montrerReglages() {
    document.getElementById('modaleReglages').style.display = 'block';
}

function cacherReglages() {
    document.getElementById('modaleReglages').style.display = 'none';
}

function AffichageEtape(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Etape_select').style.display = 'none';
        localStorage.setItem('etatBoutonEtape', 'inactif');
    } else {
        button.classList.add('active');
        document.getElementById('Etape_select').style.display = 'flex';
        localStorage.setItem('etatBoutonEtape', 'actif');
    }
}

function AffichagePaquet(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Paquet_select').style.display = 'none';
        localStorage.setItem('etatBoutonPaquet', 'inactif');
    } else {
        button.classList.add('active');
        document.getElementById('Paquet_select').style.display = 'flex';
        localStorage.setItem('etatBoutonPaquet', 'actif');
    } 
}

function AffichageProfil(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Profil_select').style.display = 'none';
        localStorage.setItem('etatBoutonProfil', 'inactif');
    } else {
        button.classList.add('active');
        document.getElementById('Profil_select').style.display = 'flex';
        localStorage.setItem('etatBoutonProfil', 'actif');
    } 
}

function AffichageCompte(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Compte_select').style.display = 'none';
        localStorage.setItem('etatBoutonCompte', 'inactif');
    } else {
        button.classList.add('active');
        document.getElementById('Compte_select').style.display = 'flex';
        localStorage.setItem('etatBoutonCompte', 'actif');
    } 
}

function AffichageStatut(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Statut_select').style.display = 'none';
        localStorage.setItem('etatBoutonStatut', 'inactif');
    } else {
        button.classList.add('active');
        document.getElementById('Statut_select').style.display = 'flex';
        localStorage.setItem('etatBoutonStatut', 'actif');
    } 
}


// Restaurer l'état des boutons d'affichage au chargement de la page en fonction des valeurs stockées dans le localStorage   
if (localStorage.getItem('etatBoutonPaquet') === 'actif') { document.getElementById('bouton_AffichagePaquet').click(); }
if (localStorage.getItem('etatBoutonEtape') === 'actif') { document.getElementById('bouton_AffichageEtape').click(); }
if (localStorage.getItem('etatBoutonProfil') === 'actif') { document.getElementById('bouton_AffichageProfil').click(); }
if (localStorage.getItem('etatBoutonCompte') === 'actif') { document.getElementById('bouton_AffichageCompte').click(); }
if (localStorage.getItem('etatBoutonStatut') === 'actif') { document.getElementById('bouton_AffichageStatut').click(); }

