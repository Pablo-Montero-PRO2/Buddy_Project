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
  
}, {
  timestamps: true, // Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // Convierte createdAt → created_at, updatedAt → updated_at en MySQL
});

module.exports = Modulo;