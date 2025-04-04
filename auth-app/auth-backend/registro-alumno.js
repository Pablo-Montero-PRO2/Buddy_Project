const axios = require('axios');

// Paso 1: Registrar el usuario
axios.post('http://localhost:5000/api/auth/register', {
  name: "Damián",
  email: "dcarrillo@pro2fp.es",
  password: "1234",
  apellidos: "Carrillo Arjones",
  telf: "659462546",
})
.then(async (response) => {
  console.log("✅ Usuario registrado:", response.data);

  const userId = response.data.user.id_usuario;

  // Paso 2: Insertar en tabla alumno
  try {
    await axios.post('http://localhost:5000/api/internal/insert-alumno', {
      id_usuario: userId
    });
    console.log("✅ Insertado como alumno");
  } catch (err) {
    console.error("❌ Error al insertar como alumno:", err.response?.data || err.message);
  }

})
.catch(error => {
  console.error("❌ Error al registrar:", error.response?.data || error.message);
});

