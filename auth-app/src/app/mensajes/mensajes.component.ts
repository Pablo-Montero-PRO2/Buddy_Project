import { Component, OnInit } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { MensajeriaService } from '../services/mensajeria.service';

@Component({
  selector: 'app-mensajeria',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule],
  templateUrl: './mensajes.component.html',
  styleUrls: ['./mensajes.component.css']
})
export class MensajesComponent implements OnInit {
  mensajeForm!: FormGroup;
  mensajes: any[] = [];
  mensajeAbierto: boolean = false;
  errorMessage: string = '';

  constructor(
    private fb: FormBuilder,
    private mensajeriaService: MensajeriaService
  ) {}

  ngOnInit() {
    this.mensajeForm = this.fb.group({
      profesorId :['2'],
      email: ['', [Validators.required, Validators.email]],
      asunto: ['', Validators.required],
      contenido: ['', Validators.required]
    });
  }

  abrirMensaje() {
    console.log('Abrir mensaje función llamada');
    this.mensajeAbierto = true;
  }

  cerrarMensaje() {
   this.mensajeAbierto=false;
  }
  
  enviarMensaje() {
    const { profesorId, alumnoId, asunto, contenido, email} = this.mensajeForm.value;
    console.log(this.mensajeForm.value);
    this.mensajeriaService.enviarMensaje(profesorId, alumnoId, asunto, contenido, email).subscribe({
      next: (response) => {
        console.log("Mensaje enviado con éxito:", response);
        
        const ahora = new Date();
        const fechaHoraFormateada = ahora.toLocaleString('es-ES', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit'
        });

        const nuevoMensaje = {
          profesorId :2,
          alumnoId,
          email,
          asunto,
          contenido,
          fecha: fechaHoraFormateada,
          publicado: false,
        };

        this.mensajes.push(nuevoMensaje);
        //this.actualizarMensajes();
        this.mensajeForm.reset(); // ✅ Limpiar formulario de forma correcta
        this.cerrarMensaje();
      },
      error: (err) => {
        console.error("Error al enviar el mensaje:", err);
        //this.errorMessage = err.error?.msg || 'Error al enviar el mensaje';
      }
    });
  }
  
  eliminarMensaje(index: number) {
    if (confirm('¿Estás seguro de que quieres eliminar este mensaje?')) {
      this.mensajes.splice(index, 1);
    }
  }

  actualizarMensajes() {
    const listaMensajes = document.getElementById('listaMensajes');
    if (listaMensajes) {
      listaMensajes.innerHTML = '';
      this.mensajes.forEach((mensaje, index) => {
        const mensajeHTML = `
          <article class="card p-3 mb-3 shadow-sm">
            <div class="d-flex justify-content-between align-items-center">
              <!-- Alumno a la izquierda -->
              <h2 class="h5 mb-0">${mensaje.email}</h2>
              <!-- Fecha a la derecha -->
              <span class="text-muted">${mensaje.fecha}</span>
            </div>
            <!-- Último mensaje -->
            <p class="mt-2">${mensaje.contenido}</p>
            <!-- Botones alineados a la izquierda -->
            <div class="mt-3">
              <button class="btn btn-danger me-2" onclick="eliminarMensaje(${index})">Eliminar</button>
              ${
                !mensaje.publicado
                  ? `<button class="btn btn-success" onclick="publicarMensaje(${index})">Publicar</button>`
                  : '<span class="text-success fw-bold">Publicado</span>'
              }
            </div>
          </article>
        `;
        listaMensajes.innerHTML += mensajeHTML;
      });
    }
  }
}
