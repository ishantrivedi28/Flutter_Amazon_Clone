const express = require('express')
const mongoose = require('mongoose')
const User = require('../models/user')
const jwt = require('jsonwebtoken')
const secretKey = "idsjiajeijjt32239()*)(@$_)_)#(+R()#IOFJ#)(40i21oe@)$()_@)Koskfeesfeoek204i03q@)()#_3)(@#_90-1"

//checks if the user has valid token or not and check if the user is admin or not
const check = async (req, res, next)=>{
try{
    const token = req.header('x-auth-token');
    if(!token) return res.status(401).json({msg: "No auth token, access denied"})
    const result = jwt.verify(token, secretKey)
    if(!result) return res.status(401).json({msg: "Token verification failed, authorization denied"})

    const user = await User.findById(result.id);
    if(user.type == 'admin' ) {
        req.user = result.id
        req.token = token;
        next()
    }
    else return res.status(401).json({msg: "You are not an admin."})
}catch(e){ res.status(500).json({error: e.message});}


}

module.exports = check