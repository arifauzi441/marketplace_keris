const {db} = require(`../config/db`)
const {DataTypes} = require(`sequelize`)
const Product = require("./ProductModel")

const ProductPict = db.define(`ProductPict`,{
    id_product_pict: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    path: DataTypes.STRING,
    id_product: {
        type: DataTypes.INTEGER,
        references:{
            model: Product,
            key: `id_product`
        },
        onUpdate: `CASCADE`,
        onDelete: `SET NULL`
    }
})

module.exports = ProductPict