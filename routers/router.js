/** Initialisation du routeur */
const express = require('express');
const router = express.Router();

/** Connection à la DB, c'est un peu comme une clé qui permet d'y accéder */
const DBConnection = require("./../dbConnection.js");
const connection = new DBConnection();

// Lib Moment et body-parser
const moment = require('moment');
var bodyParser = require('body-parser');
router.use(bodyParser.json());       // to support JSON-encoded bodies
router.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));

/** Initialisation des modèles **/
const UsersMdl = require("../Models/UsersMdl");

/** Les pages sont appelés par un controlleurs qui aura pour but de gérer les différents paramètres
 * de la page avant de l'afficher */
const Welcome = require("./../controllers/WelcomeCtrl");
const Registration = require("./../controllers/RegistrationCtrl");

const RoadMapList = require('./../Controllers/RoadMapListCrtl');
const RoadMapListMdl = require('./../Models/RoadMapListMdl');


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

router.get('/RoadMapList', function(req, res, next){
    new RoadMapList(req, res, connection);
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

// RoadMapsList
// Récuparation de toute les RoadMap
router.get('/GetAllRoadMaps', function(req, res){
    let roadMapListMdl = new RoadMapListMdl(connection);
    roadMapListMdl.getAllRoadMaps().then((result) => {
        //res.send(JSON.stringify(result));
        res.send(result);
    }).catch((error) => {
        res.send({code: 'error', error});
    });
});

// Suppréssion d'une RoadMap
router.delete('/DeleteRoadMap/:roadMapId', (req, res) => {
    let roadMapListMdl = new RoadMapListMdl(connection);
    roadMapListMdl.deleteRoadMaps(req.params.roadMapId).then((result) => {
        res.send(true);
    }).catch((error) => {
        res.send({ code: 'error', error });
    });
});

// Création d'une RoadMap
router.post('/CreateRoadMap', function(req, res){
    var name = req.body.Name;
    var password = req.body.Password;
    var nbrParticipants = parseInt(req.body.NbrParticipants);
    var location = req.body.Location;
    var sqlStartDate = moment(req.body.StartDate).format("YYYY-MM-DD HH:mm:ss");
    var sqlEndDate = moment(req.body.EndDate).format("YYYY-MM-DD HH:mm:ss");
    var budget = parseInt(req.body.Budget);
    var leader = req.body.Leader;


    let roadMapListMdl = new RoadMapListMdl(connection);
    roadMapListMdl.createRoadMap(name, password, nbrParticipants, location, sqlStartDate, sqlEndDate, budget, leader)
    .then((result) => {
        res.send(true);
    }).catch((error) => {
        res.send(false);
    });
});


/** Obligatoire pour pouvoir utiliser le router */
module.exports = router;
