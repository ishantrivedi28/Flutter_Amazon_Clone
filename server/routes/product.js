const express = require('express')
const productRouter = express.Router();
const auth = require('../middlewares/auth') 
const {Product} = require('../models/product')

productRouter.get('/api/products',auth, async (req, res)=>{
    try{
        console.log(req.query.category)
        const allItems =  await Product.find({category: req.query.category});
        res.json(allItems);
    }catch(e){
    res.status(500).json({error: e.message})
    }    
    })


    productRouter.get('/api/products/search/:name',auth, async (req, res)=>{
        try{
            const allItems =  await Product.find({name: {$regex: req.params.name, $options: "i"}});
            res.json(allItems);
        }catch(e){
        res.status(500).json({error: e.message})
        }    
        })

    productRouter.post('/api/rate-product', auth, async(req, res)=>{

        try{
            const { rating, id} = req.body;
           let product = await Product.findById(id);
           console.log(product.price)

          for(let i = 0; i<product.ratings.length; i++){

            if(product.ratings[i].userId == req.user){
                product.ratings.splice(i,1);
                break;
            }
          }
            const ratingSchema = {
                userId: req.user,
                rating,
            }
            product.ratings.push(ratingSchema);
            product = await product.save()
            res.json(product);
        }
        catch(e){
res.status(500).json({error: e.message})
        }
    })

    productRouter.get('/api/deal-of-the-day', auth,async (req, res)=>{

        try{
            let productss = await Product.find({});
       productss= productss.sort((a,b)=>{
        aSum = 0;
        bSum = 0;

        for(let i = 0; i < a.ratings.length ; i++)
        aSum += a.ratings[i].rating

        for(let i = 0; i < b.ratings.length ; i++)
        bSum += b.ratings[i].rating

        return aSum < bSum ? 1  : -1
       })

       res.json(productss[0])
        }catch(e){
            res.status(500).json({error: e.message});
        }



    })
    


module.exports = productRouter