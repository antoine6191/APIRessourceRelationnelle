const Sequelize = require('sequelize');

const sequelize = require('../utils/database');

const role = sequelize.define('role', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
    primaryKey: true
  },
  libelle: Sequelize.STRING,
});

module.exports = role;
