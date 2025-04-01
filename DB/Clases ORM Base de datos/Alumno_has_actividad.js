const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

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
  createdAt: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  updatedAt: {
    type: DataTypes.DATE,
    allowNull: true,
  },
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'Alumno_has_actividad'
});
AlumnoHasActividad.belongsTo(Alumno, { foreignKey: "Alumno_usuario_id_usuario" });
AlumnoHasActividad.belongsTo(Actividad, { foreignKey: "actividad_id_actividad" });
AlumnoHasActividad.belongsTo(Profesor, { foreignKey: "actividad_Profesor_usuario_id_usuario" });
module.exports = AlumnoHasActividad;