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
    } else {
        button.classList.add('active');
        document.getElementById('Etape_select').style.display = 'flex';
    }
}

function AffichagePaquet(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Paquet_select').style.display = 'none';
    } else {
        button.classList.add('active');
        document.getElementById('Paquet_select').style.display = 'flex';
    } 
}

function AffichageProfil(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Profil_select').style.display = 'none';
    } else {
        button.classList.add('active');
        document.getElementById('Profil_select').style.display = 'flex';
    } 
}

function AffichageCompte(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Compte_select').style.display = 'none';
    } else {
        button.classList.add('active');
        document.getElementById('Compte_select').style.display = 'flex';
    } 
}

function AffichageStatut(button) {
    if (button.classList.contains('active')) {
        button.classList.remove('active');
        document.getElementById('Statut_select').style.display = 'none';
    } else {
        button.classList.add('active');
        document.getElementById('Statut_select').style.display = 'flex';
    } 
}


const btnEtape = document.getElementById('bouton_AffichageEtape');


// Affichage par féfaut dans la boite de dialogue
document.getElementById('bouton_AffichageEtape').click();
document.getElementById('bouton_AffichagePaquet').click();

