const db = require(`../config/db`)
const { Seller, Product, ProductPict } = require(`../model/Associations`)

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

module.exports = {getUserById, getUserWithProductById, getUsers}