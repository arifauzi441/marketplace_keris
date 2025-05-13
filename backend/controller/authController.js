const { Op } = require("sequelize")
const Admin = require("../model/Admin")
const Seller = require(`../model/SellerModel`)
const jwt = require(`jsonwebtoken`)

const register = async(req, res, next ) => {
    try {
        let {seller_phone, password, username} = req.body
        let user = await Seller.findOne({
            where: {
                [Op.or]: [
                    { seller_phone },
                    { username }
                ]
            }
        })
        
        if(user) return res.status(401).json({msg: "no hp / username telah digunakan"})

        let data = {seller_phone, password, username, status: "belum diterima"}

        await Seller.create(data,{fields: ["seller_phone", "password", "username", "status"]})
        res.status(201).json({msg: "Berhasil melakukan registrasi, menunggu konfirmasi"})
    } catch (error) {
        console.log(error)
        res.status(400).json({msg: error})
    }
}

const registerAdmin = async(req, res, next ) => {
    try {
        let {username, password, admin_phone} = req.body
        let user = await Admin.findOne({where: {
            [Op.or]: [
                { admin_phone },
                { username }
            ]
        }})
        if(user) return res.status(401).json({msg: "no hp / username telah digunakan"})

        let data = {username, password, admin_phone, status: "belum diterima"}

        await Admin.create(data,{fields: ["username", "password", "admin_phone", "status"]})
        res.status(201).json({msg: "Berhasil melakukan registrasi, menunggu konfirmasi"})
    } catch (error) {
        console.log(error)
        res.status(400).json({msg: error})
    }
}

const login = async(req, res, next) => {
    try {
        let{username, password} = req.body
        let token = "";
        let data = await Seller.findOne({where: {username}})

        if(!data) return res.status(404).json({msg: "username tidak ditemukan", token: ""})

        if(password !== data.password) return res.status(401).json({msg: "Password salah", token: ""})

        if(data.status === "belum diterima") return res.status(401).json({msg: "register dalam status belum diterima", token: ""})
        token = jwt.sign({
            id : data.id_seller,
            username : data.username
        }, process.env.JWT_SECRET,{expiresIn: "1h"})

        res.status(200).json({msg: "Berhasil Login", token})
    } catch (error) {
        console.log(error)
        res.status(401).json({msg: error})
    }
}

const loginAdmin = async(req, res, next) => {
    try {
        let{username, password} = req.body
        let token = "";
        let data = await Admin.findOne({where: {username}})

        if(!data) return res.status(404).json({msg: "username tidak ditemukan", token: ""})

        if(password !== data.password) return res.status(401).json({msg: "Password salah", token: ""})

        if(data.status === "belum diterima") return res.status(401).json({msg: "register dalam status belum diterima", token: ""})
        token = jwt.sign({
            id : data.id_admin,
            username : data.username
        }, process.env.JWT_SECRET,{expiresIn: "1h"})

        res.status(200).json({msg: "Berhasil Login", token})
    } catch (error) {
        console.log(error)
        res.status(401).json({msg: error})
    }
}

module.exports = {register, registerAdmin, login, loginAdmin}