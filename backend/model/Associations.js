const Seller = require(`./SellerModel`)
const Product = require(`./ProductModel`)
const ProductPict = require(`./ProductPictModel`)

Seller.hasMany(Product, { foreignKey: `id_seller`, onDelete: `SET NULL`, hooks: true })

Product.belongsTo(Seller, { foreignKey: `id_seller`, onDelete: `SET NULL`, hooks: true })

Product.hasMany(ProductPict, { foreignKey: `id_product`, onDelete: `SET NULL`, hooks: true })

ProductPict.belongsTo(Product, { foreignKey: `id_product`, onDelete: `SET NULL`, hooks: true })

module.exports = {Seller, Product, ProductPict}