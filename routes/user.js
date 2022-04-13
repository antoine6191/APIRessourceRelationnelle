const path = require('path');

const express = require('express');
const userController = require('../controllers/user')
const categorieController = require('../controllers/categorie')
const ressourceController = require('../controllers/ressource')
const ressource_typeController = require('../controllers/ressource_type')
const relation_typeController = require('../controllers/relation_type')
const commitController = require('../controllers/commit')
const favorisController = require('../controllers/favoris')
const router = express.Router();

router.get('/user/:userId', userController.getUser) //
router.post('/add-user', userController.postUser) //

router.get('/ressource_types', ressource_typeController.getRessource_types) //
//router.get('/ressource_types/:ressource_typeId', ressource_typeController.getRessource_type) //
router.get('/relation_types', relation_typeController.getRelation_types) //
//router.get('/relation_types/:relation_typeId', relation_typeController.getRelation_type) //
router.get('/categorie/:categorieId', categorieController.getCategorieById)
router.get('/ressources', ressourceController.getRessources) //
router.get('/ressources/:ressourceId', ressourceController.getRessource) //
router.post('/add-ressource', ressourceController.postRessource) //
router.get('/ressources/:ressourceId', ressourceController.getRessource) //
router.get('/commits/:ressourceId', commitController.getCommitsByRessource) //
router.post('/add-commit', commitController.postCommit)
router.get('/favoris/:user_id', favorisController.getFavorisByUser)
router.post('/add-favoris', favorisController.postFavoris)
router.post('/delete-favoris', favorisController.postDeleteFavoris)

module.exports = router;