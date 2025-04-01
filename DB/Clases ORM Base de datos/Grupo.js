const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");
const Usuario = require("./Usuario");
const Actividad = require("./Actividad");
const UsuarioHasGrupo = require("./UsuarioHasGrupo");
const GrupoHasActividad = require("./GrupoHasActividad");
const Ciclo = require("./Ciclo");

const Grupo = sequelize.define("Grupo", {
  id_grupo: { 
    type: DataTypes.INTEGER, 
    primaryKey: true, 
    allowNull: false, 
    autoIncrement: true 
  },
  ciclo_id_ciclo: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  nom_grupo: { 
    type: DataTypes.STRING(45), 
    allowNull: false 
  },
  curso_grupo: { 
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
  timestamps: false, // ✅ No agregará createdAt y updatedAt automáticamente
  tableName: "grupo", // ✅ Asegura que el nombre de la tabla sea exactamente "grupo"
  underscored: true,  // ✅ Mantiene el formato snake_case en la base de datos
});
Grupo.belongsToMany(Usuario, { 
  through: UsuarioHasGrupo, 
  foreignKey: 'grupo_id_grupo'
});
Grupo.belongsToMany(Actividad, {
  through: GrupoHasActividad,
  foreignKey: "grupo_id_grupo",
});
// Nueva relación: Grupo pertenece a Ciclo
Grupo.belongsTo(Ciclo, {
  foreignKey: "ciclo_id_ciclo",
  as: "ciclo",
});


module.exports = Grupo;
