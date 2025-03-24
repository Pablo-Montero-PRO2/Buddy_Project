const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Ciclo = sequelize.define("Ciclo", {
  id_ciclo: { 
    type: DataTypes.INTEGER, 
    primaryKey: true, 
    autoIncrement: true, 
    allowNull: false 
  },
  nom_ciclo: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  grado_ciclo: { 
    type: DataTypes.STRING(45), 
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
  timestamps: false, // ✅ Evita que Sequelize agregue createdAt y updatedAt automáticamente
  tableName: "ciclo", // ✅ Asegura que el nombre de la tabla sea "ciclo"
  underscored: true,  // ✅ Mantiene el formato snake_case en la base de datos
});

module.exports = Ciclo;
