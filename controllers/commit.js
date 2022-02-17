const Commit = require('../models/commit');

exports.getCommits = (req, res, next) => {
    Commit.findAll()
        .then(result =>{
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}

exports.getCommitsByRessource = (req, res, next) => {
    const ressource_id = req.params.ressourceId
    Commit.findAll({ where: { ressource_id: ressource_id}})
        .then(result => {
            console.log(result)
            res.json(result)
        })
        .catch(e => console.log(e))
}

exports.postCommit = (req, res , next) => {
    const post = req.body.post;
    const texte = req.body.texte;
    const user_id = req.body.user_id;
    const ressource_id = req.body.ressource_id;
    const commit = new Commit({
        post : post,
        texte: texte,
        user_id: user_id,
        ressource_id: ressource_id
    })
    commit.save()
    .then(result => {
        res.json(result)
    })
    .catch(e => console.log(e))
}

exports.postDeleteCommit = (req, res , next) => {
    const commitId = req.body.commitId
    Commit.destroy({ where: { id: commitId}})
    .then(result => {
        res.json(result)
    })
    .catch(e => console.log(e))
}

