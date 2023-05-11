var express = require('express');
var connection = require('./config/database.js');
var app = express();

app.use(function(req, res, next) {
  req.connection = connection
  next()
})

app.use(express.urlencoded({ extended: true }));

const authRouter = require("./routes/routes");

app.get('/', (req, res) => {
  res.send( {msg: "Welcome server works"});
});
let port = process.env.PORT || 3000;
app.listen(3000, function () {
  return console.log("Started user authentication server listening on port " + port);
});
