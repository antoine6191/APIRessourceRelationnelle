const path = require('path');

const express = require('express');
const userController = require('../controllers/user')
const ressourceController = require('../controllers/ressource')
const categorieController = require('../controllers/categorie')
const router = express.Router();

router.get('/users', userController.getUsers) //
router.post('/delete-user', userController.postDeleteUser) //
router.post('/delete-ressource', ressourceController.postDeleteRessource) //
router.post('/add-categorie', categorieController.postCategorie) //
router.post('/delete-categorie', categorieController.postDeleteCategorie) //

module.exports = router;
