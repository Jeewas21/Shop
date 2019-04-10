var mysql = require('mysql');

//local mysql db connection
var connection = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'semion'
});

connection.connect(function (err) {
    if (err) throw err;
});

connection.query("SET SESSION wait_timeout = 604800");

module.exports = connection;