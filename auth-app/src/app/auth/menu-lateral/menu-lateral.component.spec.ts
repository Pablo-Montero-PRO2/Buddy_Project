import { ComponentFixture, TestBed } from '@angular/core/testing';
import { MenuLateralComponent } from './menu-lateral.component';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { RouterTestingModule } from '@angular/router/testing';

describe('MenuLateralComponent', () => {
  let component: MenuLateralComponent;
  let fixture: ComponentFixture<MenuLateralComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MenuLateralComponent, HttpClientTestingModule, RouterTestingModule]
    }).compileComponents();

    fixture = TestBed.createComponent(MenuLateralComponent);
    component = fixture.componentInstance;
    component.cantidadMensajes = 0; // 👈 Esto evita el error
    fixture.detectChanges();
  });

  it('debería crearse correctamente', () => {
    expect(component).toBeTruthy();
  });
});
