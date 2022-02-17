const Sequelize = require('sequelize');

const sequelize = require('../utils/database');

const user = sequelize.define('user', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true
  },
  nom: Sequelize.STRING,
  prenom: Sequelize.STRING,
  mail: Sequelize.STRING,
  telephone: Sequelize.STRING,
  motdepasse: Sequelize.STRING,
  cp: Sequelize.STRING,
  rue: Sequelize.STRING,
  numero: Sequelize.STRING,
  ville: Sequelize.STRING,
  role_id: Sequelize.INTEGER,
  createdAt: Sequelize.DATE,
  updatedAt: Sequelize.DATE
});

module.exports = user;
