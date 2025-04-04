import { TestBed } from '@angular/core/testing';

import { MensajesNoLeidosService } from './mensajes-no-leidos.service';

describe('MensajesNoLeidosService', () => {
  let service: MensajesNoLeidosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MensajesNoLeidosService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
