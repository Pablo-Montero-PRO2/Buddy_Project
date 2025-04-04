import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MensajeTutoriaService {
  private apiUrl = 'http://localhost:5000/api/tutorias'; // Asegúrate que coincide con tu backend

  constructor(private http: HttpClient) {}

  // ✅ Obtener tutorías del alumno
  obtenerTutoriasPorAlumno(alumnoId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/alumno/${alumnoId}`);
  }

  // ✅ Obtener tutorías del profesor
  obtenerTutoriasPorProfesor(profesorId: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/profesor/${profesorId}`);
  }

  // ✅ Crear una nueva tutoría
  crearTutoria(tutoriaData: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/crear`, tutoriaData);
  }

  // ✅ Eliminar tutoría por ID
  eliminarTutoria(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/eliminar/${id}`);
  }
}
