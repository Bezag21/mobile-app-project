var crypto = require('crypto');

module.exports = {
    selectLogIn: function (connection, name,email, password, callback) {
        var cryptPassword = crypto.createHash('sha256').update(password).digest('hex');
        connection.query("SELECT * FROM OnlineShopping.customer WHERE email = ? AND password = ?", [email, cryptPassword], callback);
    },
    selectSignUp: function (connection,name, email, password, callback) {
        connection.query("SELECT * FROM customer WHERE email = ?", [email], callback);
    },
    insert: function (connection, email, password, callback) {
        var cryptPassword = crypto.createHash('sha256').update(password).digest('hex');
        var credentials = [[email, cryptPassword]];
        connection.query("INSERT INTO OnlineShopping.customer (name,email, password) VALUES ?", [credentials], callback);
    }
};