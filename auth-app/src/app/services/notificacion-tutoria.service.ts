import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class NotificacionTutoriaService {
  private apiUrl = 'http://localhost:5000/api/tutorias';

  constructor(private http: HttpClient) {}

  // ✅ NUEVO: Obtener cantidad de tutorías pendientes
  getTutoriasNoLeidas(alumnoId: number): Observable<{ cantidadTutoriasNoLeidas: number }> {
    return this.http.get<{ cantidadTutoriasNoLeidas: number }>(
      `${this.apiUrl}/pendientes/${alumnoId}`
    );
  }

  // ✔️ Ya existente
  marcarComoLeida(tutoriaId: number): Observable<any> {
    return this.http.put(`${this.apiUrl}/marcar-leida/${tutoriaId}`, {});
  }
}
