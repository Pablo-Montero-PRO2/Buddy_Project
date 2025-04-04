import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActividadService } from './../services/actividad.service';

@Component({
  selector: 'app-emprendimiento',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './emprendimiento.component.html',
  styleUrls: ['./emprendimiento.component.css']
})
export class EmprendimientoComponent implements OnInit {
  actividades: any[] = [];
  profesorId: number = 10;
  usuarioId: number = 0;
  esProfesor: boolean = false;

  nuevaActividad = {
    tipo: '',
    descripcion: ''
  };

  modoEdicion: boolean = false;
  actividadEditandoId: number | null = null;

  constructor(private actividadService: ActividadService) {}

  ngOnInit(): void {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    this.usuarioId = user.id;
    this.esProfesor = user.rol === 'profesor';

    if (this.esProfesor) {
      this.obtenerActividadesDelProfesor();
    } else {
      this.obtenerActividadesDelAlumno();
    }
  }

  obtenerActividadesDelProfesor(): void {
    this.actividadService.obtenerActividadesDeProfesor(this.usuarioId).subscribe({
      next: (data) => this.actividades = data,
      error: (err) => console.error('Error al obtener actividades del profesor:', err)
    });
  }

  obtenerActividadesDelAlumno(): void {
    this.actividadService.obtenerActividadesDeAlumno(this.usuarioId).subscribe({
      next: (data) => this.actividades = data,
      error: (err) => console.error('Error al obtener actividades del alumno:', err)
    });
  }

  guardarActividad(): void {
    const actividad = {
      tipo_act: this.nuevaActividad.tipo,
      desc_act: this.nuevaActividad.descripcion,
      est_act_prof: 'No creada',
      Profesor_usuario_id_usuario: this.usuarioId
    };

    if (this.modoEdicion && this.actividadEditandoId !== null) {
      this.actividadService.editarActividad(this.actividadEditandoId, actividad).subscribe({
        next: () => {
          this.obtenerActividadesDelProfesor();
          this.cancelarEdicion();
        },
        error: (err) => console.error('Error al editar actividad:', err)
      });
    } else {
      this.actividadService.crearActividad(actividad).subscribe({
        next: () => {
          this.obtenerActividadesDelProfesor();
          this.nuevaActividad = { tipo: '', descripcion: '' };
        },
        error: (err) => console.error('Error al crear actividad:', err)
      });
    }
  }

  editarActividad(id: number): void {
    const form = document.getElementById("actividad");
    if (form) form.hidden = false;

    const actividad = this.actividades.find(a => a.id === id);
    if (!actividad) return;

    this.modoEdicion = true;
    this.actividadEditandoId = id;
    this.nuevaActividad = {
      tipo: actividad.tipo,
      descripcion: actividad.descripcion
    };
  }

  cancelarEdicion(): void {
    this.modoEdicion = false;
    this.actividadEditandoId = null;
    this.nuevaActividad = { tipo: '', descripcion: '' };
  }

  eliminarActividad(id: number): void {
    if (confirm('¿Estás seguro de que quieres eliminar esta actividad?')) {
      this.actividadService.eliminarActividad(id).subscribe({
        next: () => this.obtenerActividadesDelProfesor(),
        error: (err) => console.error('❌ Error al eliminar actividad:', err)
      });
    }
  }

  abrirActividad() {
    const form = document.getElementById("actividad");
    if (form) form.hidden = false;
  }

  cerrarActividad() {
    const form = document.getElementById("actividad");
    if (form) form.hidden = true;
  }
}
