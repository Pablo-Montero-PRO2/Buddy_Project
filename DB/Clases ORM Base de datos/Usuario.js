const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Alumno = require("./Alumno");
const Profesor = require("./Profesor");
const Grupo = require("./Grupo");
const UsuarioHasGrupo = require("./Usuario_has_grupo");
const Mensajeria = require("./Mensajeria");
const Tutoria = require("./Tutoria");

const Usuario = sequelize.define("Usuario", {
  id_usuario: { 
    type: DataTypes.INTEGER, 
    autoIncrement: true, 
    primaryKey: true, 
    allowNull:false
  },
  est_usuario:{
    type:DataTypes.TINYINT,
    allowNull:false
  },
  nombre: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  ape1: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  ape2: { 
    type: DataTypes.STRING(45), 
    allowNull: true  //Puede ser nulo
  },
  user: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  pass: { 
    type: DataTypes.STRING(256), 
    allowNull: false 
  },
  email: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  telf: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  foto: { 
    type: DataTypes.STRING(500), 
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
  tableName: 'usuario'
});

Usuario.hasOne(Alumno, { foreignKey: "usuario_id_usuario", as: "alumno" });
Usuario.hasOne(Profesor, { foreignKey: "usuario_id_usuario", as: "profesor" });

Usuario.belongsToMany(Grupo, {
  through: UsuarioHasGrupo,
  foreignKey: "usuario_id_usuario",
});

Usuario.hasMany(Mensajeria, { foreignKey: "Alumno_usuario_id_usuario", as: "mensajesRecibidos" });
Usuario.hasMany(Mensajeria, { foreignKey: "Profesor_usuario_id_usuario", as: "mensajesEnviados" });
Usuario.hasMany(Tutoria, { foreignKey: "Alumno_usuario_id_usuario", as: "tutoriasRecibidas" });
Usuario.hasMany(Tutoria, { foreignKey: "Profesor_usuario_id_usuario", as: "tutoriasImpartidas" });
;

module.exports = Usuario;