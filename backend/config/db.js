const {Sequelize} = require(`sequelize`)

const db = new Sequelize(process.env.DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD,{
    host: process.env.DB_HOST,
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