// Rafraîchit la page lorsqu'on clique sur le bouton "Projets" mettant à jour la liste des projets
let dropdown = document.querySelector('#dropdown ul');

document.getElementById('dropdown').addEventListener('click', function() {
  // location.reload();
  if (dropdown.style.display === 'block') {
    dropdown.style.display = 'none';
  } else {
    dropdown.style.display = 'block';
  }
});

let listItems = document.querySelectorAll('#dropdown ul li');
listItems.forEach(function(li) {
  li.addEventListener('click', function() {
    let dropdown = document.querySelector('#dropdown ul');
    dropdown.style.display = 'none';
  });
});
