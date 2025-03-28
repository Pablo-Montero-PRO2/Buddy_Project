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
  timestamps: false, // ✅ Evita que Sequelize agregue createdAt y updatedAt automáticamente
  tableName: "ciclo", // ✅ Asegura que el nombre de la tabla sea "ciclo"
  underscored: true,  // ✅ Mantiene el formato snake_case en la base de datos
});
Ciclo.hasMany(Modulo, {
  foreignKey: 'ciclo_id_ciclo',
  as: 'modulos'
});
Ciclo.hasMany(Grupo, {
  foreignKey: 'ciclo_id_ciclo',
  as: 'grupos'
});

module.exports = Ciclo;
