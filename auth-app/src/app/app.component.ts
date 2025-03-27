import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { RouterModule } from '@angular/router';  
import { RouterOutlet } from '@angular/router';
import { MenuLateralComponent } from './auth/menu-lateral/menu-lateral.component'; 
import { CommonModule } from '@angular/common';  // Importar CommonModule

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterModule, MenuLateralComponent, RouterOutlet, CommonModule],  // Incluir CommonModule en imports
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'auth-app';
  isLoginPage = false;

  constructor(private router: Router) { }

  ngOnInit() {
    // Suscribirse a los cambios de ruta para detectar cuando estamos en la página de login
    this.router.events.subscribe(() => {
      // Comprobar si la ruta es '/login'
      this.isLoginPage = this.router.url === '/login';
    });
  }
}
