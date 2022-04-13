const Statistique = require('../models/statistique');


exports.getStatistiques = (req, res, next) => {
    Statistique.findAll()
        .then(statistique =>{
            console.log(statistique)
            res.json(statistique)
        })
        .catch(e => console.log(e))
}


exports.getStatistiquesByRessourceId = (req, res, next) => {
    Statistique.findAll({ where: { ressource_id: req.params.ressourceId}})
        .then(statistique =>{
            console.log(statistique)
            res.json(statistique)
        })
        .catch(e => console.log(e))
}
