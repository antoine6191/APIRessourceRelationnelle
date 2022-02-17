const path = require('path');

const express = require('express');
const userController = require('../controllers/user')
const ressourceController = require('../controllers/ressource')

const router = express.Router();

router.get('/user/:userId', userController.getUser)
router.post('/user/add-user', userController.postUser)

router.get('/ressources', ressourceController.getRessources)
router.get('/ressource/:ressourceId', ressourceController.getRessource)
router.post('/ressources/add-ressource', ressourceController.postRessource)

module.exports = router;
