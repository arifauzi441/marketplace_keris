const { Sequelize, Op } = require("sequelize")
const Product = require(`../model/ProductModel`)
const ProductPict = require("../model/ProductPictModel")
const fs = require(`fs`) 
const path = require(`path`) 
const { db } = require("../config/db")

const getProduct = async (req, res, next) => {
    try {
        let product = await Product.findAll({include: {model: ProductPict}})
        res.status(200).json({ product })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengakses product" });
    }
}

const getActiveProduct = async (req, res, next) => {
    try {
        let product = await Product.findAll({
            where: {product_status: 'aktif'},
            include: {model: ProductPict}
        })
        res.status(200).json({ product })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengakses product" });
    }
}

const getProductByIdSeller = async (req, res, next) => {
    try {
        let product = await Product.findAll({ where: { id_seller: req.params.id }, include: {model: ProductPict} })
        res.status(200).json({ product });
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengakses product" })
    }
}

const getProductById = async (req, res, next) => {
    try {
        console.log(req.params.id)
        let product = await Product.findOne({ 
            where: { id_product: req.params.id }, 
            include: {model: ProductPict} 
        })

        res.status(200).json({ product })
    } catch (error) {
        console.log(error)
        res.status(401).json({ msg: "Tidak bisa mengambil product" })
    }
}

const getPopularProductByCounts = async (req, res, next) => {
    try {
        console.log(req.params.id)
        let product = await Product.findAll({
            where: {product_status: "aktif"} ,
            order: [['click_counts','DESC']], 
            include: {model:ProductPict} 
        })

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

        return res.status(201).json({ msg: "Berhasil menambahkan data" })
    } catch (error) {
        await t.rollback()
        console.log(error)
        res.status(401).json({ msg: "Gagal menambahkan product" })
    }
}

const updateProduct = async (req, res, next) => {
    let t = await db.transaction()
    try {
        let data = await Product.findOne({
            where: { id_product: req.params.id }, 
            include: {model: ProductPict}
        })
        
        let oldPictId = []
        if(data.ProductPicts.length > 0){
            oldPictId = data.ProductPicts.map(pict => pict.id_product_pict)
            data.ProductPicts.forEach(pict => {
                let oldPath = path.join(__dirname, '../public', pict.path)
                fs.unlinkSync(oldPath)
            })
        }
        await ProductPict.destroy({
            where: {
                id_product_pict:{
                    [Op.in] : oldPictId
                }
            }
        })

        console.log(req.body)
        
        await Product.update(
            {...req.body},
            {where: {id_product: req.params.id}}
        )
        if(req.files) {
            let pict = req.files.map(file => {
                return {path: `images/product_images/${file.filename}`, id_product: req.params.id}
            })
            await ProductPict.bulkCreate(pict)
        }
        
        await t.commit()

        return res.status(200).json({msg: "Berhasil memperbarui data"})
    } catch (error) {
        await t.rollback()
        console.log(error)
        res.status(401).json({msg: "Gagal memperbarui data"})
    }
} 

const deleteProduct = async (req, res, next) => {
    try {
        let datas = await ProductPict.findAll({where: {id_product: req.params.id}})

        if(datas.length > 0) {
            datas.forEach(data => {
                let dataPath = path.join(__dirname, `../public`, data.path)
                fs.unlinkSync(dataPath)
            })
        }

        await Product.destroy({where: {id_product: req.params.id}})
        return res.status(200).json({msg: "Berhasil menghapus data"})
    } catch (error) {
        console.log(error)
        return res.status(401).json({msg: "Gagal menghapus data"})
    }
}

const changeStatus = async (req, res, next) => {
    try {
        let data = await Product.findOne({where: {id_product: req.params.id}})
        let product_status = (data.product_status == "aktif") ? "nonaktif" : "aktif"
        
        await Product.update({product_status},{where: {id_product: req.params.id}})

        return res.status(200).json({msg: "Berhasil mengubah status data"})
    } catch (error) {
        console.log(error)
        return res.status(401).json({msg: "Gagal mengubah status data"})
    }
}

const incrementCounts = async (req, res, next) => {
    try {
        await Product.increment('click_counts', {by: 1, where: {id_product: req.params.id}})
        res.status(200).json({msg: "Berhasil menambahkan counts"})
    } catch (error) {
        console.log(error)
        res.status(401).json({msg: "Error pada fungsi, " + error})
    }
} 

module.exports = { getProduct, getProductByIdSeller, getProductById, storeProduct, 
    deleteProduct, updateProduct, changeStatus, incrementCounts, getPopularProductByCounts, getActiveProduct }