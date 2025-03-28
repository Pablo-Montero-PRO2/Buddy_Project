const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const UsuarioHasGrupo = sequelize.define("UsuarioHasGrupo", {
  usuario_id_usuario: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  grupo_id_grupo: { 
    type: DataTypes.INTEGER, 
    primaryKey: true,
    allowNull: false 
  },
  vigencia_inicio: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  vigencia_fin: { 
    type: DataTypes.DATE, 
    allowNull: true 
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
  tableName: 'usuario_has_grupo'
});
UsuarioHasGrupo.belongsTo(Usuario, { foreignKey: "usuario_id_usuario" });
UsuarioHasGrupo.belongsTo(Grupo, { foreignKey: "grupo_id_grupo" });
module.exports = UsuarioHasGrupo;