const jwt = require('jsonwebtoken')
const authR = require('../routes/auth')
const secretKey = "idsjiajeijjt32239()*)(@$_)_)#(+R()#IOFJ#)(40i21oe@)$()_@)Koskfeesfeoek204i03q@)()#_3)(@#_90-1"

const auth = (req, res, next)=>{
try{
    
    const token = req.header('x-auth-token');
    if(!token) return res.status(401).json({msg: "No auth token, access deneid."})

   const jwtRes = jwt.verify(token, secretKey)

   if(!jwtRes) return res.status(401).json({msg: "Token verification failed, authorization denied."})

   req.user = jwtRes.id;
   req.token = token;
   
   next()
}catch(e){
    res.status(500).json({error: e.message})
}
}

module.exports = auth;