import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

interface UrlObject {
  url: string;
  descripcion: string;
}

@Component({
  selector: 'app-mentoring',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './mentoring.component.html',
  styleUrls: ['./mentoring.component.css']
})
export class MentoringComponent {
  actividadesAlumno: any[] = [];
  urls: UrlObject[] = [{ url: '', descripcion: '' }];
  actividadEditada: any = null; // Para guardar la actividad seleccionada para edición

  ngOnInit(): void {
    (window as any).abrirMensaje = this.mostrarMentoring.bind(this);
    (window as any).cerrarMensaje = this.cerrarMentoring.bind(this);
    (window as any).enviarMensaje = this.enviarMentoring.bind(this);
    (window as any).eliminarMensaje = this.eliminarMentoring.bind(this);
    (window as any).editarMensaje = this.editarMentoring.bind(this);
  }
  mostrarMentoring() {
    const mensajeDiv = document.getElementById('mensaje');
    if (mensajeDiv) mensajeDiv.style.display = 'block';
  }

  cerrarMentoring() {
    const mensajeDiv = document.getElementById('mensaje');
    if (mensajeDiv) mensajeDiv.style.display = 'none';
  }

  enviarMentoring(event: Event) {
    event.preventDefault();
    const titulo = (document.getElementById('titulo') as HTMLInputElement).value;
    const descripcion = (document.getElementById('descripcion') as HTMLTextAreaElement).value;
    const estado = (document.getElementById('estado') as HTMLSelectElement).value;

    if (!titulo || !descripcion || !estado || this.urls.length === 0) {
      alert('Por favor, completa todos los campos y añade al menos una URL');
      return;
    }

    const hora_actual = new Date();
    const fechaHoraFormateada = hora_actual.toLocaleDateString('es-ES', {
      year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'
    });

    const nuevoMensaje = {
      titulo,
      descripcion,
      estado,
      fecha: fechaHoraFormateada,
      publicado: false,
      urls: this.urls // Guardamos las URLs con sus descripciones
    };

    if (this.actividadEditada) {
      // Si estamos editando, actualizamos la actividad
      this.actividadesAlumno[this.actividadEditada.index] = nuevoMensaje;
      this.actividadEditada = null; // Limpiamos la actividad editada
    } else {
      // Si es una nueva actividad, la agregamos al array
      this.actividadesAlumno.push(nuevoMensaje);
    }

    this.actualizarActividades();
    this.resetForm();
    this.cerrarMentoring();
  }

  eliminarMentoring(index: number) {
    if (confirm('¿Estás seguro de que deseas eliminar la actividad?')) {
      this.actividadesAlumno.splice(index, 1);
      this.actualizarActividades();
    }
  }

  publicarMentoring(index: number) {
    this.actividadesAlumno[index].publicado = true;
    this.actualizarActividades();
  }

  actualizarActividades() {
    const listaMensajes = document.getElementById('listaMensajes');
    if (listaMensajes) {
      listaMensajes.innerHTML = '';
      this.actividadesAlumno.forEach((mensaje, index) => {
        const mensajeHTML = `
          <article>
            <h2>Título: ${mensaje.titulo}</h2>
            <p>Descripción: ${mensaje.descripcion}</p>
            <p>Estado: ${mensaje.estado}</p>
            <p>URLs:</p>
            <ul>
              ${mensaje.urls.map((urlObj: UrlObject) => `<li>${urlObj.url} - ${urlObj.descripcion}</li>`).join('')}
            </ul>
            <span>${mensaje.fecha}</span>
            <br>
            <button onclick="eliminarMensaje(${index})">Eliminar</button>
            <button onclick="editarMensaje(${index})">Editar</button>
          </article>`;
        listaMensajes.innerHTML = mensajeHTML + listaMensajes.innerHTML;
      });
    }
  }

  // Función para manejar los cambios en las URLs
  onUrlChange(index: number, event: Event) {
    const input = event.target as HTMLInputElement;
    if (input && input.value) {
      this.urls[index].url = input.value; // Aseguramos que sea un string
    }
  }

  // Función para manejar los cambios en las descripciones
  onDescripcionChange(index: number, event: Event) {
    const input = event.target as HTMLInputElement;
    if (input && input.value) {
      this.urls[index].descripcion = input.value; // Aseguramos que sea una descripción válida
    }
  }


  // Función para agregar un nuevo campo de URL y descripción
  agregarUrl() {
    this.urls.push({ url: '', descripcion: '' }); // Añadimos un objeto con url y descripción vacíos
  }

  // Función para eliminar una URL en una posición específica
  eliminarUrl(index: number) {
    this.urls.splice(index, 1); // Eliminamos la URL y su descripción de la posición indicada
  }

  // Función para editar una actividad
  editarMentoring(index: number) {
    const actividad = this.actividadesAlumno[index];
    this.actividadEditada = { index, actividad }; // Guardamos el índice de la actividad y la actividad
    // Cargamos los datos en el formulario
    (document.getElementById('titulo') as HTMLInputElement).value = actividad.titulo;
    (document.getElementById('descripcion') as HTMLTextAreaElement).value = actividad.descripcion;
    (document.getElementById('estado') as HTMLSelectElement).value = actividad.estado;
    this.urls = actividad.urls; // Cargamos las URLs y descripciones
    this.mostrarMentoring(); // Mostramos el formulario para editar
  }
 
  // Función para resetear el formulario
  resetForm() {
    (document.getElementById('titulo') as HTMLInputElement).value = '';
    (document.getElementById('descripcion') as HTMLTextAreaElement).value = '';
    (document.getElementById('estado') as HTMLSelectElement).value = '';
    this.urls = [{ url: '', descripcion: '' }]; // Reseteamos las URLs
  }
}