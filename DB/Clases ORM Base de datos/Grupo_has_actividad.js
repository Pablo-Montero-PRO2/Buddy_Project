const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Grupo = require("./Grupo");
const Actividad = require("./Actividad");

const GrupoHasActividad = sequelize.define("GrupoHasActividad", {
  grupo_id_grupo: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  actividad_id_actividad: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  fecha_actividad: { 
    type: DataTypes.DATE, 
    primaryKey: true,
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
  tableName: 'grupo_has_actividad'
});
GrupoHasActividad.belongsTo(Grupo, {
  foreignKey: 'grupo_id_grupo',
  as: 'grupo'
});
GrupoHasActividad.belongsTo(Actividad, {
  foreignKey: 'actividad_id_actividad',
  as: 'actividad'
});

module.exports = GrupoHasActividad;