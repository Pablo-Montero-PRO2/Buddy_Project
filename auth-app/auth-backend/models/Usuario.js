const { DataTypes } = require("sequelize"); // 👈 IMPORTA DataTypes
const { sequelize } = require("../config/db"); // 👈 IMPORTA sequelize desde tu config

const Usuario = sequelize.define("Usuario", {
  id_usuario: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
    allowNull: false,
    field: "id_usuario"
  },
  est_usuario: {
    type: DataTypes.TINYINT,
    allowNull: false,
    field: "est_usuario"
  },
  nombre: {
    type: DataTypes.STRING(45),
    allowNull: false,
    field: "nombre"
  },
  apellidos: {
    type: DataTypes.STRING(45),
    allowNull: false,
    field: "apellidos"
  },
  user: {
    type: DataTypes.STRING(45),
    allowNull: false,
    field: "user"
  },
  pass: {
    type: DataTypes.STRING(256),
    allowNull: false,
    field: "pass"
  },
  email: {
    type: DataTypes.STRING(45),
    allowNull: false,
    field: "email"
  },
  telf: {
    type: DataTypes.STRING(45),
    allowNull: false,
    field: "telf"
  },
  foto: {
    type: DataTypes.STRING(45),
    allowNull: false,
    field: "foto"
  },
  createdAt: {
    type: DataTypes.DATE,
    allowNull: false,
    field: "createdAt"
  },
  updatedAt: {
    type: DataTypes.DATE,
    allowNull: false,
    field: "updatedAt"
  }
}, {
  timestamps: true,
  underscored: true,
  tableName: "usuario"
});

module.exports = Usuario; // 👈 No olvides exportarlo
