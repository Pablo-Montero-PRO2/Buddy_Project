const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Alumno = require("./Alumno");
const Profesor = require("./Profesor");

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
    type: DataTypes.STRING(45), 
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
  
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'tutoria'
});

Tutoria.belongsTo(Alumno, {
  foreignKey: 'Alumno_usuario_id_usuario',
  targetKey: 'usuario_id_usuario'
})

Tutoria.belongsTo(Profesor, {
  foreignKey: 'Profesor_usuario_id_usuario',
  targetKey: 'usuario_id_usuario'
})

module.exports = Tutoria;