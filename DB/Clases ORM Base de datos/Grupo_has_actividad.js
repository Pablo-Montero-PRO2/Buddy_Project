const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

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
  
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'grupo_has_actividad'
});

module.exports = GrupoHasActividad;