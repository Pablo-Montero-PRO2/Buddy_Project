const express = require("express");
const Alumno = require("../models/Alumno");
const Profesor = require("../models/Profesor");

const router = express.Router();

// ✅ Ruta para insertar en tabla alumno
router.post("/insert-alumno", async (req, res) => {
  const { id_usuario } = req.body;

  if (!id_usuario) {
    return res.status(400).json({ error: "Falta el id_usuario" });
  }

  try {
    await Alumno.create({
      usuario_id_usuario: id_usuario
    });
    res.json({ msg: "✅ Alumno insertado correctamente" });
  } catch (error) {
    console.error("❌ Error al insertar alumno:", error);
    res.status(500).json({ error: error.message });
  }
});

// ✅ Ruta para insertar en tabla profesor
router.post("/insert-profesor", async (req, res) => {
  const { id_usuario, es_tutor } = req.body;

  if (!id_usuario || typeof es_tutor === 'undefined') {
    return res.status(400).json({ error: "Faltan campos obligatorios (id_usuario o es_tutor)" });
  }

  try {
    await Profesor.create({
      usuario_id_usuario: id_usuario,
      es_tutor: es_tutor
    });
    res.json({ msg: "✅ Profesor insertado correctamente" });
  } catch (error) {
    console.error("❌ Error al insertar profesor:", error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
