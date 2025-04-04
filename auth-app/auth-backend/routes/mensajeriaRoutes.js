const express = require("express");
const router = express.Router();
const Mensajeria = require("../models/Mensajeria");
const messageController = require("../controllers/messageController");
router.post("/enviarMensaje", messageController.enviarMensaje);
router.get("/obtenerMensajes", messageController.obtenerMensajes);
router.delete("/eliminarMensaje/:id", messageController.eliminarMensaje);


// 📩 Mensajes no leídos del ALUMNO
router.get("/no-leidos/:alumnoId", async (req, res) => {
  const alumnoId = parseInt(req.params.alumnoId);

  try {
    const mensajes = await Mensajeria.findAll({
      where: {
        Alumno_usuario_id_usuario: alumnoId,
        est_mensaje: 0
      },
      order: [["createdAt", "DESC"]]
    });

    res.json({ cantidadMensajesNoLeidos: mensajes.length });
  } catch (error) {
    console.error("❌ Error al obtener mensajes no leídos del alumno:", error);
    res.status(500).json({ error: error.message });
  }
});

// 📩 Mensajes no leídos del PROFESOR
router.get("/no-leidos-profesor/:profesorId", async (req, res) => {
  const profesorId = parseInt(req.params.profesorId);

  try {
    const mensajes = await Mensajeria.findAll({
      where: {
        Profesor_usuario_id_usuario: profesorId,
        est_mensaje: 0
      },
      order: [["createdAt", "DESC"]]
    });

    res.json({ cantidadMensajesNoLeidos: mensajes.length });
  } catch (error) {
    console.error("❌ Error al obtener mensajes no leídos del profesor:", error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
