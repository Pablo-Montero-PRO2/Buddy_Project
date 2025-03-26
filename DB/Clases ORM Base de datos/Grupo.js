const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Grupo = sequelize.define("Grupo", {
  id_grupo: { 
    type: DataTypes.INTEGER, 
    primaryKey: true, 
    allowNull: false, 
    autoIncrement: true 
  },
  ciclo_id_ciclo1: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  nom_grupo: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  curso_grupo: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  
}, 
{
  timestamps: false, // ✅ No agregará createdAt y updatedAt automáticamente
  tableName: "grupo", // ✅ Asegura que el nombre de la tabla sea exactamente "grupo"
  underscored: true,  // ✅ Mantiene el formato snake_case en la base de datos
});

module.exports = Grupo;
