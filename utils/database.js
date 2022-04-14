const Sequelize = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize('ressource_relationelle', process.env.DB_USER, process.env.DB_PASSWORD, {
  dialect: process.env.DB_CONTEXT,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  debug: true
});

module.exports = sequelize;