
const express = require('express')
const check = require('../middlewares/admin')
const adminRouter = express.Router();
const {Product} = require('../models/product')


adminRouter.post('/admin/addproduct', check, async(req, res)=>{


    try{
      
        const { name, description, images, quantity, price, category } = req.body;
       
        let product = new Product({
            name, description, images, quantity, price, category
        });
    
        product = await product.save()
        res.json(product)


    }catch(e){
        res.status(500).json({error: e.message});
    }
})


adminRouter.get('/admin/get-products',check, async (req, res)=>{
try{
    const allItems =  await Product.find({});
    res.json(allItems);
}catch(e){
res.status(500).json({error: e.message})
}




})


adminRouter.delete('/admin/delete-product', check, async(req, res)=>{

    try{
            const productId = req.body.productId;
            console.log(productId)
        const response  =  await Product.findByIdAndDelete(productId);
            res.json(response);

    }catch(e){
        res.status(500).json({error: e.message})
    }
})


module.exports = adminRouter