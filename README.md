# Projet CLOUD Epitech

## Installation Windows
Installer Docker Desktop

## Variables d'Environnements
* Copier le .env.example et coller dans le dossier "Project", puis le renommer en .env
* Remplir les informations nécessaires dans le .env

## Lancer les conteneurs
* A partir du terminal, veillez bien à être dans le dossier "projet".
* Lancer les conteneurs:
```
docker-compose up --build -d
```

## Configuration (à faire qu'une seule fois)
* Lorsque les conteneurs sont tous bien lancés, il faut importer les tables dans la base de données:
```
docker exec -it fpm /bin/bash
```
* Félicitation, vous êtes dans le conteneur du server Laravel appelé fpm. Voici la prochaine commande pour importer les tables dans la base de données:
```
php artisan migrate
```

## Liens dispo après lancement des conteneurs
* [Frontend](http://localhost/)
* [Backend](http://localhost:8000/)
* [RabbitMQ](http://localhost:15672)
