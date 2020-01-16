/** Initialisation du routeur */
const express = require('express');
const router = express.Router();

/** Connection à la DB, c'est un peu comme une clé qui permet d'y accéder */
const DBConnection = require("./../dbConnection.js");
const connection = new DBConnection();

/** Initialisation des modèles **/
const UsersMdl = require("../Models/UsersMdl");

/** Les pages sont appelés par un controlleurs qui aura pour but de gérer les différents paramètres 
 * de la page avant de l'afficher */
const Welcome = require("./../controllers/WelcomeCtrl");
const Registration = require("./../controllers/RegistrationCtrl");


/** Lorsque qu'on utilise le chemin "host + / ", une instance du controller "HomePage" est créé */
router.get('/', function(req, res, next) {
    res.redirect('/Welcome') //Redirection vers la page d'acceuille
});

router.get('/Welcome', function(req, res, next) {
    new Welcome(req, res, connection);
});

router.get('/Registration', function(req, res, next) {
    new Registration(req, res, connection);
});


/* INSERTION DANS LA DB */

//Ajout d'un nouvel utilisateur
router.get('/newuser/:last_name/:first_name/:email/:password', (req, res) => {
    let usersMdl = new UsersMdl(connection);
    usersMdl.newUser(req.params.last_name, req.params.first_name, req.params.email, req.params.password)
        .then(result => {
            res.send(JSON.stringify(result));
        }).catch((error) => {
            res.send({ code: 'error', error })
        });
});


/** Obligatoire pour pouvoir utiliser le router */
module.exports = router;