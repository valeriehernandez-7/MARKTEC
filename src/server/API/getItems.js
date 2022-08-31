const cnx = require('./cnx')
const sql = require('mssql')

async function getItems(){
    try{
        let pool = await sql.connect(cnx);
        let salida= await pool.request().query('SELECT * FROM[MARKTEC].[dbo].[Item]') 
        console.log(salida)
        console.log('Hola')
        return salida.recordsets;
        

    }catch(err){
        console.error(err);
    }
}

module.exports ={
    getItems :  getItems
}