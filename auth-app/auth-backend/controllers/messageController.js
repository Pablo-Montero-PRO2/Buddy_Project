const { sequelize } = require("../config/db");
const Mensajeria = require("../models/Mensajeria");
const Usuario = require("../models/Usuario");

exports.enviarMensaje = async (req, res) => {
  try {
      console.log("1");

      let { profesorId, alumnoId, fechaHora, asunto, contenido, email, est_mesj } = req.body;

      // 🔹 Obtener el ID del alumno a partir del email
      let [resultado] = await sequelize.query(
          "SELECT id_usuario FROM usuario WHERE email = :email",
          {
              replacements: { email },
              type: sequelize.QueryTypes.SELECT,
          }
      );

      if (!resultado || !resultado.id_usuario) {
          return res.status(400).json({ msg: "No se encontró un usuario con ese email" });
      }

      alumnoId = resultado.id_usuario; // Asignar el ID obtenido

      console.log("Alumno ID obtenido:", alumnoId);

      if (!profesorId || !alumnoId || !contenido) {
          return res.status(400).json({ msg: "Todos los campos son obligatorios" });
      }

      // 🔹 Guardar el mensaje en la base de datos
      const nuevoMensaje = await Mensajeria.create({
        Profesor_usuario_id_usuario: req.body.profesorId,  // 🔹 Convertimos los nombres
        Alumno_usuario_id_usuario: req.body.alumnoId,
        fecha_hora_mensaje: req.body.fechaHora, // 🔹 Agregamos la fecha automáticamente
        desc_mensaje: req.body.contenido,
        asunto_mensaje: req.body.asunto || null, // Si el asunto no es obligatorio
        est_mensaje: req.body.est_mesj || 0 // 🔹 Aseguramos que no sea undefined
      });

      res.json({ msg: "Mensaje enviado correctamente", mensaje: nuevoMensaje });
  } catch (err) {
      console.error("❌ Error en enviarMensaje:", err);
      res.status(500).json({ error: err.message });
  }
};


exports.obtenerMensajes = async (req, res) => {
  try {
    const mensajes = await Mensajeria.findAll({
      include: [
        { model: Usuario, as: "Profesor", attributes: ["id", "name", "email"] },
        { model: Usuario, as: "Alumno", attributes: ["id", "name", "email"] },
      ],
      order: [["fecha_hora_mensaje", "DESC"]],
    });

    res.json(mensajes);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.eliminarMensaje = async (req, res) => {
  try {
    const { id } = req.params;
    const mensaje = await Mensajeria.findByPk(id);

    if (!mensaje) {
      return res.status(404).json({ msg: "Mensaje no encontrado" });
    }

    await mensaje.destroy();
    res.json({ msg: "Mensaje eliminado correctamente" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};