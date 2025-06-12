const db = require(`../config/db`)
const { Op, where } = require('sequelize')
const { Seller, Product, ProductPict } = require(`../model/Associations`)
const fs = require(`fs`)
const path = require(`path`)
const Admin = require('../model/Admin')

const getUsers = async (req, res, next) => {
    try {
        let search = req.query.search || ""
        let data
        if (search == '') {
            data = await Seller.findAll({
                attributes: { exclude: ['password'] },
                where: {
                    "status": "diterima",
                },
            });
        } else {
            data = await Seller.findAll({
                attributes: { exclude: ['password'] },
                where: {
                    "status": "diterima",
                    [Op.or]: {
                        seller_name: { [Op.like]: `%${search}%` },
                        seller_phone: { [Op.like]: `%${search}%` },
                    }
                },
            });
        }
        return res.json({ msg: "Berhasil mengambil data", data })
    } catch (error) {
        console.log(error)
        return res.json({ msg: error })
    }
}

const getAllUsers = async (req, res, next) => {
    try {
        let search = req.query.search || ""
        let sellerData = await Seller.findAll({
            order: [["id_seller", "DESC"]],
            attributes: { exclude: ['password'] },
            where: {
                [Op.or]: {
                    status: { [Op.like]: `%${search}%` },
                    username: { [Op.like]: `%${search}%` },
                    seller_phone: { [Op.like]: `%${search}%` },
                }
            }
        });
        let adminData = await Admin.findAll({
            order: [["id_admin", "DESC"]],
            where: {
                [Op.or]: {
                    status: { [Op.like]: `%${search}%` },
                    username: { [Op.like]: `%${search}%` },
                    admin_phone: { [Op.like]: `%${search}%` },
                }
            }
        });
        let data = sellerData.concat(adminData)
        console.log
        res.json({ msg: "Berhasil mengambil data", data })
    } catch (error) {
        console.log(error)
        res.json({ msg: error })
    }
}

const getUserById = async (req, res, next) => {
    try {
        let data = await Seller.findOne({ where: { id_seller: req.params.id } });
        res.json({ msg: "Berhasil mengambil data", data })
    } catch (error) {
        console.log(error)
        res.json({ msg: error })
    }
}

const getAdminById = async (req, res, next) => {
    try {
        let data = await Admin.findOne({ where: { id_admin: req.user.id } });
        res.json({ msg: "Berhasil mengambil data", data })
    } catch (error) {
        console.log(error)
        res.json({ msg: error })
    }
}

const getUserWithProductById = async (req, res, next) => {
    try {
        let data = await Seller.findOne({
            where: { id_seller: req.user.id },
            include: {
                model: Product,
                include: { model: ProductPict }
            }
        }
        );
        res.status(200).json({ msg: "Berhasil mengambil data", data })
    } catch (error) {
        console.log(error)
        res.json({ msg: error })
    }
}

const updateUserById = async (req, res, next) => {
    try {
        let oldData = await Seller.findOne({ where: { id_seller: req.user.id } })
        let seller_photo = oldData.seller_photo

        if (seller_photo) {
            let oldPath = path.join(__dirname, "../public", seller_photo)
            fs.unlinkSync(oldPath)
            seller_photo = null
        }
        if (req.file) {
            seller_photo = `images/user_images/${req.file.filename}`
        }

        await Seller.update(
            { ...req.body, seller_photo },
            {
                where:
                    { id_seller: req.user.id }
            });
        res.json({ msg: "Berhasil memperbarui data" })
    } catch (error) {
        console.log(error)
        res.json({ msg: error })
    }
}

const changePassword = async (req, res, next) => {
    try {
        let { oldPasswordInput, newPasswordInput, newPasswordInput2 } = req.body
        
        let oldData = await Seller.findOne(
            { attributes: ['password'] , where: {id_seller: req.user.id}})
        if (oldData.password != oldPasswordInput) return res.status(401).json({ msg: "Password tidak sesuai" })
        if (newPasswordInput != newPasswordInput2) return res.status(401).json({ msg: "Password tidak sama" })

        await Seller.update(
            { password: newPasswordInput },
            {
                where:
                    { id_seller: req.user.id }
            });
        res.json({ msg: "Berhasil mengubah password" })
    } catch (error) {
        console.log(error)
        res.json({ msg: error })
    }
}

const changeStatus = async (req, res) => {
    try {
        let { role, id } = req.params
        if (role == 'admin') {
            let dataAdmin = await Admin.findOne({ where: { id_admin: id } })
            let status = (dataAdmin.status == "diterima") ? "belum diterima" : "diterima"
            await Admin.update({ status }, { where: { id_admin: id } })
        } else {
            let dataSeller = await Seller.findOne({ where: { id_seller: id } })
            let status = (dataSeller.status == "diterima") ? "belum diterima" : "diterima"
            await Seller.update({ status }, { where: { id_seller: id } })
        }
        return res.status(200).json({ msg: "Berhasil mengubah status users" })
    } catch (error) {
        console.log(error)
        return res.status(401).json({ msg: "Gagal mengubah status users" })
    }
}

const saveToken = async (req, res) => {
  try {
    const { token, id_admin } = req.body;
    console.log(id_admin)
    await Admin.update({fcm_token: token}, { where: {id_admin}})
    res.json({ status: 'success' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error' });
  }
};



module.exports = { saveToken, getAdminById, getUserById, getUserWithProductById, getUsers, getAllUsers, updateUserById, changePassword, changeStatus }