import { Component } from '@angular/core';

@Component({
  selector: 'app-mensajes',
  templateUrl: './mensajes.component.html',
  styleUrls: ['./mensajes.component.css']
})
export class MensajesComponent {
  mensajes: any[] = [];

  ngOnInit() {
    // Hacemos las funciones globales para que puedan llamarse desde el HTML
    (window as any).abrirMensaje = this.abrirMensaje.bind(this);
    (window as any).cerrarMensaje = this.cerrarMensaje.bind(this);
    (window as any).enviarMensaje = this.enviarMensaje.bind(this);
    (window as any).eliminarMensaje = this.eliminarMensaje.bind(this);
    (window as any).publicarMensaje = this.publicarMensaje.bind(this);
  }

  abrirMensaje() {
    const mensajeDiv = document.getElementById('mensaje')?.classList.remove('d-none');
  }

  cerrarMensaje() {
    const mensajeDiv = document.getElementById('mensaje')?.classList.add('d-none');
  }

  enviarMensaje(event: Event) {
    event.preventDefault();

    const alumno = (document.getElementById('alumno') as HTMLInputElement).value;
    const asunto = (document.getElementById('asunto') as HTMLInputElement).value;
    const contenido = (document.getElementById('contenido') as HTMLTextAreaElement).value;

    if (!alumno || !contenido) {
      alert('Por favor, completa todos los campos.');
      return;
    }

    const ahora = new Date();
    const fechaHoraFormateada = ahora.toLocaleString('es-ES', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    });

    const nuevoMensaje = {
      alumno,
      asunto,
      contenido,
      fecha: fechaHoraFormateada,
      publicado: false
    };

    this.mensajes.push(nuevoMensaje);
    this.actualizarMensajes();

    // Limpiar campos
    (document.getElementById('alumno') as HTMLInputElement).value = '';
    (document.getElementById('asunto') as HTMLInputElement).value = '';
    (document.getElementById('contenido') as HTMLTextAreaElement).value = '';

    this.cerrarMensaje();
  }

  eliminarMensaje(index: number) {
    if (confirm('¿Estás seguro de que quieres eliminar este mensaje?')) {
      this.mensajes.splice(index, 1);
      this.actualizarMensajes();
    }
  }

  publicarMensaje(index: number) {
    this.mensajes[index].publicado = true;
    this.actualizarMensajes();
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
              <h2 class="h5 mb-0">Alumno: ${mensaje.alumno}</h2>
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
