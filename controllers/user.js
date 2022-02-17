const User = require('../models/user');

exports.getUsers = (req, res, next) => {
    User.findAll()
        .then(user =>{
            console.log(user)
            res.json(user)
        })
        .catch(e => console.log(e))
}

exports.getUser = (req, res, next) => {
    User.findByPk(req.params.userId)
        .then(user =>{
            console.log(user)
            res.json(user)
        })
        .catch(e => console.log(e))
}


exports.postUser = (req, res, next) => {
    const nom = req.body.nom;
    const prenom = req.body.prenom;
    const mail = req.body.mail;
    const telephone = req.body.telephone;
    const motdepasse = req.body.motdepasse;
    const cp = req.body.cp;
    const rue = req.body.rue;
    const numero = req.body.numero;
    const ville = req.body.ville;
    const role_id = req.body.role_id;
    const user = new User({
        nom: nom,
        prenom: prenom,
        mail: mail,
        telephone: telephone,
        motdepasse: motdepasse,
        cp: cp,
        rue: rue,
        numero: numero,
        ville: ville,
        role_id: role_id
    })
    user
    .save()
    .then(result => {
        console.log('user created')
        res.json(result)
    })
    .catch(err => {
        console.log(err);
    })
}

exports.postDeleteUser = (req, res, next) => {
    const userId = req.body.userId
    User.destroy({ where: { id: userId}})
      .then(result => {
        console.log('DESTROYED user');
        res.json(result);
      })
      .catch(err => console.log(err));
  };