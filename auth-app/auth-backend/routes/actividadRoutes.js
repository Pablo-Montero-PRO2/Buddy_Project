const express = require('express');
const router = express.Router();
const { sequelize } = require('../config/db');

// 🔹 ACTIVIDADES DEL PROFESOR
router.get('/profesor/:id', async (req, res) => {
  const idProfesor = req.params.id;

  try {
    const [result] = await sequelize.query(
      `SELECT 
        id_actividad AS id,
        tipo_act AS tipo,
        titulo_act AS titulo,
        desc_act AS descripcion,
        est_act_prof AS estado
      FROM actividad
      WHERE Profesor_usuario_id_usuario = ?`,
      {
        replacements: [idProfesor]
      }
    );

    res.json(result);
  } catch (error) {
    console.error('❌ Error en GET /profesor/:id', error);
    res.status(500).json({ error: error.message });
  }
});

// 🔹 ACTIVIDADES DEL ALUMNO
router.get('/alumno/:id', async (req, res) => {
  const idAlumno = req.params.id;

  try {
    const [result] = await sequelize.query(
      `SELECT 
        a.id_actividad AS id,
        a.tipo_act AS tipo,
        a.titulo_act AS titulo,
        a.desc_act AS descripcion,
        aha.est_act_alu AS estado
      FROM actividad a
      JOIN alumno_has_actividad aha ON a.id_actividad = aha.actividad_id_actividad
      WHERE aha.alumno_usuario_id_usuario = ?`,
      {
        replacements: [idAlumno]
      }
    );

    res.json(result);
  } catch (error) {
    console.error('❌ Error en GET /alumno/:id', error);
    res.status(500).json({ error: error.message });
  }
});

// 🔹 CREAR NUEVA ACTIVIDAD (solo profesores)
router.post('/crear', async (req, res) => {
  const { tipo_act, desc_act, est_act_prof, Profesor_usuario_id_usuario } = req.body;

  try {
    // Validar que es un profesor
    const [profesor] = await sequelize.query(
      `SELECT * FROM profesor WHERE usuario_id_usuario = ?`,
      { replacements: [Profesor_usuario_id_usuario] }
    );

    if (profesor.length === 0) {
      return res.status(403).json({ error: 'Solo los profesores pueden crear actividades' });
    }

    const [result] = await sequelize.query(
      `INSERT INTO actividad (tipo_act, desc_act, est_act_prof, Profesor_usuario_id_usuario)
       VALUES (?, ?, ?, ?)`,
      {
        replacements: [tipo_act, desc_act, est_act_prof, Profesor_usuario_id_usuario]
      }
    );

    res.json({ mensaje: '✅ Actividad creada correctamente', result });
  } catch (error) {
    console.error('❌ Error al crear actividad:', error);
    res.status(500).json({ error: 'Error al crear actividad' });
  }
});

// 🔹 ELIMINAR ACTIVIDAD POR ID
router.delete('/eliminar/:id', async (req, res) => {
  const id = req.params.id;

  try {
    await sequelize.query(
      'DELETE FROM actividad WHERE id_actividad = ?',
      { replacements: [id] }
    );

    res.json({ mensaje: '✅ Actividad eliminada correctamente' });
  } catch (error) {
    console.error('❌ Error al eliminar actividad:', error);
    res.status(500).json({ error: 'Error al eliminar actividad' });
  }
});

// 🔹 EDITAR ACTIVIDAD POR ID
router.put('/editar/:id', async (req, res) => {
  const id = req.params.id;
  const { tipo_act, desc_act, est_act_prof } = req.body;

  try {
    await sequelize.query(
      `UPDATE actividad
       SET tipo_act = ?, desc_act = ?, est_act_prof = ?
       WHERE id_actividad = ?`,
      {
        replacements: [tipo_act, desc_act, est_act_prof, id]
      }
    );

    res.json({ mensaje: '✅ Actividad actualizada correctamente' });
  } catch (error) {
    console.error('❌ Error al editar actividad:', error);
    res.status(500).json({ error: 'Error al editar actividad' });
  }
});

module.exports = router;
