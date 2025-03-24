const { Sequelize } = require("sequelize")
const Product = require(`../model/ProductModel`)
const ProductPict = require("../model/ProductPictModel")
const { db } = require("../config/db")

const getProduct = async (req, res, next) => {
    try {
        let product = await Product.findAll()
        res.status(200).json({ product })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengakses product" });
    }
}

const getProductByIdSeller = async (req, res, next) => {
    try {
        let product = await Product.findAll({ where: { id_seller: req.params.id } })
        res.status(200).json({ product });
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengakses product" })
    }
}

const getProductById = async (req, res, next) => {
    try {
        console.log(req.params.id)
        let product = await Product.findOne({ where: { id_product: req.params.id } })

        res.status(200).json({ product })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengambil product" })
    }
}

const storeProduct = async (req, res, next) => {
    let t = await db.transaction()
    
    try {
        let newProduct = await Product.create({ ...req.body, id_seller: req.user.id })

        let data = []
        if (req.files) {
            data = req.files.map(file => {
                return { path: `images/product_images/${file.filename}`, id_product: newProduct.dataValues.id_product }
            })
            await ProductPict.bulkCreate(data)
        }

        await t.commit()

        return res.status(201).json({ msg: "Berhsail menambahkan data" })
    } catch (error) {
        await t.rollback()
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengambil product" })
    }
}

module.exports = { getProduct, getProductByIdSeller, getProductById, storeProduct }