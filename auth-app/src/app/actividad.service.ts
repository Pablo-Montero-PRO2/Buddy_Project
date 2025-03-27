import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ActividadService {
  private apiUrl = 'http://localhost:5000'; // Cambia si usas otro puerto o dominio

  constructor(private http: HttpClient) {}

  // ✅ EXISTENTE: Obtener estado de una actividad concreta
  obtenerEstadoActividad(alumnoId: number, actividadId: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/estadoActividad`, {
      params: {
        alumno_id: alumnoId,
        actividad_id: actividadId
      }
    });
  }

  // ✅ EXISTENTE: Obtener todas las actividades del alumno
  obtenerActividadesDeAlumno(alumnoId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/api/actividades/alumno/${alumnoId}`);
  }

  // ✅ NUEVO: Actualizar el estado de una actividad de un alumno
  actualizarEstadoActividad(alumnoId: number, actividadId: number, nuevoEstado: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/api/actividad/estado`, {
      alumnoId,
      actividadId,
      nuevoEstado
    });
  }
}

