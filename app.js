const path = require('path');
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const adminRoutes = require('./routes/admin');
const userRoutes = require('./routes/user');
const sequelize = require('./utils/database');
const fs = require("fs");
const https = require("https");
const mandatory_env = require("./utils/mandatory_env.json");
// --------------------------------------------------------

// Variables d'environnement
const env = process.env;

// Vérification de la présence des variables d'environnement obligatoires
const is_ready = new Promise (async (resolve,reject)=> {
    await Promise.all(mandatory_env.map(el => {
       if (env[el] == undefined) reject("[ERREUR] La variable d'environnement "+el+" est manquante et obligatoire.");
    }));
    resolve();
});

// Tableau du nom des varaibles d'environnement obligatoires
is_ready.then(()=>{
    console.log("[INFO] Toutes variables d'environnement oblagtroires sont présentes");

    const app = express();

    app.set('trust proxy',true);
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

    app.all("*",(req,res,next)=>{
        console.log(req.method, req.ip, req.originalUrl);
        next();
    })


    // Synchronisation avec la base de données
    // Si la synchro fonctionne, alors on lance le serveur
    sequelize
        // L'option "force: true" supprime toutes les données et le schéma avant de le recréer
        .sync({force: false})
        .then(() => {
            // Utilisation du mode HTTP
            app.listen(env.SERVICE_HTTP_PORT, console.log("[INFO] HTTP service running on port "+env.SERVICE_HTTP_PORT));

            // Paramétrage du HTTPS
            if (env.TLS_KEY_FILE != undefined && env.TLS_CERT_FILE != undefined) {
                console.log("[INFO] Les paramètres de clef et de certificat TLS sont définis");
                // Conditions requises poi=ur le lancement du service HTTPS
                const is_tls_ready = new Promise((resolve, reject)=>{
                    // Vérification du port HTTPS à utiliser : existe et différent du HTTP
                    if (process.env.SERVICE_HTTPS_PORT == undefined || env.SERVICE_HTTPS_PORT == env.SERVICE_HTTP_PORT) {
                        reject("[ALERT] Le port HTTPS configuré n'est pas valide ("+process.env.SERVICE_HTTPS_PORT+"). Sa valeur est peut-être vide ou égale à celle utilisée pour le service HTTP ("+env.SERVICE_HTTP_PORT+").");
                    }

                    // Vérification de la validité des fichiers indiqués dans les variables d'environnement
                    if (env.TLS_CERT_FILE.length == 0 || env.TLS_KEY_FILE.length == 0) reject("[ALERT] Le chemin du fichier de certificat ou de clef est absent");
                    
                    try {
                        const tls_key = fs.readFileSync(env.TLS_KEY_FILE).toString();
                        const tls_cert = fs.readFileSync(env.TLS_CERT_FILE).toString();
                        if (tls_cert != undefined && tls_key != undefined) {
                            resolve({
                                key: tls_key,
                                cert: tls_cert
                            })
                        } else reject("[ALERT] Le fichier de certificat ou de clef est absent");
                    } catch (e) {
                        reject("[ALERT] Impossible d'ouvrir le certificat ou la clef");
                    }
                });
                // Lancement du service HTTPS
                is_tls_ready.then((tls)=>{
                    console.log("[DEBUG]",tls);
                    https.createServer(tls, app).listen(env.SERVICE_HTTPS_PORT,()=>console.log("[INFO] : HTTPS service running on port "+env.SERVICE_HTTPS_PORT));
                }).catch((e)=>console.error(e));
            }
        })
        .catch(e=>console.error(e));

}).catch((e)=>console.error(e));


