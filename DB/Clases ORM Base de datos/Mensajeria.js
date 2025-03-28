const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Mensajeria = sequelize.define("Mensajeria", {
  id_mensaje: { 
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false,
    autoIncrement: true
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
  createdAt: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  updatedAt: {
    type: DataTypes.DATE,
    allowNull: true,
  },
}, {
  timestamps: true, // Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // Convierte createdAt → created_at, updatedAt → updated_at en MySQL
});
Mensajeria.belongsTo(Profesor, { foreignKey: "Profesor_usuario_id_usuario", as: "profesor" });
Mensajeria.belongsTo(Alumno, { foreignKey: "Alumno_usuario_id_usuario", as: "alumno" });
module.exports = Mensajeria;