const path = require('path');

const express = require('express');
const userController = require('../controllers/user')
const ressourceController = require('../controllers/ressource')
const categorieController = require('../controllers/categorie')
const commitController = require('../controllers/commit')
const ressource_typeController = require('../controllers/ressource_type')
const relation_typeController = require('../controllers/relation_type')
const roleController = require('../controllers/role')
const statistiqueController = require('../controllers/statistique')
const router = express.Router();

router.get('/users', userController.getUsers) //
router.post('/delete-user', userController.postDeleteUser) //
router.post('/delete-ressource', ressourceController.postDeleteRessource) //
router.post('/add-categorie', categorieController.postCategorie) //
router.post('/delete-categorie', categorieController.postDeleteCategorie) //
router.post('/add-relation_type', relation_typeController.postRelation_type) //
router.post('/add-ressource_type', ressource_typeController.postRessource_type) //
router.post('/delete-relation_type', relation_typeController.postDeleteRelation_type) //
router.post('/delete-ressource_type', ressource_typeController.postDeleteRessource_type) //
router.post('/delete-commit', commitController.postDeleteCommit)

router.get('/roles', roleController.getRoles) //
router.get('/statistiques', statistiqueController.getStatistiques) //
router.get('/statistiques/:ressourceId', statistiqueController.getStatistiquesByRessourceId) //

module.exports = router;