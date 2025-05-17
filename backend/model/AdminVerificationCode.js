const { DataTypes } = require("sequelize")
const {db} = require("../config/db")
const Admin = require("./Admin")

const AdminVerificationCode = db.define("AdminVerificationCode", {
    id_verification_code : {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    verification_code: DataTypes.INTEGER,
    expired_at: DataTypes.DATE,
    id_admin: {
        type: DataTypes.INTEGER,
        references: {
            model: Admin,
            key: "id_admin"
        },
        onDelete: "CASCADE",
        onUpdate: "CASCADE"
    }
})

module.exports = AdminVerificationCode