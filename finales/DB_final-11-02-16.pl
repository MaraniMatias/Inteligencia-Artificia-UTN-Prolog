:- dynamic habitacion/5.
:- dynamic caracteristica/2.

% habitación(numero,descripción,[Lista de Cod. Caract.],precio x dia, estado)
habitacion(2, 'Habitacion 2', [01], 4, disponible).
habitacion(4, 'Habitacion 4', [01, 02], 16, ocupada).
habitacion(8, 'Habitacion 8', [01, 02, 03], 64, ocupada).
habitacion(16, 'Habitacion 16', [01, 02, 04], 256, disponible).
habitacion(32, 'Habitacion 32', [01, 02, 03, 04], 1024, ocupada).
habitacion(64, 'Habitacion 64', [01, 02, 03, 04, 04], 2048, disponible).
% característica(código,descripción)
caracteristica(01,'WIFI').
caracteristica(02,'Heladera').
caracteristica(03,'Aire Acondicionado').
caracteristica(04,'etc').





