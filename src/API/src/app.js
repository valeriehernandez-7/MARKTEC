import express from 'express'
import config from './config'

const   app = express()
let port
//settings 
app.set('port', config.port)
export default app 