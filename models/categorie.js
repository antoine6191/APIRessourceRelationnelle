const Sequelize = require('sequelize');

const sequelize = require('../utils/database');

const categorie = sequelize.define('categorie', {
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


module.exports = categorie;
