const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Mensajeria = sequelize.define("Mensajeria", {
  id_mensaje: { 
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false,
  },
  Profesor_usuario_id_usuario: {
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false 
  },
  Alumno_usuario_id_usuario: {
    type: DataTypes.INTEGER, 
    primaryKey: true, 
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
  est_mensaje:{
      type: DataTypes.TINYINT, 
      allowNull: false 

  },
}, {
  timestamps: true, // Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // Convierte createdAt → created_at, updatedAt → updated_at en MySQL
});

module.exports = Mensajeria;