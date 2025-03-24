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
  fecha_insercion: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  fecha_modificacion: { 
    type: DataTypes.DATE, 
    allowNull: false 
  },
  fecha_borrado: { 
    type: DataTypes.DATE, 
    allowNull: true 
  }
},
{
  timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
  underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  tableName: 'usuario_has_grupo'
});

module.exports = UsuarioHasGrupo;