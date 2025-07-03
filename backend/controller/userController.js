const db = require(`../config/db`)
const { Op, where } = require('sequelize')
const { Seller, Product, ProductPict } = require(`../model/Associations`)
const fs = require(`fs`)
const path = require(`path`)
const Admin = require('../model/Admin')
const BuyerToken = require('../model/BuyerToken')

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
        res.json({ msg: ' ' + error })
    }
}

const changePassword = async (req, res, next) => {
    try {
        let { oldPasswordInput, newPasswordInput, newPasswordInput2 } = req.body

        let oldData = await Seller.findOne(
            { attributes: ['password'], where: { id_seller: req.user.id } })
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

const deleteUserById = async (req, res) => {
    try {
        let { role, id } = req.params
        if (role == 'admin') {
            let dataAdmin = await Admin.findOne({
                where: { id_admin: id }
            })
            if (!dataAdmin) return res.status(404).json({ msg: "User admin tidak ditemukan" })
            if (dataAdmin.admin_photo) {
                let photoPath = path.join(__dirname, "../public", dataAdmin.admin_photo)
                fs.unlinkSync(photoPath)
            }

            await Admin.destroy({ where: { id_admin: id } })
        } else {
            let dataSeller = await Seller.findOne({
                where: { id_seller: id },
                include: [{
                    model: Product,
                    include: [{ model: ProductPict }]
                }]
            })
            if (!dataSeller) return res.status(404).json({ msg: "User seller tidak ditemukan" })
            let photoPath = []
            if (dataSeller.seller_photo) {
                let sellerPath = path.join(__dirname, "../public", dataSeller.seller_photo)
                photoPath.push(sellerPath)
            }
            if (dataSeller.products.length > 0) {
                dataSeller.products.forEach(product => {
                    if (product.productpicts.length > 0) {
                        product.productpicts.forEach(pict => {
                            let productPath = path.join(__dirname, "../public", pict.path)
                            photoPath.push(productPath)
                        })
                    }
                })
            }
            if (photoPath.length > 0) {
                photoPath.forEach(photo => {
                    fs.unlinkSync(photo)
                })
            }
            await Seller.destroy({ where: { id_seller: id } })
        }
        return res.status(200).json({ msg: "Berhasil menghapus data users" })
    } catch (error) {
        console.log(error)
        return res.status(401).json({ msg: "Gagal menghapus users" })
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
    if (req.body.id_admin) {
        try {
            const { token, id_admin } = req.body;
            console.log(id_admin)
            await Admin.update({ fcm_token: token }, { where: { id_admin } })
            res.json({ status: 'success' });
        } catch (error) {
            console.error(error);
            res.status(500).json({ status: 'error' });
        }
    } else if (req.body.id_seller) {
        try {
            const { token, id_seller } = req.body;
            console.log(id_seller)
            await Seller.update({ fcm_token: token }, { where: { id_seller } })
            res.json({ status: 'success' });
        } catch (error) {
            console.error(error);
            res.status(500).json({ status: 'error' });
        }
    } else {
        try {
            const { token } = req.body;
            const data = await BuyerToken.findAll({ where: { fcm_token: token } })
            console.log(data)
            if (data.length != 0) return res.json({ status: "Token sudah ada" })
            let response = await BuyerToken.create({ fcm_token: token })
            res.json({ status: 'success' });
        } catch (error) {
            console.error(error);
            res.status(500).json({ status: 'error' });
        }
    }
};

module.exports = {
    saveToken,
    getAdminById,
    getUserById,
    getUserWithProductById,
    getUsers,
    getAllUsers,
    updateUserById,
    changePassword,
    changeStatus,
    deleteUserById,
}