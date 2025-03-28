const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Actividad = sequelize.define("Actividad", {
  id_actividad: { 
    type: DataTypes.INTEGER, 
    primaryKey: true 
  },
  Profesor_usuario_id_usuario: { 
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false 
  },
  fecha_publicacion: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  tipo_act: { 
    type: DataTypes.STRING(50), 
    allowNull: false 
  },
  desc_act: { 
    type: DataTypes.STRING(500), 
    allowNull: false 
  },
  est_act_prof: { 
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
 
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'actividad'
  
});
Actividad.belongsTo(Profesor, {
  foreignKey: "Profesor_usuario_id_usuario",
  as: "profesor",
});
Actividad.belongsToMany(Alumno, {
  through: AlumnoHasActividad,
  foreignKey: "actividad_id_actividad",
});
Actividad.belongsToMany(Grupo, {
  through: GrupoHasActividad,
  foreignKey: "actividad_id_actividad",
});
Actividad.hasMany(RecursoActividad, {
  foreignKey: "actividad_id_actividad",
  as: "recursos",
});
module.exports = Actividad;