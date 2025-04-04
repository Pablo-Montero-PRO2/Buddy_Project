import { Component, OnInit } from '@angular/core';
import { RouterModule, Router, NavigationEnd } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MensajesNoLeidosService } from '../../services/mensajes-no-leidos.service';

@Component({
  selector: 'app-menu-lateral',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './menu-lateral.component.html',
  styleUrls: ['./menu-lateral.component.css']
})
export class MenuLateralComponent implements OnInit {

  cantidadMensajes: number = 0;
  cantidadTutorias: number = 0;

  constructor(
    private router: Router,
    private mensajesNoLeidosService: MensajesNoLeidosService
  ) {}

  ngOnInit() {
    this.actualizarContadores();

    // ✅ Detectar navegación y actualizar los contadores (mensajes + tutorías)
    this.router.events.subscribe(event => {
      if (event instanceof NavigationEnd) {
        this.actualizarContadores();
      }
    });
  }

  actualizarContadores(): void {
    this.mensajesNoLeidosService.getMensajesNoLeidos().subscribe({
      next: (response) => {
        this.cantidadMensajes = response['cantidadMensajesNoLeidos'];
      },
      error: (err) => {
        console.error('Error al obtener mensajes no leídos:', err);
      }
    });

    const tutoriasNoLeidas = localStorage.getItem('tutoriasNoLeidas');
    this.cantidadTutorias = tutoriasNoLeidas ? parseInt(tutoriasNoLeidas, 10) : 0;
  }

  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    localStorage.removeItem('tutoriasNoLeidas');
    this.router.navigate(['/login']);
  }
}
