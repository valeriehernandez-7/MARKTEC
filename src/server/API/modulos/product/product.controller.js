const product = require('./product');
const express = require('express');
const router = express.Router();
class ProductController {
    constructor(app) {
      router.get('/', product.getAllProducts);
      app.use('/api/v1/products', router);
    }
 }
module.exports = ProductController;