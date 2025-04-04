import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './auth/login/login.component';
import { InicioComponent } from './inicio/inicio.component';
import { MentoringComponent } from './mentoring/mentoring.component'; 
import { EmprendimientoComponent } from './emprendimiento/emprendimiento.component'; 
import { CompetenciasDigitalesComponent } from './competencias-digitales/competencias-digitales.component'; 
import { TutoriasComponent } from './tutorias/tutorias.component'; 
import { MensajesComponent } from './mensajes/mensajes.component'; 
import { PerfilComponent } from './perfil/perfil.component'; 
import { ActividadComponent } from './actividad/actividad.component'; 


export const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'inicio', component: InicioComponent },
  { path: 'mentoring', component: MentoringComponent },
  { path: 'emprendimiento', component: EmprendimientoComponent },
  { path: 'competencias-digitales', component: CompetenciasDigitalesComponent },
  { path: 'tutorias', component: TutoriasComponent },
  { path: 'mensajes', component: MensajesComponent },
  { path: 'perfil', component: PerfilComponent },
  { path: 'logo', component: LoginComponent }, //nuevo
  { path: 'actividad/:id', component: ActividadComponent },
  { path: 'tutorias', component: TutoriasComponent },
  { path: 'mensajeria', component: MensajesComponent },
  { path: '**', redirectTo: 'login' } // Default route
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
