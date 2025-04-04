import { Component, OnInit } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { concatMap } from 'rxjs/operators';
import { MensajeriaService } from '../services/mensajeria.service';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-mensajes',
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
      this.obtenerMensajes(); 
      this.mensajeForm = this.fb.group({
        profesorId :['10'],
        alumnoId: ['11'],
        fechaHora: [new Date()],
        email: ['', [ Validators.email]],
        asunto: [''],
        contenido: [''],
        est_mesj:['0']
      });
    }
    obtenerMensajes() {
      this.mensajeriaService.obtenerMensajes().subscribe({
        next: (response) => {
          console.log('📩 Respuesta de la API:', response);
          
          if (Array.isArray(response)) {
            this.mensajes = response;
          } else {
            console.warn('⚠️ Respuesta inesperada:', response);
            this.mensajes = [];
          }
          
        },
        error: (error: HttpErrorResponse) => {
          console.error('❌ Error al obtener los mensajes:', error);
        }
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
    const {profesorId, alumnoId, fechaHora, email, asunto, contenido, est_mesj} = this.mensajeForm.value;
    console.log("Components: ",this.mensajeForm.value);
    this.mensajeriaService.obtenerMensajes().pipe(
      concatMap(() => this.mensajeriaService.enviarMensaje(profesorId, alumnoId, fechaHora, asunto, contenido, est_mesj))
    ).subscribe({
      next: (response) => {
        console.log("Mensaje enviado con éxito:", response);
        this.obtenerMensajes(); 
        
        const ahora = new Date();
        const fechaHoraFormateada = ahora.toLocaleString('es-ES', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit'
        });
        const nuevoMensaje = {
          profesorId,
          alumnoId,
          fechaHoraFormateada,
          email,
          asunto,
          contenido,
          est_mesj: 0,
          fecha: fechaHoraFormateada,
        };
        this.mensajes.push(nuevoMensaje);
        this.mensajeForm.patchValue({
            email: null,
            contenido: null,
            asunto: null,
            profesorId:this.mensajeForm.value.profesorId,
            alumnoId:this.mensajeForm.value.alumnoId, 
            fechaHora:this.mensajeForm.value.fechaHora
        });
        this.cerrarMensaje();
      },
      error: (error: HttpErrorResponse)=>{
          console.error('Error completo:', error);
          }
        
      }
  )};
  
 eliminarMensaje(index: number) {
    const mensaje = this.mensajes[index];
    if (confirm('¿Estás seguro de que quieres eliminar este mensaje?')) {
      this.mensajeriaService.eliminarMensaje(mensaje.id_mensaje).subscribe({
        next: () => {
          console.log('Mensaje eliminado correctamente');
          this.mensajes.splice(index, 1);
        },
        error: (error: HttpErrorResponse) => {
          console.error('Error al eliminar el mensaje', error);
        }
      });
    }
  }

}
