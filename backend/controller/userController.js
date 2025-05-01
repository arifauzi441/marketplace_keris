const db = require(`../config/db`)
const { Seller, Product, ProductPict } = require(`../model/Associations`)
const fs = require(`fs`)
const path = require(`path`)

const getUsers = async (req, res, next) => {
    try {
        let data = await Seller.findAll();
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
        if(req.file) {
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
        let{oldPasswordInput, newPasswordInput, newPasswordInput2} = req.body
        let oldData = await Seller.findOne(
            {attributes: ['password']},
            {
                where: {id_seller: req.user.id}
            })
        if(oldData.password != oldPasswordInput) return res.status(401).json({msg: "Password tidak sesuai"})
        if(newPasswordInput != newPasswordInput2) return res.status(401).json({msg: "Password tidak sama"})

        await Seller.update(
            { password:newPasswordInput },
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

module.exports = { getUserById, getUserWithProductById, getUsers, updateUserById, changePassword }