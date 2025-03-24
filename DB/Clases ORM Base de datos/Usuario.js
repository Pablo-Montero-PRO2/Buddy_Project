const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Usuario = sequelize.define("Usuario", {
  id_usuario: { 
    type: DataTypes.INTEGER, 
    autoIncrement: true, 
    primaryKey: true 
  },
  nombre: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  ape1: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  ape2: { 
    type: DataTypes.STRING(45), 
    allowNull: true 
  },
  user: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  pass: { 
    type: DataTypes.STRING(45), 
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
    allowNull: true 
  },
  fecha_insercion: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  fecha_modificacion: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  fecha_borrado: { 
    type: DataTypes.DATE, 
    allowNull: true 
  }
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'usuario'
});

module.exports = Usuario;