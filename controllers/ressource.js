const Ressource = require('../models/ressource');

exports.getRessources = (req, res, next) => {
    Ressource.findAll()
        .then(ressource =>{
            console.log(ressource)
            res.json(ressource)
        })
        .catch(e => console.log(e))
}


exports.getRessource = (req, res, next) => {
    Ressource.findByPk(req.params.ressourceId)
        .then(ressource =>{
            console.log(ressource)
            res.json(ressource)
        })
        .catch(e => console.log(e))
}


exports.postRessource = (req, res, next) => {
    const titre = req.body.titre;
    const description = req.body.description;
    const categorieId = req.body.categorieId;
    const relation_typeId = req.body.relation_typeId;
    const ressource_typeId = req.body.ressource_typeId;
    const ressource = new Ressource({
        titre: titre,
        description: description,
        categorieId: categorieId,
        relation_typeId: relation_typeId,
        ressource_typeId: ressource_typeId
    })
    ressource
    .save()
    .then(result => {
        console.log('ressource created')
        res.json(result)
    })
    .catch(err => {
        console.log(err);
    })
}

exports.postDeleteRessource = (req, res, next) => {
    const ressourceId = req.body.ressourceId
    Ressource.destroy({ where: { id: ressourceId}})
      .then(result => {
        console.log('DESTROYED user');
        res.json(result);
      })
      .catch(err => console.log(err));
  };