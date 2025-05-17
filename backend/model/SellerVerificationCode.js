const { DataTypes } = require("sequelize")
const {db} = require("../config/db")
const Seller = require("./SellerModel")

const SellerVerificationCode = db.define("SellerVerificationCode", {
    id_verification_code : {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    verification_code: DataTypes.INTEGER,
    expired_at: DataTypes.DATE,
    id_seller: {
        type: DataTypes.INTEGER,
        references: {
            model: Seller,
            key: "id_seller"
        },
        onDelete: "CASCADE",
        onUpdate: "CASCADE"
    }
})

module.exports = SellerVerificationCode