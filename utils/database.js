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
<<<<<<< HEAD

=======
  //debug: true
>>>>>>> 5b668de15e302f25f8bade4fa52d385d7921b17e
});

module.exports = sequelize;