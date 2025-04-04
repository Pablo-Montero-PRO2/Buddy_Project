import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MensajesNoLeidosService {
  private baseUrl = 'http://localhost:5000/api/mensajeria';

  constructor(private http: HttpClient) {}

  getMensajesNoLeidos(): Observable<Record<string, number>> {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const baseUrl = 'http://localhost:5000/api/mensajeria';
  
    // ⬇️ Verifica el rol y construye la URL correcta
    const url = user.rol === 'alumno'
      ? `${baseUrl}/no-leidos/${user.id}`
      : `${baseUrl}/no-leidos-profesor/${user.id}`;
  
    return this.http.get<Record<string, number>>(url, {
      headers: {
        auth_token: localStorage.getItem('token') || ''
      }
    });
  }
  
}
