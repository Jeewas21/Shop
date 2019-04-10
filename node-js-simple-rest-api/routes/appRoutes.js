'use strict';
var sql = require('../model/db.js');

module.exports = function (app) {
    // productList Routes
    app.get('/products', (req, response) => {
        sql.query("Select * from products", function (err, res) {

            if (err) {
                console.log("error: ", err);
                result(null, err);
            }
            else {

                console.log('products : ', res);

                response.json({ data: res });
            }
        });
    });

    app.get('/orders', (req, response) => {
        sql.query("Select * from orders", function (err, res) {

            if (err) {
                console.log("error: ", err);
                result(null, err);
            }
            else {

                console.log('orders : ', res);

                response.json({ data: res });
            }
        });
    });

    app.post('/my-orders', (req, response) => {
        sql.query("Select * from orders where id_user = ?", [{id_user:req.body.id_user}], function (err, res) {

            if (err) {
                console.log("error: ", err);
                result = null;
            }
            else {
                response.send(res);
            }
        });
    });


    app.post('/login', (req, response) => {
        var result = null;
        console.log(req.body);

        sql.query("Select * from users where login = ?", [req.body.login], function (err, res) {

            if (err) {
                console.log("error: ", err);
                result = null;
            }
            else {
                if (res.password == req.body.pass) {
                    console.log("success!", res);
                    response.json({ data: res });
                } else {
                    result = "non correct login or password";
                }
            }
        });
    });

    app.post('/create-order', (req, response) => {
        var result = null;
        console.log(req.body);

        var positions = JSON.parse(req.body.products);
        console.log(positions);


        var sum = 0;
        positions.forEach(item => {
            sum += item.product_price * item.count;
        });

        sql.query("INSERT INTO orders set ?", [{ id_user: req.body.id_user, sum_order: sum, state_order: 'новый' }], function (err, res) {

            if (err) {
                console.log("error: ", err);
                result = null;
            }
            else {
                console.log("success order", res);
                var code_order = res.insertId;

                positions.forEach(item => {
                    sql.query("INSERT INTO product_lists set ?", [{ code_order: code_order, articul: item.articul, count: item.count }], function (err, res) {

                        if (err) {
                            console.log("error: ", err);
                            result = null;
                        }
                        else {
                            console.log("success", res);
                            //response.json({ data: "done" });
                        }
                    });
                });


                sql.query("Select * from orders where id_user = ?", [{id_user:req.body.id_user}], function (err, res) {

                    if (err) {
                        console.log("error: ", err);
                        result = null;
                    }
                    else {
                        response.send(res);
                    }
                });
            }
        });

        //response.send("done");



        /*sql.query("Select * from users where login = ?", [req.body.login], function (err, res) {

            if (err) {
                console.log("error: ", err);
                result = null;
            }
            else {
                if (res.password == req.body.pass) {
                    console.log("success!", res);
                    response.json({ data: res });
                } else {
                    result = "non correct login or password";
                }
            }
        });*/
    });

    app.post('/confirm-order', (req, response) => {
        var result = null;
        console.log(req.body);

        sql.query("Select * from orders where code_order = ?", [req.body.code_order], function (err, res) {

            if (err) {
                console.log("error: ", err);
                result = null;
            }
            else {
                sql.query("UPDATE orders SET confirm_order = 1 WHERE code_order = ?", [req.body.code_order], function (err, res) {
                    if (err) {
                        console.log("error: ", err);
                        response.json({ data: "error" });
                    }
                    else {
                        response.json({ data: "done" });
                    }
                });
            }
        });
    });

    app.post('/update-order', (req, response) => {
        var result = null;
        console.log(req.body);

        sql.query("Select * from orders where code_order = ?", [req.body.code_order], function (err, res) {

            if (err) {
                console.log("error: ", err);
                result = null;
            }
            else {
                sql.query("UPDATE orders SET state_order = ? WHERE code_order = ?", [req.body.state_order, req.body.code_order], function (err, res) {
                    if (err) {
                        console.log("error: ", err);
                        response.json({ data: "error" });
                    }
                    else {
                        response.json({ data: "done" });
                    }
                });
            }
        });
    });
};