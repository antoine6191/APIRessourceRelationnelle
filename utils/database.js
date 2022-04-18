const {Sequelize} = require('sequelize');
require('dotenv').config();

// --------------------------------------------------------

// Connexion à la base de données à partir de variables d'environnement
const sequelize = new Sequelize({
  password: process.env.DB_PASSWORD,
  username: process.env.DB_USER,
  dialect: process.env.DB_CONTEXT,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  logging: false,
});

module.exports = sequelize;