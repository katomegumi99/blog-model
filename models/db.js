const mysql = require('mysql2/promise');
require('dotenv').config();
// 创建连接池
const pool =  mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    connectionLimit: 10 // 连接池中连接的数量
});

async function query(sql, values) {
    try {
        const [rows, fields] = await pool.query(sql, values);
        return rows;
    } catch (error) {
        return console.error(error);
    }
}

module.exports = {
    query
};