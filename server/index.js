const express = require('express')
const authRouter = require('./routes/auth')
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user')
const dotenv = require('dotenv');
dotenv.config();

const PORT = 4000;
const app = express()
const db = process.env.DB

mongoose.connect(db).then((val)=>{
    console.log("Database connection succesfull")
}).catch((e)=>{
    console.log(e)
})
app.use(express.json())
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter)
app.use(userRouter)

app.listen(PORT, '0.0.0.0',()=>{
    console.log(`Connected at ${PORT}`)
})