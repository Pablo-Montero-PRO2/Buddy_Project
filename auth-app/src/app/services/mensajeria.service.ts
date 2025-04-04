import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class MensajeriaService {
  private apiUrl = 'http://localhost:5000/api/mensajeria'; // URL del backend
  constructor(private http: HttpClient) { }

  enviarMensaje(
    profesorId: BigInteger,
    alumnoId: BigInteger,
    fechaHora: Date,
    asunto: string,
    contenido: string,
    est_mesj: number,
  ): Observable<any> {
    const mensaje = { profesorId, alumnoId, fechaHora, asunto, contenido, est_mesj};
    console.log("Service:",profesorId, alumnoId, fechaHora, asunto, contenido, est_mesj);
    return this.http.post(`${this.apiUrl}/enviarMensaje`, mensaje);
  }
  eliminarMensaje(id_mensaje:BigInteger):Observable<void>{
    return this.http.delete<void>(`${this.apiUrl}/eliminarMensaje/${id_mensaje}`);
  }
  obtenerMensajes(): Observable<any[]>{
    return this.http.get<any[]>(`${this.apiUrl}/obtenerMensajes`);
  }

}
