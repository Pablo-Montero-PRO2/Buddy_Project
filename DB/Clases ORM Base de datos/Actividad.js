const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Actividad = sequelize.define("Actividad", {
  id_actividad: { 
    type: DataTypes.INTEGER, 
    autoIncrement: true, 
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
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  desc_act: { 
    type: DataTypes.STRING(800), 
    allowNull: false 
  },
  est_act_prof: { 
    type: DataTypes.TINYINT, 
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
  tableName: 'actividad'
  
});

module.exports = Actividad;