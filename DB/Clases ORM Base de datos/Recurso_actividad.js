const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const RecursoActividad = sequelize.define("RecursoActividad", {
  id_recurso: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    autoIncrement: true,
    allowNull: false 
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
  fecha_insercion: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  fecha_modificacion: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  fecha_borrado: { 
    type: DataTypes.DATE, 
    allowNull: true 
  }
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'recurso_actividad'
});

module.exports = RecursoActividad;