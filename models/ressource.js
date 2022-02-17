const Sequelize = require('sequelize');

const sequelize = require('../utils/database');
const categorie = require('./categorie');
const relation_type = require('./relation_type');
const ressource_type = require('./ressource_type');

const ressource = sequelize.define('ressource', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true
  },
  titre: Sequelize.STRING,
  description: Sequelize.STRING,
  createdAt: Sequelize.DATE,
  updatedAt: Sequelize.DATE,
  categorie_id: {
    type: Sequelize.INTEGER,
    references: {
      model: categorie,
      key: 'id'
    }
  },
  relation_types_id: {
    type: Sequelize.INTEGER,
    references: {
      model: relation_type,
      key: 'id'
    }
  },
  ressource_types_id: {
    type: Sequelize.INTEGER,
    references: {
      model: ressource_type,
      key: 'id'
    }
  },
});

//ressource.hasOne(categorie)


module.exports = ressource;
