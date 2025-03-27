require("dotenv").config();
const express = require("express");
const cors = require("cors");
const { connectDB, sequelize } = require("./config/db");
const authRoutes = require("./routes/authRoutes");
const AlumnoActividad = require("./models/AlumnoActividad");
const Actividad = require("./models/Actividad"); // 👈 importar modelo
const { Op } = require("sequelize");

const app = express();
app.use(cors());
app.use(express.json());

// 📌 Ruta raíz para que no dé el error 'Cannot GET /'
app.get("/", (req, res) => {
  res.send("¡Bienvenido al servidor de la API!");
});

// 📌 Rutas de autenticación
app.use("/api/auth", authRoutes);

// 📌 Consulta estado de una actividad para un alumno
app.get("/estadoActividad", async (req, res) => {
  const alumnoId = parseInt(req.query.alumno_id, 10);
  const actividadId = parseInt(req.query.actividad_id, 10);

  if (!alumnoId || !actividadId) {
    return res.status(400).json({ error: "Faltan parámetros: alumno_id y actividad_id" });
  }

  try {
    const resultado = await AlumnoActividad.findOne({
      where: {
        Alumno_usuario_id_usuario: alumnoId,
        actividad_id_actividad: actividadId
      }
    });

    if (resultado) {
      res.json({ estado: resultado.est_act_alu });
    } else {
      res.json({ estado: "no_iniciado" });
    }
  } catch (error) {
    console.error("❌ Error al consultar la base de datos:", error);
    res.status(500).json({ error: "Error interno del servidor" });
  }
});

// 📌 NUEVO: Obtener actividades del alumno (en proceso y finalizadas)
app.get("/api/actividades/alumno/:id", async (req, res) => {
  const alumnoId = parseInt(req.params.id);

  try {
    const actividades = await AlumnoActividad.findAll({
      where: {
        Alumno_usuario_id_usuario: alumnoId,
        est_act_alu: {
          [Op.in]: ['En proceso', 'Finalizada']
        }
      },
      include: [{
        model: Actividad,
        as: 'actividad',
        attributes: ['id_actividad', 'tipo_act', 'desc_act']
      }],
      order: [
        [sequelize.literal(`FIELD(est_act_alu, 'En proceso', 'Finalizada')`)]
      ]
    });

// 📌 NUEVO: Actualizar el estado de una actividad de un alumno
app.put("/api/actividad/estado", async (req, res) => {
  const { alumnoId, actividadId, nuevoEstado } = req.body;

  if (!alumnoId || !actividadId || !nuevoEstado) {
    return res.status(400).json({ error: "Faltan parámetros" });
  }

  try {
    const result = await AlumnoActividad.update(
      { est_act_alu: nuevoEstado },
      {
        where: {
          Alumno_usuario_id_usuario: alumnoId,
          actividad_id_actividad: actividadId
        }
      }
    );

    if (result[0] === 0) {
      return res.status(404).json({ error: "Relación no encontrada o sin cambios" });
    }

    res.json({ mensaje: "✅ Estado actualizado correctamente" });
  } catch (error) {
    console.error("❌ Error al actualizar estado:", error);
    res.status(500).json({ error: "Error al actualizar estado de la actividad" });
  }
});


    const resultado = actividades.map(act => ({
      id: act.actividad_id_actividad,
      tipo: act.actividad?.tipo_act || 'Desconocido',
      descripcion: act.actividad?.desc_act || '',
      estado: act.est_act_alu
    }));

    res.json(resultado);
  } catch (error) {
    console.error("❌ Error al obtener actividades del alumno:", error);
    res.status(500).json({ error: "Error al consultar actividades" });
  }
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, async () => {
  await connectDB();
  await sequelize.sync(); // 🔹 Sincronizar modelos con MySQL
  console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
});
