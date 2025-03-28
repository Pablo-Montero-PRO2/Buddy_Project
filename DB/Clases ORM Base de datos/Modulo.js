const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Modulo = sequelize.define("Modulo", {
  id_modulo: { 
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false
  },
  ciclo_id_ciclo: {
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false 
  },
  nom_modulo: {
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
}, {
  timestamps: true, // Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // Convierte createdAt → created_at, updatedAt → updated_at en MySQL
});

Modulo.belongsTo(Ciclo, { 
  foreignKey: "ciclo_id_ciclo", 
  as: "ciclo" 
});
module.exports = Modulo;