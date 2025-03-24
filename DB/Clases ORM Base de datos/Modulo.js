const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Modulo = sequelize.define("Modulo", {
  id_modulo: { 
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true 
  },
  ciclo_id_ciclo: {
    type: DataTypes.INTEGER,
    primaryKey: true, // Clave primaria adicional
    allowNull: false 
  },
  nom_modulo: {
    type: DataTypes.STRING(45),
    allowNull: false 
  },
  fecha_insercion: {
    type: DataTypes.DATE,
    allowNull: false
  },
  fecha_modificacion: {
    type: DataTypes.DATE,
    allowNull: true 
  },
  fecha_borrado: {
    type: DataTypes.DATE,
    allowNull: true
  },
}, {
  timestamps: true, // Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // Convierte createdAt → created_at, updatedAt → updated_at en MySQL
});

module.exports = Modulo;