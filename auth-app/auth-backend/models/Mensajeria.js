const { DataTypes, Sequelize } = require("sequelize");
const { sequelize } = require("../config/db");
const Alumno = require("./Alumno")
const Profesor = require("./Profesor")

const Mensajeria = sequelize.define("Mensajeria", {
  id_mensaje: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
  profesor_usuario_id_usuario: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
  alumno_usuario_id_usuario: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
  fecha_hora_mensaje: { type: DataTypes.timestamps, allowNull: false },
  asunto_mensaje: { type: DataTypes.TEXT, allowNull: true },
  desc_mensaje: { type: DataTypes.TEXT, allowNull: false },
  mensaje_leido: {type: DataTypes.BOOLEAN, allowNull: false},
  fecha_insercion: {type: Sequelize.DATE, field: 'created_at', allowNull: false},
  fecha_modificacion: {type: Sequelize.DATE, field: 'updated_at', allowNull: false },
  fecha_borrado: {type: Sequelize.DATE, field: 'deleted_at', allowNull: true },
  },
  {
    timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
    underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
});

Mensajeria.belongsTo(Alumno, {targetKey: "usuario_id_usuario"})
Alumno.hasMany(Mensajeria, {foreignKey: "alumno_usuario_id_usuario"})
Mensajeria.belongsTo(Profesor, {targetKey: "usuario_id_usuario"})
Profesor.hasMany(Mensajeria, {foreignKey: "profesor_usuario_id_usuario"})

module.exports = Mensajeria;
