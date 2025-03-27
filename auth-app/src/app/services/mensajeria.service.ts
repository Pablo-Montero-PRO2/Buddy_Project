import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MensajeriaService {
  private apiUrl = 'http://localhost:5000/api/mensajeria'; // URL del backend
  constructor(private http: HttpClient) { }

  enviarMensaje(
    profesorId: number,
    alumnoId: number,
    asunto: string,
    contenido: string,
    email: string
  ): Observable<any> {
    const mensaje = { profesorId, alumnoId, asunto, contenido, email };
    console.log(profesorId, alumnoId, asunto, contenido, email);
    return this.http.post(`${this.apiUrl}/enviarMensaje`, mensaje);
  }
}
