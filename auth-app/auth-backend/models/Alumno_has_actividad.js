const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Actividad = require("./Actividad"); // 👈 Importamos el modelo relacionado
const Alumno = require("./Alumno");

const AlumnoHasActividad = sequelize.define("AlumnoHasActividad", {
  Alumno_usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  actividad_id_actividad: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  actividad_Profesor_usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  est_act_alu: { 
    type: DataTypes.STRING(50), 
    allowNull: false 
  },
 
},
{
  timestamps: false, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'Alumno_has_actividad'
});

AlumnoHasActividad.belongsTo(Actividad, {
  foreignKey: 'actividad_id_actividad',
  targetKey: 'id_actividad',
  as: 'actividad'
});

AlumnoHasActividad.belongsTo(Actividad, {
  foreignKey: 'actividad_Profesor_usuario_id_usuario',
  targetKey: 'Profesor_usuario_id_usuario'
})

AlumnoHasActividad.belongsTo(Alumno, {
  foreignKey: 'Alumno_usuario_id_usuario',
  targetKey: 'usuario_id_usuario'
})

module.exports = AlumnoHasActividad;