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
    product_stock: DataTypes.INTEGER,
    click_counts: {
        type: DataTypes.INTEGER,
        defaultValue: 0
    },
    product_status: {
        type: DataTypes.ENUM("aktif", "nonaktif"),
        defaultValue: "aktif"
    },
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