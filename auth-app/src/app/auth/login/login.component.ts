//import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    // BrowserAnimationsModule,
    MatFormFieldModule,
    MatInputModule,
    MatCardModule,
    MatButtonModule,
    FormsModule,
    ReactiveFormsModule
  ],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  loginForm: FormGroup;
  errorMessage: string = '';

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router
  ) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required]
    });
    console.log('LoginComponent cargado');
  }

  onLogin() {
    if (this.loginForm.invalid) {
      console.error("El formulario no es válido");
      return;
    }

    const { email, password } = this.loginForm.value;

    this.authService.login(email, password).subscribe({
      next: (response) => {
        console.log("Login exitoso:", response);
        localStorage.setItem('token', response.token);
        localStorage.setItem('user', JSON.stringify(response.user));
        this.router.navigate(['/inicio']);
      },
      error: (err) => {
        console.error("Error en el login:", err);
        if (err.status === 404) {
          this.errorMessage = 'Este correo no está registrado.';
        } else if (err.status === 400) {
          this.errorMessage = 'Credenciales incorrectas.';
        } else {
          this.errorMessage = 'Error en el inicio de sesión.';
        }
      },
    });
  }
}
