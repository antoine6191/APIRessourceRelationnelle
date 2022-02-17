const Sequelize = require('sequelize');

const sequelize = new Sequelize('ressource_relationelle', 'root', 'root', {
  dialect: 'mysql',
  host: 'localhost',
  port: 8889
  //debug: true
});

module.exports = sequelize;
