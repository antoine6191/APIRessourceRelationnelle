const Ressource_type = require('../models/Ressource_type');

exports.getRessource_types = (req, res, next) => {
    Ressource_type.findAll()
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}


exports.getRessource_type = (req, res, next) => {
    Ressource_type.findByPk(req.params.ressource_typeId)
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}


exports.postRessource_type = (req, res, next) => {
    const ressource_type = new Ressource_type({
        label: req.body.label
    })
    ressource_type
    .save()
    .then(result => {
        console.log('Ressource_type created')
        res.json(result)
    })
    .catch(err => {
        console.log(err);
    })
}

exports.postDeleteRessource_type = (req, res, next) => {
    const Ressource_typeId = req.body.Ressource_typeId
    Ressource_type.destroy({ where: { id: Ressource_typeId}})
      .then(result => {
        console.log('DESTROYED Ressource_type');
        res.json(result);
      })
      .catch(err => console.log(err));
  };