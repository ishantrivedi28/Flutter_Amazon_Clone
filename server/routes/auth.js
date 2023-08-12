const express = require('express')
const User = require('../models/user')
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

const authRouter = express.Router();
const secretKey = "idsjiajeijjt32239()*)(@$_)_)#(+R()#IOFJ#)(40i21oe@)$()_@)Koskfeesfeoek204i03q@)()#_3)(@#_90-1"

authRouter.post('/api/signup',async (req,res)=>{
   try{
    const {name, email, password} =  req.body;
    const result = await User.findOne({email})
    if(result){
        return res.status(400).json({msg: "Email already exists"});
    }
    const hashedpassword = await bcryptjs.hash(password, 8);
    let user  = new User({
        email, password: hashedpassword, name
    })
    user = await user.save()
    res.json(user);
   }catch(e){
    res.status(500).json({error: e.message})
   }

})

authRouter.post('/api/signin',async (req, res)=>{
    try{
        const {email, password} = req.body;

        const user =  await User.findOne({email})
        if(!user){
            res.status(400).json({
                msg: "User with this email does not exist!"
            })
        }
     

        const hashedpassword = user.password;
        const isMatch = await bcryptjs.compare(password, hashedpassword)
      
        if(!isMatch){
         res.status(400).json({
            msg: "Incorrect password."
         })
    
    }
    console.log(user.name)
   const token =  jwt.sign({id: user._id}, secretKey)

   res.json({token, ...user._doc})
    
}catch(e){
    res.status(500).json({error: e.message});
}
}
)

authRouter.post('/api/isTokenValid',async (req, res)=>{
   try{
    const token = req.header('x-auth-token');
    if(!token) return res.json(false);

  const verifiedRes =  jwt.verify(token, secretKey);
  if(!verifiedRes) res.json(false);

  const user = await User.findById(verifiedRes.id);
  if(!user) return res.json(false);

  res.json(true);
   }catch(e){
    res.status(500).json({error: e.message})
   }


})

authRouter.get('/', auth, async(req, res)=>{
    const userID = req.user;
    const user = await User.findById(userID);
    res.json({...user._doc, token: req.token});

})

module.exports = authRouter