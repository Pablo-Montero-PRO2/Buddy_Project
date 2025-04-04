import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ActividadService {
  private apiUrl = 'http://localhost:5000/api/actividad'; // Backend base URL

  constructor(private http: HttpClient) {}

  // 🔹 Obtener estado de una actividad concreta (alumno)
  obtenerEstadoActividad(alumnoId: number, actividadId: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/alumno/${alumnoId}/actividad/${actividadId}`);
  }

  // 🔹 Obtener actividades del alumno
  obtenerActividadesDeAlumno(alumnoId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/alumno/${alumnoId}`);
  }

  // 🔹 Obtener actividades del profesor
  obtenerActividadesDeProfesor(profesorId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/profesor/${profesorId}`);
  }

  // 🔹 Actualizar estado de una actividad del alumno
  actualizarEstadoActividad(alumnoId: number, actividadId: number, nuevoEstado: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/estado`, {
      alumnoId,
      actividadId,
      nuevoEstado
    });
    
  }
  // 🔹 Crear una nueva actividad del profesor
crearActividad(actividad: any): Observable<any> {
  return this.http.post(`${this.apiUrl}/crear`, actividad);
}
// 🔹 Eliminar actividad por ID
eliminarActividad(id: number): Observable<any> {
  return this.http.delete(`${this.apiUrl}/eliminar/${id}`);
}
editarActividad(id: number, actividad: any): Observable<any> {
  return this.http.put(`${this.apiUrl}/editar/${id}`, actividad);
}


}
