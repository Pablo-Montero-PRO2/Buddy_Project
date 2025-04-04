import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ActividadService } from '../services/actividad.service';

@Component({
  selector: 'app-actividad',
  templateUrl: './actividad.component.html',
  styleUrls: ['./actividad.component.css']
})
export class ActividadComponent implements OnInit {
  textoBoton: string = 'Cargando...';
  estadoActividad: string = '';
  alumnoId: number = 11;
  actividadId: number = 1; // 300 volver a realizar y 301 continuar

  constructor(
    private actividadService: ActividadService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.route.params.subscribe(params => {
      this.actividadId = +params['id'] || 300;
      this.obtenerEstado();
    });
  }

  obtenerEstado(): void {
    this.actividadService.obtenerEstadoActividad(this.alumnoId, this.actividadId)
      .subscribe({
        next: (respuesta: any) => {
          this.estadoActividad = respuesta.estado;

          if (this.estadoActividad === 'En proceso') {
            this.textoBoton = 'Continuar';
          } else if (this.estadoActividad === 'Finalizada') {
            this.textoBoton = 'Volver a realizar';
          } else {
            this.textoBoton = 'Iniciar actividad';
          }
        },
        error: (error: any) => {
          console.error('Error al consultar la actividad', error);
          this.textoBoton = 'Error al cargar';
        }
      });
  }

  onClick(): void {
    console.log(`🔁 Acción para actividad ${this.actividadId} con estado "${this.estadoActividad}"`);
    // Aquí podrías redirigir, abrir contenido, etc.
    // this.router.navigate(['/actividad', this.actividadId]); // si quisieras recargar o ir a otro componente
  }
}
