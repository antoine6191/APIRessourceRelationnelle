const Sequelize = require('sequelize');

const sequelize = require('../utils/database');

const relation_type = sequelize.define('relation_type', {
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

module.exports = relation_type;
