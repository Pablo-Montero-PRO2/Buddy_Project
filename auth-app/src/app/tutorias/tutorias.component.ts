import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MensajeTutoriaService } from '../services/mensaje-tutoria.service';

@Component({
  selector: 'app-tutorias',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './tutorias.component.html',
  styleUrls: ['./tutorias.component.css']
})
export class TutoriasComponent implements OnInit {
  tutorias: any[] = [];
  tutoriaForm!: FormGroup;
  usuarioId: number = 0;
  rol: string = '';
  leidasLocalmente: number[] = [];

  constructor(
    private fb: FormBuilder,
    private mensajeService: MensajeTutoriaService
  ) {}

  ngOnInit(): void {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    this.usuarioId = user.id;
    this.rol = user.rol;

    this.tutoriaForm = this.fb.group({
      fecha: ['', Validators.required],
      horaInicio: ['', Validators.required],
      horaFin: ['', Validators.required],
      tema: ['', Validators.required],
      lugar: ['', Validators.required],
      observaciones: [''],
      alumnoId: [11, Validators.required]  // ✅ Añadido: selección de alumno (solo hay uno de momento)
    });

    this.cargarTutorias();
  }

  cargarTutorias(): void {
    if (this.rol === 'alumno') {
      this.mensajeService.obtenerTutoriasPorAlumno(this.usuarioId).subscribe({
        next: (data) => {
          this.tutorias = data;
          this.leidasLocalmente = [];
        },
        error: (err) => console.error('Error al obtener tutorías del alumno:', err)
      });
    } else if (this.rol === 'profesor') {
      this.mensajeService.obtenerTutoriasPorProfesor(this.usuarioId).subscribe({
        next: (data) => {
          this.tutorias = data;
          this.leidasLocalmente = [];
        },
        error: (err) => console.error('Error al obtener tutorías del profesor:', err)
      });
    }
  }

  crearTutoria(): void {
    if (this.tutoriaForm.invalid) {
      alert('Por favor, completa todos los campos requeridos.');
      return;
    }

    const nuevaTutoria = {
      profesorId: this.usuarioId,
      alumnoId: this.tutoriaForm.value.alumnoId,  // ✅ ahora se recoge del formulario
      ...this.tutoriaForm.value
    };

    this.mensajeService.crearTutoria(nuevaTutoria).subscribe({
      next: () => {
        this.tutoriaForm.reset();
        this.tutoriaForm.patchValue({ alumnoId: 11 }); // ✅ volver a dejar seleccionado el alumno por defecto
        this.cargarTutorias();
      },
      error: (err) => console.error('Error al crear la tutoría:', err)
    });
  }

  eliminarTutoria(id: number): void {
    if (confirm('¿Estás seguro de eliminar esta tutoría?')) {
      this.mensajeService.eliminarTutoria(id).subscribe({
        next: () => this.cargarTutorias(),
        error: (err) => console.error('Error al eliminar tutoría:', err)
      });
    }
  }

  marcarComoLeida(idTutoria: number): void {
    if (!this.leidasLocalmente.includes(idTutoria)) {
      this.leidasLocalmente.push(idTutoria);
    }
  }

  marcarComoNoLeida(idTutoria: number): void {
    this.leidasLocalmente = this.leidasLocalmente.filter(id => id !== idTutoria);
  }

  esLeida(idTutoria: number): boolean {
    return this.leidasLocalmente.includes(idTutoria);
  }
  abrirTutoria() {
    const form = document.getElementById("tutoria");
    if (form) form.hidden = false;
  }
 
  cerrarTutoria() {
    const form = document.getElementById("tutoria");
    if (form) form.hidden = true;
  }
}
