const { Sequelize } = require("sequelize");

// 📌 Conexión a MySQL usando Sequelize
const sequelize = new Sequelize(
  process.env.MYSQL_DATABASE,
  process.env.MYSQL_USER,
  process.env.MYSQL_PASSWORD,  {
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT || 3307, // Puerto de MySQL (por defecto 3306)
    dialect: "mysql",
    logging: true, // 🔹 Ocultar logs SQL en consola
  });

// 📌 Función para probar conexión
const connectDB = async () => {
  try {
    await sequelize.authenticate();
    console.log("✅ Conectado a MySQL");
  } catch (error) {
    console.error("❌ Error en MySQL:", error);
    process.exit(1);
  }
};

module.exports = { sequelize, connectDB };
