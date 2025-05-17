const fs = require('fs');
const path = require('path');
const {db, connectDB} = require('../config/db');
const mysql = require('mysql2/promise')
const {Product, ProductPict, Admin, Seller, AdminVerificationCode, SellerVerificationCode} = require("../model/Associations")

async function runSqlFile() {
  const filePath = path.join(__dirname, 'db_marketplace.sql');
  const sql = fs.readFileSync(filePath, 'utf8');

  // Jalankan query SQL langsung ke database
  try {
    const connection = await mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: '',
      database: 'db_marketplace', 
      multipleStatements: true, 
    });

    await connectDB()
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
