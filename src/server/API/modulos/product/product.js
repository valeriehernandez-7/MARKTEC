const productMssql = require('./product.mssql');
class product {
    async getAllProducts(req, res) {
      try {
         const output = await productMssql.getAllProducts();
         res.send(output);
      }
      catch (error) {
      console.log(error);
    }
 }
}
module.exports = new product();