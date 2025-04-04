// models/User.js
const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Alumno = require("./Alumno");
const Profesor = require("./Profesor");

const User = sequelize.define("User", {
  id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
  name: { type: DataTypes.STRING, allowNull: false },
  email: { type: DataTypes.STRING, unique: true, allowNull: false },
  password_hash: { type: DataTypes.STRING, allowNull: false },
},
{
  timestamps: false,
  underscored: true, 
});

User.hasOne(Alumno, { foreignKey: "usuario_id_usuario" });
Alumno.belongsTo(User, { targetKey: "id" });

User.hasOne(Profesor, { foreignKey: "usuario_id_usuario" });
Profesor.belongsTo(User, { targetKey: "id" });

module.exports = User;  // Exportamos el modelo 'User'
