const path = require('path');
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const adminRoutes = require('./routes/admin');
const userRoutes = require('./routes/user');
const sequelize = require('./utils/database');

// --------------------------------------------------------
const app = express();

app.set('view engine', 'ejs');
app.set('views', 'views');


app.use(bodyParser.json());

// Définitions des headers de la réponse
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
});

// Utilisation du middleware pour décoder les paramètres de l'URI
app.use(bodyParser.urlencoded({ extended: false }));

//
app.use(express.static(path.join(__dirname, 'public')));

// Définition des routes pour l'administration et l'accès public
app.use('/admin', adminRoutes)
app.use('/', userRoutes)


sequelize
    .sync()
    //.sync({ force: true })
<<<<<<< HEAD
    .then(() => {
        app.listen(process.env.SERVICE_PORT, console.log("Service running on port "+process.env.SERVICE_PORT));
    })
    .catch(e=>console.error(e));
=======
    .then(e => {
        app.listen(process.env.SERVICE_PORT)
    }  
)
>>>>>>> 5b668de15e302f25f8bade4fa52d385d7921b17e
  // 