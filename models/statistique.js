const Sequelize = require('sequelize');

const sequelize = require('../utils/database');
const ressource = require('./ressource');

const statistique = sequelize.define('statistique', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true
  },
  nb_vues: Sequelize.INTEGER,
  createdAt: Sequelize.DATE,
  updatedAt: Sequelize.DATE,
  ressource_id: {
    type: Sequelize.INTEGER,
    references: {
      model: ressource,
      key: 'id'
    }
  }
});

module.exports = statistique;
