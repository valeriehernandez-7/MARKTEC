//const rest = new (require('rest-mssql-nodejs'))({
//    user: "admin",
//    password: "B1carbonato",
//    server: "database-1.cnwtel2ityvd.us-east-2.rds.amazonaws.com",
//    database: "MARKTEC",
//    port: 1433
//});
//
//setTimeout(async () => {
//
//    const result = await rest.executeQuery('SELECT * FROM[MARKTEC].[dbo].[Item]');
//    
//    console.log(result.data);
//
//}, 1500);

const express = require('express');
const app = express();
async function init() {
  const approuting = require('./modulos');
  const appmodules = new approuting(app);
  appmodules.init();
}
init();
module.exports = app;