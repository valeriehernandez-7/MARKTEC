import {Router} from 'express'
import {
    getItems,
    itemsCategory,
    itemInsert,
    itemsDescription,
    itemsCat,
    itemAmount
} from '../controllers/items.controller'



const router = Router()

router.get('/items',getItems)

router.get('/itemsAmount',itemAmount)

router.get('/itemsCategory',itemsCategory)

router.get('/itemsCatFilter',itemsCat)   

router.get('/itemsDescription',itemsDescription)

router.post('/itemsInsert',itemInsert) 

export default router