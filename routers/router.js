/** Initialisation du routeur */
const express = require('express');
const router = express.Router();

/** Connection à la DB, c'est un peu comme une clé qui permet d'y accéder */
const DBConnection = require("./../dbConnection.js");
const connection = new DBConnection();

/* initialization of the models */
// const CategoryMdl = require("../Models/CategoryMdl");

/** Les pages sont appelés par un controlleurs qui aura pour but de gérer les différents paramètres 
 * de la page avant de l'afficher */
const Welcome = require("./../controllers/WelcomeCtrl");

/** Lorsque qu'on utilise le chemin "host + / ", une instance du controller "HomePage" est créé */
router.get('/', function(req, res, next) {
    new Welcome(req, res, connection);
});

/** Obligatoire pour pouvoir utiliser le router */
module.exports = router;
