const Sequelize = require('sequelize');

const sequelize = require('../utils/database');

const ressource_type = sequelize.define('ressource_type', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true
  },
  label: Sequelize.STRING,
  createdAt: Sequelize.DATE,
  updatedAt: Sequelize.DATE
});

module.exports = ressource_type;
