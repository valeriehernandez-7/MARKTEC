//import  sql from 'mssql'
const sql = require('mssql')
import { request } from 'express';
import {login} from '../database/conection';

export const getItems = async (req,res) => {
    const pool= await getConection()
    const result= await pool.request().query("Select * from item");
    console.log(result);    
    res.json(result);
}


//exect sp
export const itemsCategory = async (req, res) => {
    const pool= await getConection()
    const {itemCategoryName}  = req.body;
    console.log(itemCategoryName);
    if (itemCategoryName==null){
        const result= await pool.request()
                    .input('inCategoryName', sql.NVARCHAR(64),null).
                    output('outResultCode', sql.Int).
                    execute('SP_ItemCategoryFilter');
        res.json(result.recordset);    
    }else{
        const result= await pool.request()
                        .input('inCategoryName', sql.NVARCHAR(64),itemCategoryName).
                        output('outResultCode', sql.Int).
                        execute('SP_ItemCategoryFilter');
        console.log('itemCategoryName');
        res.json(result.recordset);
    };    
}

export const itemInsert = (req,res) => {
    const {category,description,price}  = req.body;
    if (category == null ){
        console.log ("aaaaa");   
    }else{
        console.log (category, description, price);   
    }
    
}

