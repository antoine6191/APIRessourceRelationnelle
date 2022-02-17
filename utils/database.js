const Sequelize = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize('ressource_relationelle', process.env.USERBDD, process.env.MDPBDD, {
  dialect: 'mysql',
  host: 'localhost',
  port: 8889
  //debug: true
});

module.exports = sequelize;
