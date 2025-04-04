import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MensajesNoLeidosComponent } from './tutoria-notificacion.component';

describe('MensajesNoLeidosComponent', () => {
  let component: MensajesNoLeidosComponent;
  let fixture: ComponentFixture<MensajesNoLeidosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MensajesNoLeidosComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MensajesNoLeidosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
