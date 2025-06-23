const fs = require('fs');
const path = require('path');
const {db, connectDB} = require('../config/db');
const mysql = require('mysql2/promise')
require(`dotenv`).config()
const {Product, ProductPict, Admin, Seller, AdminVerificationCode, SellerVerificationCode} = require("../model/Associations")

async function runSqlFile() {
  const filePath = path.join(__dirname, 'db_marketplace.sql');
  const sql = fs.readFileSync(filePath, 'utf8');
// 
  try {
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USERNAME,
      password: process.env.DB_PASSWORD,
      database: process.env.DATABASE, 
      multipleStatements: true, 
    });
    
    // await db.sync({force: true})
    await connection.query('SET FOREIGN_KEY_CHECKS = 0');
    await connection.query('DROP TABLE IF EXISTS admins, sellers, products, productpicts, sellerVerificationcodes, adminVerificationcodes');
    await connection.query(sql);
    console.log("SQL file executed successfully.");
    await connection.end()
  } catch (error) {
    console.error("Failed to run SQL file:", error);
  }
}

runSqlFile()
