import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { ActividadService } from '../services/actividad.service';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-inicio',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css']
})
export class InicioComponent implements OnInit {
  actividades: any[] = [];
  usuarioId: number = 0;
  esProfesor: boolean = false;
  userNombreApe?: string = undefined;

  constructor(
    private authService: AuthService,
    private actividadService: ActividadService,
    private router: Router
  ) {}

  ngOnInit(): void {
    const id = this.authService.getUsuarioId();
    if (id === null) {
      console.error('❌ No se encontró el ID del usuario en el localStorage');
      return;
    }

    this.usuarioId = id;
    this.userNombreApe = this.authService.getNombreApe();
    this.esProfesor = this.authService.esProfesor();

    console.log("📌 Usuario:", this.userNombreApe);
    console.log("🎓 ¿Es profesor?:", this.esProfesor);
    console.log("🆔 ID:", this.usuarioId);

    if (this.esProfesor) {
      this.actividadService.obtenerActividadesDeProfesor(this.usuarioId)
        .subscribe({
          next: (data) => {
            console.log('📦 Actividades del profesor:', data);
            this.actividades = data.map(act => ({
              id: act.id,
              tipo: act.tipo,
              descripcion: act.descripcion,
              estado: act.estado
            }));
          },
          error: (err) => {
            console.error('❌ Error al cargar actividades del profesor', err);
          }
        });

    } else {
      this.actividadService.obtenerActividadesDeAlumno(this.usuarioId)
        .subscribe({
          next: (data) => {
            console.log('📦 Actividades del alumno:', data);
            this.actividades = data.map(act => ({
              id: act.id,
              tipo: act.tipo,
              descripcion: act.descripcion,
              estado: act.estado
            }));
          },
          error: (err) => {
            console.error('❌ Error al cargar actividades del alumno', err);
          }
        });
    }
  }

  irActividad(id: number): void {
    this.router.navigate(['/actividad', id]);
  }

  actualizarEstado(actId: number, nuevoEstado: string): void {
    this.actividadService.actualizarEstadoActividad(this.usuarioId, actId, nuevoEstado)
      .subscribe({
        next: () => {
          console.log(`✅ Actividad ${actId} actualizada a ${nuevoEstado}`);
          this.ngOnInit(); // recarga la lista para reflejar el nuevo estado
        },
        error: (err) => {
          console.error(`❌ Error al actualizar actividad ${actId}`, err);
        }
      });
  }
}
