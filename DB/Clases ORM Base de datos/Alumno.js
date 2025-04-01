const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Usuario = require("./Usuario");
const AlumnoHasActividad = require("./AlumnoHasActividad");
const Tutoria = require("./Tutoria");
const Mensajeria = require("./Mensajeria");
const Actividad = require("./Actividad");


const Alumno = sequelize.define("Alumno", {
  usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true, 
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
  timestamps: false, // ✅ No agregará createdAt y updatedAt automáticamente
  tableName: "Alumno", // ✅ Asegura que el nombre de la tabla sea exactamente "Alumno"
  underscored: true,  // ✅ Convierte nombres de columnas a snake_case en la base de datos
});
Alumno.belongsTo(Usuario, { foreignKey: "usuario_id_usuario", as: "usuario" });

Alumno.belongsToMany(Actividad, { 
  through: AlumnoHasActividad, 
  foreignKey: 'Alumno_usuario_id_usuario'
});
Alumno.hasMany(Tutoria, { foreignKey: "Alumno_usuario_id_usuario", as: "tutoriasRecibidas" });

Alumno.hasMany(Mensajeria, { foreignKey: "Alumno_usuario_id_usuario", as: "mensajesRecibidos" });

module.exports = Alumno;
