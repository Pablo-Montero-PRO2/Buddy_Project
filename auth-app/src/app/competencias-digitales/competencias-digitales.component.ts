import { Component, numberAttribute  } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
    selector: 'app-competencias-digitales',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './competencias-digitales.component.html',
    styleUrl: './competencias-digitales.component.css'
})

export class CompetenciasDigitalesComponent {
        
    actividadesAlumno: any[] =[];
    
    ngOnInit(): void {
      (window as any).abrirMensaje = this.mostrarCompetencia.bind(this);
      (window as any).cerrarMensaje = this.cerrarCompetencia.bind(this);
      (window as any).enviarMensaje = this.enviarMensaje.bind(this);
      (window as any).eliminarMensaje = this.eliminarMensaje.bind(this);
      
        this.cargarActividades();
    }

    cargarActividades(): void {
        // Aquí iría la llamada al backend o servicio si fuera necesario
        console.log('Actividades cargadas');
    }

    crearActividad(): void {
        alert('Función para crear nueva actividad');
        // Aquí podrías abrir un modal, redirigir, etc.
    }

    mostrarCompetencia() {
      const mensajeDiv = document.getElementById('mensaje');
      if(mensajeDiv) mensajeDiv.style.display = 'block';
    }

    cerrarCompetencia() {
      const mensajeDiv = document.getElementById('mensaje');
      if(mensajeDiv) mensajeDiv.style.display = 'none';
    }

    enviarMensaje(event:Event) {
      event.preventDefault();

      const titulo = (document.getElementById('titulo') as HTMLInputElement).value;
      const descripcion = (document.getElementById('descripcion') as HTMLTextAreaElement).value;
      const estado = (document.getElementById('estado') as HTMLSelectElement).value;
      //const archivos = (document.getElementById('archivos') as HTMLInputElement);

      if(!titulo || !descripcion || !estado) {
        alert('Por favor, completa todos los campos');
        return;
      }

      const hora_acatual = new Date();
      const fechaHoraFormateada = hora_acatual.toLocaleDateString('es-ES', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
      });

      const nuevoMensaje = {
        titulo,
        descripcion,
        estado,
        fecha: fechaHoraFormateada,
        publicado: false,
      };

      this.actividadesAlumno.push(nuevoMensaje);
      this.actualizarActividades();

      //Limpiamos campos
      (document.getElementById('titulo') as HTMLInputElement).value = '';
      (document.getElementById('descripcion') as HTMLTextAreaElement).value = '';
      (document.getElementById('estado') as HTMLSelectElement).value = '';
      this.cerrarCompetencia();
    }

    eliminarMensaje(index: number){
      if(confirm('¿Estás seguro de que deseas eliminar la actividad?')) {
        this.actividadesAlumno.splice(index, 1);
        this.actualizarActividades();
      }
    }

    publicarMensaje(index: number) {
      this.actividadesAlumno[index].publicado = true;
      this.actualizarActividades();
    }

    actualizarActividades() {
      const listaMensajes = document.getElementById('listaMensajes');
      if(listaMensajes) {
        listaMensajes.innerHTML = '';
        this.actividadesAlumno.forEach((mensaje, index) => {
          const mensajeHTML =`
          <article>
            <h2>Título: ${mensaje.titulo}</h2>
            <p>Descripción: ${mensaje.descripcion}</p>
            <p>Estado: ${mensaje.estado}</p>
            <span>${mensaje.fecha}</span>
            <button onclick="eliminarMensaje(${index})">Eliminar</button>
          </article>
          `;
          listaMensajes.innerHTML = mensajeHTML + listaMensajes.innerHTML;
        });
      }
    }
}