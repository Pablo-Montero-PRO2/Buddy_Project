const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Usuario = sequelize.define("Usuario", {
  id_usuario: { 
    type: DataTypes.INTEGER, 
    autoIncrement: true, 
    primaryKey: true, 
    allowNull:false
  },
  est_usuario:{
    type:DataTypes.TINYINT,
    allowNull:false
  },
  nombre: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  apellidos: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  user: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  pass: { 
    type: DataTypes.STRING(256), 
    allowNull: false 
  },
  email: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  telf: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  foto: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'usuario'
});

module.exports = Usuario;