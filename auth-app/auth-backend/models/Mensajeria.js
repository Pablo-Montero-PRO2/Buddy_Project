const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Alumno = require("./Alumno");
const Profesor = require("./Profesor");

const Mensajeria = sequelize.define("Mensajeria", {
  id_mensaje: { 
    type: DataTypes.INTEGER,
    primaryKey: true, 
    allowNull: false,
    autoIncrement: true
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
  fecha_hora_mensaje: {
    type: DataTypes.DATE, 
    allowNull: false 
  },
  asunto_mensaje: {
    type: DataTypes.STRING(45), 
    allowNull: true // Puede ser nulo
  }, 
  desc_mensaje: {
    type: DataTypes.STRING(500),
    allowNull: false 
  },
  est_mensaje:{
      type: DataTypes.TINYINT, 
      allowNull: false 

  },
}, {
  timestamps: true,
  createdAt: 'createdAt',
  updatedAt: 'updatedAt', // Sequelize manejará createdAt y updatedAt automáticamente

});

Mensajeria.belongsTo(Alumno, {
  foreignKey: 'Alumno_usuario_id_usuario',
  targetKey: 'usuario_id_usuario'
})

Mensajeria.belongsTo(Profesor, {
  foreignKey: 'Profesor_usuario_id_usuario',
  targetKey: 'usuario_id_usuario'
})

module.exports = Mensajeria;