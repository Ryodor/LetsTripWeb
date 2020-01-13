const express = require('express')
const app = express()
/** Déclaration du router */
const routes = require('./routers/router.js')

/** Déclaration des dossiers pour pouvoir envoyer leurs contenues au client */
app.use(express.static(__dirname + '/views'));
app.use('/css', express.static('views/css'));
app.use('/images', express.static('views/images'));

/** Initialisation du router */
app.use('/', routes);

/** Ouverture du server sur le port 2042, 
 * c'est le port sur lequel le site va tourner. */
app.listen(3000, function () {
  console.log('Express listening on port 2042!')
})

