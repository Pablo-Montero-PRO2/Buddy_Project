const axios = require('axios');

axios.post('http://localhost:5000/api/auth/register', {
  name: "Usuario Prueba",
  email: "prueba@email.com",
  password: "123456"
})
.then(response => {
  console.log("✅ Usuario creado:", response.data);
})
.catch(error => {
  console.error("❌ Error al registrar:", error.response.data);
});
