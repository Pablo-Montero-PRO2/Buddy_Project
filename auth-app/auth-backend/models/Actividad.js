const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Actividad = sequelize.define(
  "Actividad",
  {
    id_actividad: { 
      type: DataTypes.INTEGER, 
      primaryKey: true,
      autoIncrement: true 
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
  
    }
  },
  {
    timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
    underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
    tableName: 'actividad'
  }
);



module.exports = Actividad;