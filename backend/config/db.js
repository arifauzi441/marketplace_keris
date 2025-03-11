const {Sequelize} = require(`sequelize`)

const db = new Sequelize(`db_marketplace`,`root`,``,{
    host: `localhost`,
    dialect: `mysql`
})

async function connectDB() {
    try{
        await db.authenticate();
        console.log("Database Terkoneksi")
    }catch(error){
        console.log(error)
    }
}

module.exports = {db, connectDB}