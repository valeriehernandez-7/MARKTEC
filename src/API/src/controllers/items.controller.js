//import  sql from 'mssql'
const sql = require('mssql')
import { request } from 'express';
import {getConection} from '../database/conection';

export const getItems = async (req,res) => {
    const pool= await getConection()
    const result= await pool.request().query("Select * from item");
    console.log(result);    
    res.json(result);
}


//exect sp

//filtrar items por cantidad
export const itemAmount=  async (req, res) => {
    const pool= await getConection()
    const {itemAmount}  = req.body;
    console.log();
    if (itemAmount==null){
        const result= await pool.request()
                    .input('inAmount', sql.Int,null).
                    output('outResultCode', sql.Int).
                    execute('SP_ItemAmountFilter');
        res.json(result.recordset);    
    }else{
        const result= await pool.request()
                        .input('inAmount', sql.Int,itemAmount).
                        output('outResultCode', sql.Int).
                        execute('SP_ItemAmountFilter');
        res.json(result.recordset);
    };    
}

//filtado de items por categoria 
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
        res.json(result.recordset);
    };    
}

//listado de categorias
export const itemsCat = async (req, res) =>{
    const pool= await getConection() 
    const result= await pool.request().
                    output('outResultCode', sql.int).
                    execute('SP_ItemCategoryNameFilter');
    res.json(result.recordset)
};

//filtrar items por descripcion
export const itemsDescription = async (req, res) => {
    const pool= await getConection()
    const {itemDescription}  = req.body;
    console.log(itemDescription);
    if (itemDescription==null){
        const result= await pool.request()
                    .input('inDescription', sql.NVARCHAR(128),null).
                    output('outResultCode', sql.Int).
                    execute('[SP_ItemDescriptionFilter]');
        res.json(result.recordset);    
    }else{
        const result= await pool.request()
                        .input('inDescription', sql.NVARCHAR(128),itemDescription).
                        output('outResultCode', sql.Int).
                        execute('[SP_ItemDescriptionFilter]');
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



