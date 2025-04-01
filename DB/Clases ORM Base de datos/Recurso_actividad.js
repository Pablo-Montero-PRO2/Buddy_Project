const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Actividad = require("./Actividad");

const RecursoActividad = sequelize.define("RecursoActividad", {
  id_recurso: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false,
    autoIncrement: true 
  },
  actividad_id_actividad: { 
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false 
  },
  desc_recurso: { 
    type: DataTypes.STRING(500), 
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
  tableName: 'recurso_actividad'
});
RecursoActividad.belongsTo(Actividad, {
  foreignKey: 'actividad_id_actividad',
  as: 'actividad'
});

module.exports = RecursoActividad;