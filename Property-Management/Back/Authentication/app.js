const express = require('express');
const routes = require('./routes/routes');
const bodyParser = require('body-parser');
const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json())
app.use(express.json());

// Allows cross domain request serving
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

var router = express.Router();

// test route
app.get('/', (req, res) => {
    res.send( {msg: "Welcome server works"});
});

//route to handle user registration
app.use('/', router);

//router.post('/signup',routes.signup);

router.post('/login',routes.login);
router.post('/data',routes.home);
router.post('/register',routes.register);

router.post('/forgot',routes.forgot);
app.listen("3000", () => {
    console.log ('Server started on port 3000' );
});