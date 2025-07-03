const { DataTypes } = require(`sequelize`)
const { db } = require(`../config/db`)

const BuyerToken = db.define(`buyertoken`, {
    id_buyer_token: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    fcm_token: DataTypes.STRING,
})

module.exports = BuyerToken;