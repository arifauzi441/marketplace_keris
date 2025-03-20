const Seller = require(`../model/SellerModel`)
const jwt = require(`jsonwebtoken`)

const register = async(req, res, next ) => {
    try {
        let {email, password, seller_address} = req.body
        let user = await Seller.findOne({where: {email}})
        console.log(user)
        if(user) return res.status(401).json({msg: "Email telah digunakan"})

        let data = {email, password, seller_address, status: "belum diterima"}

        await Seller.create(data,{fields: ["email", "password", "seller_address", "status"]})
        res.status(201).json({msg: "Berhasil melakukan registrasi, menunggu konfirmasi"})
    } catch (error) {
        console.log(error)
        res.status(400).json({msg: error})
    }
}

const login = async(req, res, next) => {
    try {
        let{email, password} = req.body
        let token = "";
        let data = await Seller.findOne({where: {email}})

        if(!data) return res.status(404).json({msg: "email tidak ditemukan", token: ""})

        if(password !== data.password) return res.status(401).json({msg: "Password salah", token: ""})

        if(data.status === "belum diterima") return res.status(401).json({msg: "register dalam status belum diterima", token: ""})
        token = jwt.sign({
            id : data.id_seller,
            email : data.email
        }, process.env.JWT_SECRET,{expiresIn: "1h"})

        res.status(200).json({msg: "Berhasil Login", token})
    } catch (error) {
        console.log(error)
        res.status(401).json({msg: error})
    }
}

module.exports = {register, login}