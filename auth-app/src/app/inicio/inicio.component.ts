import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { ActividadService } from '../actividad.service';

@Component({
  selector: 'app-inicio',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css']
})
export class InicioComponent implements OnInit {
  actividades: any[] = [];
  alumnoId: number = 100;

  constructor(
    private actividadService: ActividadService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.actividadService.obtenerActividadesDeAlumno(this.alumnoId)
      .subscribe({
        next: (data) => {
          this.actividades = data;
        },
        error: (err) => {
          console.error('❌ Error al cargar actividades', err);
        }
      });
  }

  irActividad(id: number): void {
    this.router.navigate(['/actividad', id]);
  }

  // ✅ Método general para cambiar el estado desde cualquier tarjeta
  actualizarEstado(actId: number, nuevoEstado: string): void {
    this.actividadService.actualizarEstadoActividad(this.alumnoId, actId, nuevoEstado)
      .subscribe({
        next: () => {
          console.log(`✅ Actividad ${actId} actualizada a ${nuevoEstado}`);
          this.ngOnInit(); // recarga la lista
        },
        error: (err) => {
          console.error(`❌ Error al actualizar actividad ${actId}`, err);
        }
      });
  }
}
