const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Mensajeria = sequelize.define("Mensajeria", {
  id_mensaje: { 
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true 
  },
  Profesor_usuario_id_usuario: {
    type: DataTypes.INTEGER,
    primaryKey: true, // Clave primaria adicional
    allowNull: false 
  },
  Alumno_usuario_id_usuario: {
    type: DataTypes.INTEGER, 
    primaryKey: true, // Clave primaria adicional
    allowNull: false 
  },
  fecha_hora_mensaje: {
    type: DataTypes.DATE, 
    allowNull: false 
  },
  asunto_mensaje: {
    type: DataTypes.STRING(45), 
    allowNull: true // Puede ser nulo
  }, 
  desc_mensaje: {
    type: DataTypes.STRING(500),
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

module.exports = Mensajeria;