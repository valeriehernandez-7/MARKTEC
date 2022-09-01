import {Router} from 'express'
import {getItems} from '../controllers/items.controller'
import {itemsCategory} from '../controllers/items.controller'
import {itemInsert} from '../controllers/items.controller'

const router = Router()

router.get('/items',getItems)

router.get('/itemsAmount',getItems)

router.get('/itemsCategory',itemsCategory) 

router.get('/itemsCategoryName',getItems)  

router.get('/itemsDescription',getItems)

router.post('/itemsInsert',itemInsert) 

export default router