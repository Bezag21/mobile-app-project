// Importing modules
const express = require('express');
const morgan = require('morgan'); // you may need it for logging not compulsory
var bodyParser = require('body-parser');
var session = require('express-session');
const mongoose = require('mongoose');
const authRoutes = require('./routes/authentication.route');
// const check = require('./routes/check');
const inspection_route = require('./routes/inspection.route');
const user_route = require('./routes/user.route');
const upload_route = require('./routes/app.routes');

const User = require('./models/user');
const dotEnv = require('dotenv');


const errors = require("./middleware/errors.js");
const swaggerUi = require("swagger-ui-express"), swaggerDocument = require("./swagger.json");
const cors = require("cors")


// Initializing the app
const app = express();

// initalizing environment varaible file
dotEnv.config();

//connecting to database
mongoose.connect(process.env.DATA_BASE);
var db = mongoose.connection;
db.on('error', console.error.bind(console, "connection error"));
db.once('open', () => {console.log("connected.....") });


app.use('/uploads',express.static('uploads'));
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    // cookie: { secure: true }
  }));

// Initializing middlewares
app.use(morgan('dev'));
app.use(express.json());
app.use(bodyParser.json());




app.use(bodyParser.urlencoded({ extended: true }));


const starter =  async () => {
    
    // validating signup form input

  await  User.deleteMany({roles:'admin'});

    // Hashing user password
    const hashedPassword = await User.encryptPassword("12345678");
    //create new user object
    const newUser = new User({
        name :"AdminAdmin" ,
        username :"AdminAdmin",
      
        roles: "admin",
        password: hashedPassword
    })

    // save created user object
    const savedUser = await newUser.save();
    console.log(savedUser);  
            
}
starter();




// Checking if server starts successfully
app.get('/api',(req,res)=>{
    res.json({ message: 'server starts successfully '})
})


// Defining route
app.use('/api/auth', authRoutes);
app.use('/api/inspection', inspection_route);
app.use('/api/profile' , user_route);


// initialize routes
app.use("/api/upload", upload_route);

app.use(errors.errorHandler);

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

// assigning port
app.listen(3000,()=>{
    console.log('app running on port: 3000');
});

// Use ( npm start ) to run your server