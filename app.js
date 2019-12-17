const express = require('express')
const app = express()
const routes = require('./routers/router.js')

app.get('/', function (req, res) {
    res.send('Hello World!')
  })

/** Ouverture du server sur le port 2042 */
app.listen(3000, function () {
  console.log('Express listening on port 2042!')
})
