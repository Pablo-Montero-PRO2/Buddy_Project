const { DataTypes, Sequelize } = require("sequelize");
const { sequelize } = require("../config/db");

const Alumno = sequelize.define("Alumno", {
  usuario_id_usuario: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true,  },
  fecha_insercion: {type: Sequelize.DATE, field: 'created_at', allowNull: false},
  fecha_modificacion: {type: Sequelize.DATE, field: 'updated_at', allowNull: false },
  fecha_borrado: {type: Sequelize.DATE, field: 'deleted_at', allowNull: true },
},
  {
    timestamps: true, // ✅ Sequelize manejará createdAt y updatedAt automáticamente
    underscored: true, // ✅ Convierte createdAt → created_at, updatedAt → updated_at en MySQL
  });

module.exports = Alumno;
