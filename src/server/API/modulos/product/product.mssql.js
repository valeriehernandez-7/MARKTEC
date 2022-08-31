const mssqlcon = require('../../dbconnection');
class ProductMSSql { 
    async getAllProducts() {
    const conn = await mssqlcon.getConnection();
    const res = await conn.request().query('SELECT * FROM[MARKTEC].[dbo].[Item]');
    return res.recordset;
  }
}
module.exports = new ProductMSSql();