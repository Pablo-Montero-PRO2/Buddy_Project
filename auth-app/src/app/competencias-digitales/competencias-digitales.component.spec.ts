import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CompetenciasDigitalesComponent } from './competencias-digitales.component';

describe('CompetenciasDigitalesComponent', () => {
  let component: CompetenciasDigitalesComponent;
  let fixture: ComponentFixture<CompetenciasDigitalesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CompetenciasDigitalesComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CompetenciasDigitalesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
