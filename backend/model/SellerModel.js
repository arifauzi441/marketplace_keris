const {DataTypes} = require(`sequelize`)
const {db} = require(`../config/db`)

const Seller = db.define(`seller`,{
    id_seller:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    username: DataTypes.STRING,
    password: DataTypes.STRING,
    seller_name: DataTypes.STRING,
    seller_address: DataTypes.STRING,
    seller_phone: DataTypes.STRING,
    seller_photo: DataTypes.STRING,
    status: DataTypes.ENUM(`diterima`,`belum diterima`),
})

module.exports = Seller;