const express = require("express");
const router = express.Router();
const { sequelize } = require("../config/db");

// 🔹 CREAR TUTORÍA
router.post("/crear", async (req, res) => {
  try {
    const {
      profesorId,
      alumnoId,
      fecha,
      horaInicio,
      horaFin,
      tema,
      observaciones,
      lugar
    } = req.body;

    const [result] = await sequelize.query(
      `INSERT INTO tutoria 
        (Profesor_usuario_id_usuario, Alumno_usuario_id_usuario, fecha_tutoria, hora_inicio, hora_fin, tema_tutoria, observaciones, lug_tutoria)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      {
        replacements: [profesorId, alumnoId, fecha, horaInicio, horaFin, tema, observaciones, lugar]
      }
    );

    res.json({ mensaje: "✅ Tutoría creada correctamente", result });
  } catch (error) {
    console.error("❌ Error al crear tutoría:", error);
    res.status(500).json({ error: "Error al crear tutoría" });
  }
});

// 🔹 OBTENER TUTORÍAS DE UN PROFESOR (incluye nombre del alumno)
router.get("/profesor/:id", async (req, res) => {
  const id = req.params.id;

  try {
    const [result] = await sequelize.query(
      `SELECT t.*, 
              u.nombre AS nombre_alumno, 
              u.apellidos AS apellidos_alumno
       FROM tutoria t
       JOIN usuario u ON t.Alumno_usuario_id_usuario = u.id_usuario
       WHERE t.Profesor_usuario_id_usuario = ?
       ORDER BY t.fecha_tutoria DESC`,
      { replacements: [id] }
    );
    res.json(result);
  } catch (error) {
    console.error("❌ Error al obtener tutorías del profesor:", error);
    res.status(500).json({ error: "Error al obtener tutorías del profesor" });
  }
});

// 🔹 OBTENER TUTORÍAS DE UN ALUMNO (incluye nombre del profesor)
router.get("/alumno/:id", async (req, res) => {
  const id = req.params.id;

  try {
    const [result] = await sequelize.query(
      `SELECT t.*, 
              u.nombre AS nombre_profesor, 
              u.apellidos AS apellidos_profesor
       FROM tutoria t
       JOIN usuario u ON t.Profesor_usuario_id_usuario = u.id_usuario
       WHERE t.Alumno_usuario_id_usuario = ?
       ORDER BY t.fecha_tutoria DESC`,
      { replacements: [id] }
    );
    res.json(result);
  } catch (error) {
    console.error("❌ Error al obtener tutorías del alumno:", error);
    res.status(500).json({ error: "Error al obtener tutorías del alumno" });
  }
});

// 🔹 ELIMINAR TUTORÍA
router.delete("/eliminar/:id", async (req, res) => {
  const id = req.params.id;

  try {
    await sequelize.query(
      "DELETE FROM tutoria WHERE id_tutoria = ?",
      { replacements: [id] }
    );
    res.json({ mensaje: "✅ Tutoría eliminada correctamente" });
  } catch (error) {
    console.error("❌ Error al eliminar tutoría:", error);
    res.status(500).json({ error: "Error al eliminar tutoría" });
  }
});

module.exports = router;
