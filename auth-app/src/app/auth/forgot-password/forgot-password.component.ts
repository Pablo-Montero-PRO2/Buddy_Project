import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
//import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';


@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  imports:  [
    CommonModule,
    //BrowserAnimationsModule,
    MatFormFieldModule, // Import MatFormFieldModule
    MatInputModule, // Import MatInputModule
    FormsModule,
    MatCardModule,
    ReactiveFormsModule],
  styleUrls: ['./forgot-password.component.css']
})
export class ForgotPasswordComponent {
  forgotPasswordForm: FormGroup;

  constructor(private fb: FormBuilder) {
    this.forgotPasswordForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]]
    });
  }

  onResetPassword() {
    if (this.forgotPasswordForm.valid) {
      console.log('Sending password reset email:', this.forgotPasswordForm.value.email);
      alert('Password reset email sent!');
    }
  }
}
