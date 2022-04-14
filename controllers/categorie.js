const Categorie = require('../models/categorie');

exports.getCategories = (req, res, next) => {
    Categorie.findAll()
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}


exports.getCategorieById = (req, res, next) => {
    Categorie.findByPk(req.params.categorieId)
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}


exports.postCategorie = (req, res, next) => {
    const categorie = new Categorie({
        label: req.body.label
    })
    categorie
    .save()
    .then(result => {
        console.log('categorie created')
        res.json(result)
    })
    .catch(err => {
        console.log(err);
    })
}

exports.postDeleteCategorie = (req, res, next) => {
    const categorieId = req.body.categorieId
    Categorie.destroy({ where: { id: categorieId}})
      .then(result => {
        console.log('DESTROYED categorie');
        res.json(result);
      })
      .catch(err => console.log(err));
  };