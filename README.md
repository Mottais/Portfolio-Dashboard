# Portfolio-Dashboard

### TABLE OF CONTENTS
- [INTRODUCTION](#introduction)
- [DESCRIPTION](#description)
- [PREREQUISITES](#prerequisites)
- [INSTALLATION](#installation)
- [LAUNCH](#launch)
- [TESTS](#tests)
- [USAGE](#usage)
- [CONTRIBUTION](#contribution)
- [RELATED PROJECTS](#related-projects)
- [LICENSES](#licenses)
- [AUTHOR](#author)

### INTRODUCTION

Welcome to the Portfolio-Dashboard project repository. This project is a tool for visualizing and updating project progress for construction companies using SEMA software.

- __Links to demo videos of the deployed site__: [French video](https://youtu.be/vmoC8oMKvtE)/[English video](https://www.youtube.com/watch?v=F3pVUmrCwf4)
- __Blog article of the final project__: [blog](https://real-time-dashboards.blogspot.com/2024/07/blog-post.html)
- __Author's LinkedIn profile__: [Yannick Mottais](https://github.com/Mottais)

### DESCRIPTION

A tool for visualizing and updating project progress for construction companies using SEMA software:
- for and by all employees,
- anywhere (offices, workshops, construction sites...),
- __and in real-time__

Click [here](https://mottais.github.io/Landing_Pages/LandingPageFR.html) for more details.


### PREREQUISITES
A SEMA license

An Excel license


### INSTALLATION

#### Clone the repository:

    git clone https://github.com/Mottais/Portfolio-Dashboard.git

#### On the company server
Copy the "Modèle_Tableau_de_Bord.xlsm" file into a folder on the company server.

This file must be accessible by the personnel using SEMA and the supervisor.

#### In SEMA
##### In the general settings of SEMA [Alt + F7]: 
- specify where the Excel template file is located.
- and where you want to export the Excel files with the template.

![flowchart](https://github.com/Mottais/Images/blob/104796b92013e227484f5c27a16782dc049e1805/Portfolio-Dashboard/AF7.jpg)

<br>

##### In the SEMA lists:
Create a new tab with the file __'Liste_Tableau_de_Bord.DOT'__

<br><br><br>

#### On the Application Server (Ubuntu-20.04)

__Install Python Version: 3.8.10__

    sudo apt update
    sudo apt upgrade
    sudo apt install python3.8


__Install Flask Version: 3.0.3__

    pip install Flask==3.0.3


__Install FlaskSocketIO Version: 5.3.6__

    pip install flask-socketio==5.3.6


__Install Flask-Login Version: 0.6.3__

    pip install Flask-Login==0.6.3


__Install MySQLdb Version: 2.2.4__

    pip install mysqlclient==2.2.4


__Install MySQL Server Version: 8.0.37-0ubuntu0.20.04.3__ for Linux on x86_64 ((Ubuntu))

    sudo apt install mysql-server

__Create the Database:__

    cat TABLEAU_DE_BORD_JARNOT_DEV_1_Création_Base_De_Donnees.sql | sudo mysql -u root -p

__Create a user:__

    cat TABLEAU_DE_BORD_JARNOT_DEV_2_Création_Utilisateur_DEV.sql | sudo mysql -u root -p




### LAUNCH

__Run the app.py program at the root of the project:__

		python3 app.py

### TESTS

__Run the tests at the root of the project:__

    python3 -m unittest discover -s tests



### USAGE

Watch this video:
[![Demo_Video](https://github.com/Mottais/Images/blob/38d31e307ec85b56a0031eda92b31dc66bde537d/Portfolio-Dashboard/Acceuil_Demo_FR.jpg)](https://www.youtube.com/watch?v=vmoC8oMKvtE)


### CONTRIBUTION

Contributions are welcome! Please submit a pull request for new features or bug fixes. Make sure your changes pass all tests before submitting.

### RELATED PROJECTS

- [SEMA](https://www.sema-soft.com/)
- [Excel](https://www.microsoft.com/en-us/microsoft-365/excel)
- [Test FLask SocketIO](https://github.com/Mottais/TESTS_FLask_SocketIO)
- [Test flask login](https://github.com/Mottais/LOGIN)

### LICENSES

This project is licensed under Holberton School. As Holberton School students, please adhere to any other licensing or academic integrity policies established by your institution.

### AUTHOR

Yannick Mottais
- [LinkedIn](https://www.linkedin.com/in/yannickmottais/)
