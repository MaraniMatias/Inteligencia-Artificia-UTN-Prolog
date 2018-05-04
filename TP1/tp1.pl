%  Recorridos.
desde(ciudad1,ciudad2).
desde(ciudad1,ciudad4).
desde(ciudad2,ciudad3).
desde(ciudad4,ciudad6).
desde(ciudad4,ciudad5).

% Rebla permita establecer si es posible llegar desde la ciudad A hasta la ciudad B.

% Condición de fin
conexion(A,B) :-
  desde(A,B).

conexion(A,B) :-
  desde(A,X),
  conexion(X,B).

% En caso de no encontrar una conexión.
conexion(_,_) :-
  writeln('No existe conexión').

% Menu
menu:-
  write('<-oO Trabajo Practico Oo->'), nl,
  format('Para salir pulse 0 ~n'),
  read(OPC), OPC \= 0,
  write('Ciudad de origen'), nl, read(C1),
  write('Ciudad de destino'), nl, read(C2),
  conexion(C1,C2), nl,
  menu.

menu:-
  write('adios').
