const {DataTypes} = require(`sequelize`)
const {db} = require(`../config/db`)

const Admin = db.define(`admin`,{
    id_admin:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    email: DataTypes.STRING,
    password: DataTypes.STRING,
    admin_name: DataTypes.STRING,
    admin_address: DataTypes.STRING,
    admin_phone: DataTypes.STRING,
    admin_photo: DataTypes.STRING,
    status: DataTypes.ENUM(`diterima`,`belum diterima`),
})

module.exports = Admin;