const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Usuario = require("./Usuario");
const Actividad = require("./Actividad");
const Tutoria = require("./Tutoria");
const Mensajeria = require("./Mensajeria");

const Profesor = sequelize.define("Profesor", {
  usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true, 
    allowNull: false 
  },
  es_tutor: { 
    type: DataTypes.TINYINT, 
    allowNull: false,  
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
  tableName: "Profesor", // ✅ Asegura que el nombre de la tabla sea exactamente "Profesor"
  underscored: true,  // ✅ Mantiene el formato snake_case en la base de datos
});
Profesor.belongsTo(Usuario, { foreignKey: "usuario_id_usuario", as: "usuario" });

Profesor.hasMany(Actividad, { foreignKey: "Profesor_usuario_id_usuario", as: "actividadesCreadas" });

Profesor.hasMany(Tutoria, { foreignKey: "Profesor_usuario_id_usuario", as: "tutoriasDadas" });

Profesor.hasMany(Mensajeria, { foreignKey: "Profesor_usuario_id_usuario", as: "mensajesEnviados" });

module.exports = Profesor;
