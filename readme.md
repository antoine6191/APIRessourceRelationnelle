# Configuration de l'API

## Variables d'environnement

Le fichier .env doit se trouver à la racine du projet. Il doit contenir les variables suivantes :
* DB_HOST : adresse IP ou nom DNS du serveur de base de données
* DB_USER : nom de l'utilisateur qui se connecte à la base de données
* DB_PASSWORD : mot de passe de l'utilisateur de connexion à la base
* DB_NAME : nom de la base de données
* DB_CONTEXT : nom du moteur de base de données à utiliser pour Sequelize (postgres|mssql|mariadb|mysql)
* SERVICE_PORT : port en écoute de l'API

Les variables d'environnement doivent être écrites en majuscule avec des underscores '_'. Le symbole '=' doit coller le nom et la valeur. Les valeurs ne sont pas comprises entre cottes, quelque soit leur type. Chaque variable doit être sur une ligne.


# Commandes de lancement

```npm install```
Installe les dépendances

```npm start```
Lance le projet

# Schéma de données

CITOYEN
////////////////////GET////////////////////
localhost:3000/user/:userId
response {
    "id": 2,
    "nom": "teillay",
    "prenom": "louis",
    "mail": "louis.tellay@gmail.com",
    "telephone": "0611695852",
    "motdepasse": "test1234",
    "cp": "72000",
    "rue": "avenue rhin et danube",
    "numero": "121",
    "ville": "le mans",
    "role_id": 2,
    "createdAt": "2022-02-17T14:18:18.000Z",
    "updatedAt": "2022-02-17T14:18:18.000Z"
}

localhost:3000/ressource_types
response [
    {
        "id": 1,
        "label": "activité/jeu à réaliser",
        "createdAt": "2022-02-17T14:18:18.000Z",
        "updatedAt": "2022-02-17T14:18:18.000Z"
    },
    {
        "id": 2,
        "label": "article",
        "createdAt": "2022-02-17T14:18:18.000Z",
        "updatedAt": "2022-02-17T14:18:18.000Z"
    }
]

localhost:3000/ressource_types/:ressource_typeId
désactivé

localhost:3000/relation_types
response [
    {
        "id": 1,
        "label": "soi",
        "createdAt": "2022-02-17T14:18:18.000Z",
        "updatedAt": "2022-02-17T14:18:18.000Z"
    },
    {
        "id": 2,
        "label": "conjoints",
        "createdAt": "2022-02-17T14:18:18.000Z",
        "updatedAt": "2022-02-17T14:18:18.000Z"
    }
]

localhost:3000/relation_types/:relation_typeId
désactivé 

localhost:3000/ressources
response [
    {
        "id": 1,
        "titre": "reconnaitre ses émotions",
        "description": "L’objectif de cet exercice est de reconnaître les émotions sur soi. Pour ce faire, nous noterons dans un petit cahier prévu à cet effet, à des moments prédéfinis de la journée, comment nous nous sentons émotionnellement. Quelle émotion nous habite ? Cette émotion est-elle positive ou négative ? Avec quelle force ? Quel a été le facteur déclencheur ? Nous répèterons la démarche durant une semaine. Après une semaine, reprenons nos notes et identifions avec un marqueur les émotions que nous ressentons le plus souvent, si elles sont positives ou négatives et quel type de facteur déclencheur est observé le plus souvent. Pour conclure, demandons-nous si nos émotions auraient pu être différentes et si la situation en aurait été changée.",
        "createdAt": "2022-02-17T14:18:19.000Z",
        "updatedAt": "2022-02-17T14:18:19.000Z",
        "categorie_id": 13,
        "relation_types_id": 1,
        "ressource_types_id": 5
    },
    {
        "id": 2,
        "titre": "Emission ARTE : Travail | Travail, Salaire, Profit",
        "description": "https://www.youtube.com/watch?v=Dpzv8H16R-Q",
        "createdAt": "2022-02-17T14:18:19.000Z",
        "updatedAt": "2022-02-17T14:18:19.000Z",
        "categorie_id": 5,
        "relation_types_id": 4,
        "ressource_types_id": 8
    }
]

localhost:3000/ressources/:ressourceId', ressourceController.getRessource)
response {
    "id": 2,
    "titre": "Emission ARTE : Travail | Travail, Salaire, Profit",
    "description": "https://www.youtube.com/watch?v=Dpzv8H16R-Q",
    "createdAt": "2022-02-17T14:18:19.000Z",
    "updatedAt": "2022-02-17T14:18:19.000Z",
    "categorie_id": 5,
    "relation_types_id": 4,
    "ressource_types_id": 8
}


localhost:3000/commits/:ressourceId
response [
    {
        "id": 1,
        "post": "2022-02-17T10:54:51.000Z",
        "texte": "test",
        "createdAt": "2022-02-17T14:18:19.000Z",
        "updatedAt": "2022-02-17T14:18:19.000Z",
        "user_id": 1,
        "ressource_id": 3
    },
    {
        "id": 2,
        "post": "2022-02-17T10:54:51.000Z",
        "texte": "test2",
        "createdAt": "2022-02-17T14:18:19.000Z",
        "updatedAt": "2022-02-17T14:18:19.000Z",
        "user_id": 3,
        "ressource_id": 3
    }
]


localhost:3000/favoris/:user_id
response [
    {
        "id": 3,
        "favoris": false,
        "createdAt": "2022-02-17T14:18:19.000Z",
        "updatedAt": "2022-02-17T14:18:19.000Z",
        "user_id": 3,
        "ressource_id": 2
    },
    {
        "id": 4,
        "favoris": false,
        "createdAt": "2022-02-17T14:18:19.000Z",
        "updatedAt": "2022-02-17T14:18:19.000Z",
        "user_id": 3,
        "ressource_id": 3
    }
]
////////////////////fin GET////////////////////

////////////////////POST////////////////////

localhost:3000/add-favoris
body {
        "favoris": true,
        "user_id": 3,
        "ressource_id": 2
}
reponse {
    "id": 8,
    "favoris": true,
    "user_id": 3,
    "ressource_id": 2,
    "updatedAt": "2022-02-17T14:13:30.846Z",
    "createdAt": "2022-02-17T14:13:30.846Z"
}

localhost:3000/delete-favoris
body {
        "favorisId": 8
}

localhost:3000/add-user
body {
    "nom": "test",
    "prenom": "test",
    "mail": "louis.tellay@gmail.com",
    "telephone": "0611695852",
    "motdepasse": "test1234",
    "cp": "72000",
    "rue": "avenue rhin et danube",
    "numero": "121",
    "ville": "le mans",
    "role_id": 2
}
response {
    "id": 5,
    "nom": "test",
    "prenom": "test",
    "mail": "louis.tellay@gmail.com",
    "telephone": "0611695852",
    "motdepasse": "test1234",
    "cp": "72000",
    "rue": "avenue rhin et danube",
    "numero": "121",
    "ville": "le mans",
    "role_id": 2,
    "updatedAt": "2022-02-17T14:15:48.233Z",
    "createdAt": "2022-02-17T14:15:48.233Z"
}

localhost:3000/add-commit
body {
        "texte": "test",
        "user_id": 1,
        "ressource_id": 3
}
response {
    "id": 5,
    "texte": "test",
    "user_id": 1,
    "ressource_id": 3,
    "updatedAt": "2022-02-17T14:17:26.363Z",
    "createdAt": "2022-02-17T14:17:26.363Z"
}

localhost:3000/add-ressource
body {
        "titre": "reconnaitre ses émotions",
        "description": "L’objectif de cet exercice est de reconnaître les émotions sur soi. Pour ce faire, nous noterons dans un petit cahier prévu à cet effet, à des moments prédéfinis de la journée, comment nous nous sentons émotionnellement. Quelle émotion nous habite ? Cette émotion est-elle positive ou négative ? Avec quelle force ? Quel a été le facteur déclencheur ? Nous répèterons la démarche durant une semaine. Après une semaine, reprenons nos notes et identifions avec un marqueur les émotions que nous ressentons le plus souvent, si elles sont positives ou négatives et quel type de facteur déclencheur est observé le plus souvent. Pour conclure, demandons-nous si nos émotions auraient pu être différentes et si la situation en aurait été changée.",
        "categorie_id": 13,
        "relation_types_id": 1,
        "ressource_types_id": 5
} 
response
{
    "id": 6,
    "titre": "reconnaitre ses émotions",
    "description": "L’objectif de cet exercice est de reconnaître les émotions sur soi. Pour ce faire, nous noterons dans un petit cahier prévu à cet effet, à des moments prédéfinis de la journée, comment nous nous sentons émotionnellement. Quelle émotion nous habite ? Cette émotion est-elle positive ou négative ? Avec quelle force ? Quel a été le facteur déclencheur ? Nous répèterons la démarche durant une semaine. Après une semaine, reprenons nos notes et identifions avec un marqueur les émotions que nous ressentons le plus souvent, si elles sont positives ou négatives et quel type de facteur déclencheur est observé le plus souvent. Pour conclure, demandons-nous si nos émotions auraient pu être différentes et si la situation en aurait été changée.",
    "updatedAt": "2022-02-17T14:18:42.913Z",
    "createdAt": "2022-02-17T14:18:42.913Z"
}

////////////////////fin POST////////////////////

ADMIN
////////////////////GET////////////////////
localhost:3000/admin/users
response [
    {
        "id": 1,
        "nom": "hervieu",
        "prenom": "antoine",
        "mail": "antoine.hervieu@gmail.com",
        "telephone": "0611695851",
        "motdepasse": "test1234",
        "cp": "72290",
        "rue": "lieu dit le jardin",
        "numero": "na",
        "ville": "mezieres sur ponthouin",
        "role_id": 3,
        "createdAt": "2022-02-17T14:18:18.000Z",
        "updatedAt": "2022-02-17T14:18:18.000Z"
    },
    {
        "id": 2,
        "nom": "teillay",
        "prenom": "louis",
        "mail": "louis.tellay@gmail.com",
        "telephone": "0611695852",
        "motdepasse": "test1234",
        "cp": "72000",
        "rue": "avenue rhin et danube",
        "numero": "121",
        "ville": "le mans",
        "role_id": 2,
        "createdAt": "2022-02-17T14:18:18.000Z",
        "updatedAt": "2022-02-17T14:18:18.000Z"
    }
]

localhost:3000/admin/roles
response [
    {
        "id": 1,
        "libelle": "citoyen",
        "createdAt": "2022-02-17T15:53:31.000Z",
        "updatedAt": "2022-02-17T15:53:31.000Z"
    },
    {
        "id": 2,
        "libelle": "admin",
        "createdAt": "2022-02-17T15:53:31.000Z",
        "updatedAt": "2022-02-17T15:53:31.000Z"
    }
]

////////////////////fin GET////////////////////
////////////////////POST////////////////////

localhost:3000/admin/delete-user'
body {
        "userId": 4
}

localhost:3000/admin/delete-ressource
body {
        "ressourceId": 4
}

localhost:3000/admin/add-categorie'
body {
    "label": 
}
response {
    "id": 14,
    "label": "test",
    "updatedAt": "2022-02-17T14:56:44.811Z",
    "createdAt": "2022-02-17T14:56:44.811Z"
}

localhost:3000/admin/delete-categorie
body {
        "categorieId": 14
}

localhost:3000/admin/add-relation_type
body { 
        "label": "test"
}
response {
    "id": 7,
    "label": "test",
    "updatedAt": "2022-02-17T15:11:49.847Z",
    "createdAt": "2022-02-17T15:11:49.847Z"
}

localhost:3000/admin/add-ressource_type
body { 
        "label": "test"
} response {
    "id": 9,
    "label": "test",
    "updatedAt": "2022-02-17T15:12:39.101Z",
    "createdAt": "2022-02-17T15:12:39.101Z"
}

localhost:3000/admin/delete-relation_type
body {       
    "relation_typeId": 7
}

localhost:3000/admin/delete-ressource_type
body {       
    "ressource_typeId": 9
}

localhost:3000/admin/delete-commit
body {
    "commitId": 3
}
////////////////////fin POST////////////////////