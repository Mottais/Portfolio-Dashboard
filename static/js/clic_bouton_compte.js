let nom_compte = document.querySelector('#nom_compte ul');

document.getElementById('nom_compte').addEventListener('click', function() {
  // location.reload();
  if (nom_compte.style.display === 'block') {
    nom_compte.style.display = 'none';
  } else {
    nom_compte.style.display = 'block';
  }
});
