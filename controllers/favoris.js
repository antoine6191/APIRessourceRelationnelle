const Favoris = require('../models/favoris');

exports.getFavorisByUser = (req, res, next) => {
    const user_id = req.params.user_id
    Favoris.findAll({ where: { user_id: user_id}})
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}


exports.postFavoris = (req, res , next) => {
    const favoris = req.body.favoris
    const user_id = req.body.user_id;
    const ressource_id = req.body.ressource_id;
    const fav = new Favoris({
        favoris: favoris,
        user_id: user_id,
        ressource_id: ressource_id
    })
    fav.save()
    .then(result => {
        res.json(result)
    })
    .catch(e => console.log(e))
}

exports.postDeleteFavoris = (req, res , next) => {
    const favorisId = req.body.favorisId
    Favoris.destroy({ where: { id: favorisId}})
    .then(result => {
        res.json(result)
    })
    .catch(e => console.log(e))
}

