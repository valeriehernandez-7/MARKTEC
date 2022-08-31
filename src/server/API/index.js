console.log("Estableciendo API")
const DBitems = require ("./getItems")

var express = require('express');
var bodyP= require('body-parser');
var cors = require('cors')

var app= express();
var router = express.Router();

app.use(bodyP.urlencoded({ extended:true }));
app.use(bodyP.json());
app.use(cors());    
app.use('/API',router);

router.get('/getit').get((request,response) => {
    DBitems.getItems().then(result => {
        response.send("H");
    }) 
})
app.get('/', (req, res) => {
    DBitems.getItems().then(result => {
        res.send("H");
    }) 

    //res.send('"Hello World!" has been called ');
    
});

var portcnx= process.env.PORT || 5000;
app.listen(5000,() => console.log("API establesida"));

