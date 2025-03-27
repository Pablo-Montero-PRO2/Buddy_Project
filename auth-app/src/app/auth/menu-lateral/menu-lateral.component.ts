import { Component } from '@angular/core';
import { RouterModule } from '@angular/router'; // Asegúrate de importar RouterModule
import { Router } from '@angular/router';  // Importar Router para redirigir
@Component({
  selector: 'app-menu-lateral',
  standalone: true,
  imports: [RouterModule], // Incluir RouterModule en imports
  templateUrl: './menu-lateral.component.html',
  styleUrls: ['./menu-lateral.component.css']
})
export class MenuLateralComponent {
  // Aquí va la lógica de tu componente si es necesario
  constructor(private router: Router) { }

  logout() {
    // Eliminar el token de autenticación (si lo estás usando)
    localStorage.removeItem('token'); // Aquí eliminamos el token de localStorage

    // Redirigir al usuario a la página de login
    this.router.navigate(['/login']);
}
}