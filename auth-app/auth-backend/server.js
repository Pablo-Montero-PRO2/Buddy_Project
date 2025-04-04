require("dotenv").config();
const express = require("express");
const cors = require("cors");
const { connectDB, sequelize } = require("./config/db");
const authRoutes = require("./routes/authRoutes");
const internalRoutes = require("./routes/internalRoutes");
const mensajeriaRoutes = require("./routes/mensajeriaRoutes");
const actividadRoutes = require('./routes/actividadRoutes'); // Mover aquí
const tutoriaRoutes = require('./routes/tutoriaRoutes');
const AlumnoActividad = require("./models/Alumno_has_actividad");
const Actividad = require("./models/Actividad");
const  Mensajeria  = require("./models/Mensajeria");
const { Op } = require("sequelize");

// Ahora declaras app
const app = express(); // ✅ Aquí va primero
app.use(cors());
app.use(express.json());

// 📌 Ruta raíz para que no dé el error 'Cannot GET /'
app.get("/", (req, res) => {
  res.send("¡Bienvenido al servidor de la API!");
});

// 📌 Rutas de autenticación y mensajería
app.use("/api/auth", authRoutes);
app.use("/api/mensajeria", mensajeriaRoutes);
app.use("/api/internal", internalRoutes); // 👈 AÑADIDO
app.use('/api/tutorias', tutoriaRoutes);
// 📌 Las rutas que usas para actividades
app.use('/api/actividad', actividadRoutes); // ✅ Esta línea va después de `app`

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

app.post('/api/mensajeria/enviarMensaje',async (req, res) => {
  // Aquí iría la lógica de guardar el mensaje en la base de datos
  console.log("Modelo Mensajeria:", Mensajeria);
  try {
    console.log("Solicitud recibida: ", req.body)
    const mensaje = await Mensajeria.create({
      Profesor_usuario_id_usuario: req.body.profesorId,  // 🔹 Convertimos los nombres
      Alumno_usuario_id_usuario: req.body.alumnoId,
      fecha_hora_mensaje: req.body.fechaHora, 
      desc_mensaje: req.body.contenido,
      asunto_mensaje: req.body.asunto || null, // El asunto no es obligatorio
      est_mensaje: req.body.est_mesj || 0 // 🔹 Aseguramos que no sea undefined
    });

    console.log("Mensaje guardado:", mensaje);
    res.status(200).json({ mensaje: "Mensaje enviado correctamente" });
    res.json(mensaje)
  } catch (error) {
    console.error("Error en el backend:", error);
    res.status(500).json({ error: "Error interno del servidor" });
  }
});
app.get('/api/mensajeria/obtenerMensajes', async(req, res)=>{
try {
  // Obtener todos los mensajes
  const mensajes = await Mensajeria.findAll();    
  res.json({mensajes});
} catch (error) {
  console.error('Error al obtener los mensajes:', error);
  res.status(500).json({ error: 'Error al obtener los mensajes' });
}
}),

// 📌 Obtener actividades del alumno
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

// 📌 Obtener actividades del profesor
app.get("/api/actividades/profesor/:id", async (req, res) => {
  const profesorId = parseInt(req.params.id);

  try {
    const actividades = await Actividad.findAll({
      where: {
        Profesor_usuario_id_usuario: profesorId,
        est_act_prof: {
          [Op.in]: ['Creada', 'No creada']
        }
      },
      order: [
        [sequelize.literal(`FIELD(est_act_prof, 'Creada', 'No creada')`)]
      ]
    });

    const resultado = actividades.map(act => ({
      id: act.id_actividad,
      tipo: act.tipo_act || 'Desconocido',
      descripcion: act.desc_act || '',
      estado: act.est_act_prof
    }));

    res.json(resultado);
  } catch (error) {
    console.error("❌ Error al obtener actividades del profesor:", error);
    res.status(500).json({ error: "Error al consultar actividades" });
  }
});

// 📌 Actualizar estado de una actividad de un alumno
app.put("/api/actividad/estado", async (req, res) => {
  console.log("📥 Datos recibidos para actualizar estado:", req.body);
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


const PORT = process.env.PORT || 5000;

app.listen(PORT, async () => {
  await connectDB();
  await sequelize.sync();
  console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
});
