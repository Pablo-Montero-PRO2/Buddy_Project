import { Component } from '@angular/core';
import { RouterModule } from '@angular/router'; // Importar RouterModule aquí

@Component({
  selector: 'app-menu-lateral',
  standalone: true,
  imports: [RouterModule], // Incluir RouterModule en imports
  templateUrl: './menu-lateral.component.html',
  styleUrls: ['./menu-lateral.component.css']
})
export class MenuLateralComponent {
  // Aquí va la lógica del componente si es necesario
}
