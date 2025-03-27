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
  templateUrl: './mensajeria.component.html',
  styleUrls: ['./mensajeria.component.css']
})
export class MensajeriaComponent implements OnInit {
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
          <article>
            <h2>Alumno: ${mensaje.email}</h2>
            <p>Último mensaje: ${mensaje.contenido}</p>
            <span>${mensaje.fecha}</span>
            <button onclick="eliminarMensaje(${index})">Eliminar</button>
            }
          </article>
        `;
        listaMensajes.innerHTML += mensajeHTML;
      });
    }
  }
}
