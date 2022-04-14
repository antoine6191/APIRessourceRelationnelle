const Relation_type = require('../models/relation_type');

exports.getRelation_types = (req, res, next) => {
    Relation_type.findAll()
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}


exports.getRelation_type = (req, res, next) => {
    Relation_type.findByPk(req.params.relation_typeId)
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}


exports.postRelation_type = (req, res, next) => {
    const relation_type = new Relation_type({
        label: req.body.label
    })
    relation_type
    .save()
    .then(result => {
        console.log('Relation_type created')
        res.json(result)
    })
    .catch(err => {
        console.log(err);
    })
}


exports.postDeleteRelation_type = (req, res, next) => {
    const relation_typeId = req.body.relation_typeId
    Relation_type.destroy({ where: { id: relation_typeId}})
      .then(result => {
        console.log('DESTROYED Relation_type');
        res.json(result);
      })
      .catch(err => console.log(err));
  };