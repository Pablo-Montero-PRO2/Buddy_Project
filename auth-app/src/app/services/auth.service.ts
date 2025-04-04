import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = 'http://localhost:5000/api/auth'; // URL del backend

  constructor(private http: HttpClient) {}

  // 📌 Iniciar sesión
  login(email: string, password: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/login`, { email, password });
  }

  // 📌 Obtener ID del usuario conectado
  getUsuarioId(): number | null {
    try {
      const user = JSON.parse(localStorage.getItem('user') || 'null');
      return user ? user.id : null;
    } catch (err) {
      console.error('❌ Error al obtener ID de usuario:', err);
      return null;
    }
  }

 // 📌 Obtener nombre + apellidos
getNombreApe(): string {
  try {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const nombre = user.name || '';
    const apellidos = user.apellidos || '';
    return `${nombre} ${apellidos}`.trim(); // <-- nombre completo
  } catch (err) {
    console.error('❌ Error al obtener nombre:', err);
    return '';
  }
}


  // 📌 Saber si es profesor (según el campo "rol")
  esProfesor(): boolean {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return user.rol === 'profesor';
    } catch (err) {
      console.warn('⚠️ Error al verificar rol de usuario:', err);
      return false;
    }
  }
}
