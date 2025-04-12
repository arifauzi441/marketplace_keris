const {db} =require(`../config/db`)
const {DataTypes} = require(`sequelize`)
const Seller = require("./SellerModel")


const Product = db.define(`Product`,{
    id_product: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    product_name: DataTypes.STRING,
    product_price: DataTypes.INTEGER,
    product_description: DataTypes.TEXT,
    id_seller: {
        type: DataTypes.INTEGER,
        references: {
            model: Seller,
            key: `id_seller`
        },
        onUpdate: `CASCADE`,
        onDelete: `CASCADE`
    }
})

module.exports = Product