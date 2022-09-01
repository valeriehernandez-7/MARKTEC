const sql = require('mssql')
import {getConection} from '../database/conection';

export const login = async (req, res) => {
    const pool= await getConection()
    const {username, password} = req.body;   
    const result= await pool.request()
                    .input('@inUsername', sql.NVARCHAR(64),username).                    
                    output('outResultCode', sql.Int).
                    execute('SP_Login');
    console.log('itemCategoryName');
    res.json(result.recordset);
        
}