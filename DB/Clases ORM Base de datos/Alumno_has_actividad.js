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
 
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'Alumno_has_actividad'
});

module.exports = AlumnoHasActividad;