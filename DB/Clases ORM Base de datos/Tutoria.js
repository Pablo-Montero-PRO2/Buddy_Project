const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Tutoria = sequelize.define("Tutoria", {
  id_tutoria: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    autoIncrement:true,
    allowNull: false 
  },
  Profesor_usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  Alumno_usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  fecha_tutoria:{
    type:DataTypes.DATE,
    allowNull: false 
  },
  hora_inicio: { 
    type: DataTypes.TIME, 
    allowNull: false 
  },
  hora_fin: { 
    type: DataTypes.TIME, 
    allowNull: false 
  },
  tema_tutoria: { 
    type: DataTypes.STRING(256), 
    allowNull: false 
  },
  observaciones: { 
    type: DataTypes.STRING(500), 
    allowNull: true //Puede ser nulo
  },
  lug_tutoria: { 
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
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'tutoria'
});
Tutoria.belongsTo(Profesor, {
  foreignKey: "Profesor_usuario_id_usuario",
  as: "profesor",
});
Tutoria.belongsTo(Alumno, {
  foreignKey: "Alumno_usuario_id_usuario",
  as: "alumno",
});


module.exports = Tutoria;