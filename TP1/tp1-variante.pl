% Esta variante es para agregar costo a las conexiones.
%
%  Recorridos.
desde(ciudad1, ciudad2, 5).
desde(ciudad1, ciudad4, 2).
desde(ciudad2, ciudad3, 9).
desde(ciudad4, ciudad6, 8).
desde(ciudad4, ciudad5, 7).
desde(ciudad5, ciudad6, 3).
% punto d
desde(ciudad2, ciudad5, 2).
% punto e
desde(ciudad2, ciudad1, 6).

% Rebla permita establecer si es posible llegar desde la ciudad A hasta la ciudad B.

% Condición de fin
conexion(A, B, Costo) :-
  desde(A, B, Costo).

conexion(A, B, Costo) :-
  A \= B,
  desde(A, X, C1),
  conexion(X, B, C2),
  Costo is C1 + C2.

% Menu, creo que no tiene sentido usar un menu
menu:-
  write('<-oO Trabajo Practico Oo->'), nl,
  format('Para salir pulse 0 ~n Para continuar cualquier numero. ~n'),
  read(OPC), OPC \= 0,
  write('Ciudad de origen'), nl, read(C1),
  write('Ciudad de destino'), nl, read(C2),
  conexion(C1, C2, _), nl,
  menu.

menu:-
  write('adios').
