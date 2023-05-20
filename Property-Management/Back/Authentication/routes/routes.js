const mysql = require('mysql');
const bcrypt = require('bcrypt');
const jwt=require('jsonwebtoken');

// Create connection
const db = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database : 'OnlineGrocery'
});
db.query(`select * from customer`, (error,result,fields)=>{
    if(error){
        return console.log(error);
    }
    return console.log(result);
})

//                               API 1
//                         user registration
//          Scenarios
// 1) If the email already exists
// 2) User created successfully

exports.register = async (req,res) => {
    var name= req.body.name;
    var email =req.body.email;
    
    var password  = req.body.password;
    const cryptpassword = await bcrypt.hash(password, 10);
   
    let values=[ [name,email,cryptpassword] ]
    var insertQuery =  'INSERT INTO CUSTOMER ( name, email,password) VALUES (?)';
    var checkemail = `select * from customer where email = '${email}';`
    
        db.query(checkemail, function (error, result,fields) {
          if(result.length> 0){
            res.status(409);
            res.send('email exist')
        }
       
        else{  
            db.query(insertQuery,values, function(error, result, fields) {
                res.status(201);
                res.send('sucessful')
                });
        }
     
});

}

  
  //                             API 2
  //                           USER LOGIN
  // 1) If an unregistered user tries to login
  // 2) If the user provides incorrect password
  // 3) Successful login of the user
 
  
exports.login = async (req, res) => {
    var email =req.body.email;
    var password = req.body.password;

    checkemail = `select * from customer where email = '${email}'`
    checkemailp = `select * from customer where email = '${email}' && password = '${password}';`;
    //const cryptpassword = bcrypt.compareSync(password, 10);

  db.query(checkemail, function (error, result,fields) {
    if(result.length > 0 && bcrypt.compareSync(password, result[0].password)  ){
        var payload = {
            email: req.body.email,
        };
        var token = jwt.sign(payload, result[0].password);
        res.send(token);
        //res.status(200);
       //res.end('Login sucessful')
    }
    if(result.length > 0 && !bcrypt.compareSync(password, result[0].password)){
        res.status(401)
        res.send("password doesn't match.")
    }
    else{
        res.status(401)
        res.send("Account doesn't exist please signup first")
       
        
    }
})
}
exports.home= async (req, res)=> {
    var str = req.get('Authorization');
    try {
        jwt.verify(str, KEY, { algorithm: 'HS256' });
        res.send("Welcome");
    } catch {
        res.status(401);
        res.send("Bad Token");
    }
}
exports.forgot = async (req, res) => {
    var email =req.body.email;
    var newpassword = req.body.password;
    const hashedpassword = await bcrypt.hash(newpassword, 10);
    checkemail = `select * from customer where email = '${email}'`
    change=`UPDATE customer SET password='${hashedpassword}' WHERE email= '${email}' ;`;
  
  db.query(checkemail, function (error, result,fields) {
    if(result.length > 0 && result[0].email == email ){
        db.query(change)
        res.status(201)
        res.send('Password changed successfully')
    }
    else{
        res.send(400)
        res.send('User DNE')
    }
  }
  )
}
    

 