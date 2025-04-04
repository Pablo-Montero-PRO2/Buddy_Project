const axios = require('axios');

// Paso 1: Registrar al profesor (usuario)
axios.post('http://localhost:5000/api/auth/register', {
  name: "Luis Armando",
  email: "luis.dans@pro2fp.es",
  password: "1234",
  apellidos: "Dans Rodriguez",
  telf: "688555111"
})
.then(async (response) => {
  console.log("✅ Usuario registrado:", response.data);

  const userId = response.data.user.id_usuario;
  console.log("🧪 ID recibido:", userId);

  // Paso 2: Insertar en tabla profesor
  try {
    const body = { id_usuario: userId, es_tutor: true }; // puedes poner false si no es tutor
    console.log("📤 Enviando al backend:", body);

    await axios.post('http://localhost:5000/api/internal/insert-profesor', body);
    console.log("✅ Insertado como profesor");
  } catch (err) {
    console.error("❌ Error al insertar como profesor:", err.response?.data || err.message);
  }

})
.catch(error => {
  console.error("❌ Error al registrar:", error.response?.data || error.message);
});
