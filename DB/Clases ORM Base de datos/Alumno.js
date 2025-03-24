const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Alumno = sequelize.define("Alumno", {
  usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true, 
    allowNull: false 
  },
  fecha_insercion: { 
    type: DataTypes.DATE, 
    allowNull: false, 
    defaultValue: DataTypes.NOW 
  },
  fecha_modificacion: { 
    type: DataTypes.DATE, 
    allowNull: true 
  },
  fecha_borrado: { 
    type: DataTypes.DATE, 
    allowNull: true 
  },
}, 
{
  timestamps: false, // ✅ No agregará createdAt y updatedAt automáticamente
  tableName: "Alumno", // ✅ Asegura que el nombre de la tabla sea exactamente "Alumno"
  underscored: true,  // ✅ Convierte nombres de columnas a snake_case en la base de datos
});

module.exports = Alumno;
