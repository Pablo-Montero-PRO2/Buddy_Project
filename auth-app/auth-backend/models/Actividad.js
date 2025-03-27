const { DataTypes } = require("sequelize");
const { sequelize } = require("../config/db");

const Actividad = sequelize.define("actividad", {
  id_actividad: {
    type: DataTypes.INTEGER,
    primaryKey: true
  },
  Profesor_usuario_id_usuario: {
    type: DataTypes.INTEGER
  },
  fecha_publicacion: {
    type: DataTypes.DATE
  },
  tipo_act: {
    type: DataTypes.ENUM("Mentoring", "Emprendimiento", "Competencias Digitales")
  },
  desc_act: {
    type: DataTypes.STRING
  },
  est_act_prof: {
    type: DataTypes.ENUM("No publicado", "Publicado")
  }
}, {
  tableName: "actividad",
  timestamps: false
});

module.exports = Actividad;
