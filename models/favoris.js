const Sequelize = require('sequelize');

const sequelize = require('../utils/database');
const user = require('./user');
const ressource = require('./ressource');

const favoris = sequelize.define('favoris', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true
  },
  favoris: Sequelize.BOOLEAN,
  createdAt: Sequelize.DATE,
  updatedAt: Sequelize.DATE,
  user_id: {
    type: Sequelize.INTEGER,
    references: {
      model: user,
      key: 'id'
    }
  },
  ressource_id: {
    type: Sequelize.INTEGER,
    references: {
      model: ressource,
      key: 'id'
    }
  }
});

module.exports = favoris;
