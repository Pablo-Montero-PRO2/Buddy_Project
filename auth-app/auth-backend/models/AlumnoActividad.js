const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Actividad = require("./Actividad"); // 👈 Importamos el modelo relacionado

// Definición del modelo que representa la tabla alumno_has_actividad
const AlumnoActividad = sequelize.define("alumno_has_actividad", {
  Alumno_usuario_id_usuario: {
    type: DataTypes.INTEGER,
    primaryKey: true
  },
  actividad_id_actividad: {
    type: DataTypes.INTEGER,
    primaryKey: true
  },
  actividad_Profesor_usuario_id_usuario: {
    type: DataTypes.INTEGER,
    primaryKey: true
  },
  est_act_alu: {
    type: DataTypes.STRING // ENUM en MySQL, pero STRING aquí está bien
  }
}, {
  tableName: "alumno_has_actividad",
  timestamps: false
});

// 👇 Asociación con la tabla actividad
AlumnoActividad.belongsTo(Actividad, {
  foreignKey: 'actividad_id_actividad',
  targetKey: 'id_actividad',
  as: 'actividad'
});

module.exports = AlumnoActividad;

