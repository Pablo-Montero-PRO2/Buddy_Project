const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Profesor = sequelize.define("Profesor", {
  usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true, 
    allowNull: false 
  },
  es_tutor: { 
    type: DataTypes.TINYINT, 
    allowNull: false,  
  },
  
}, 
{
  timestamps: false, // ✅ No agregará createdAt y updatedAt automáticamente
  tableName: "Profesor", // ✅ Asegura que el nombre de la tabla sea exactamente "Profesor"
  underscored: true,  // ✅ Mantiene el formato snake_case en la base de datos
});

module.exports = Profesor;
