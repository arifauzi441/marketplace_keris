const Seller = require(`./SellerModel`)
const Product = require(`./ProductModel`)
const ProductPict = require(`./ProductPictModel`)
const SellerVerificationCode = require("./SellerVerificationCode")
const Admin = require("./Admin")
const AdminVerificationCode = require("./AdminVerificationCode")

Admin.hasOne(AdminVerificationCode, {foreignKey: "id_admin", onDelete: "CASCADE", hooks: true})

AdminVerificationCode.belongsTo(Admin, {foreignKey: "id_admin", onDelete: "CASCADE", hooks: true})

Seller.hasOne(SellerVerificationCode, {foreignKey: "id_seller", onDelete: "CASCADE", hooks: true})

SellerVerificationCode.belongsTo(Seller, {foreignKey: "id_seller", onDelete: "CASCADE", hooks: true})

Seller.hasMany(Product, { foreignKey: `id_seller`, onDelete: `CASCADE`, hooks: true })

Product.belongsTo(Seller, { foreignKey: `id_seller`, onDelete: `CASCADE`, hooks: true })

Product.hasMany(ProductPict, { foreignKey: `id_product`, onDelete: `CASCADE`, hooks: true })

ProductPict.belongsTo(Product, { foreignKey: `id_product`, onDelete: `CASCADE`, hooks: true })

module.exports = {Seller, Product, ProductPict, Admin, AdminVerificationCode, SellerVerificationCode}