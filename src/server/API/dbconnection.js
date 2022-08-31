const mssql = require('mssql');
class DBConnection {
  async getConnection() {
     try {
       return await ({
              user: 'admin',
              password: 'B1carbonato',
              server: 'database-1.cnwtel2ityvd.us-east-2.rds.amazonaws.com',
              database: 'MARKETC',
              port: 1433
       });
    }
    catch(error) {
      console.log(error);
    }
  }
}
module.exports = new DBConnection();

