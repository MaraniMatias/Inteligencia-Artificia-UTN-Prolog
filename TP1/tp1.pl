%  Recorridos.
desde(ciudad1,ciudad2).
desde(ciudad1,ciudad4).
desde(ciudad2,ciudad3).
desde(ciudad4,ciudad6).
desde(ciudad4,ciudad5).

% Rebla permita establecer si es posible llegar desde la ciudad A hasta la ciudad B.

% En caso de no encontrar una conexión.
conexion(_,_) :-
  writeln('No existe conexión').
% Condición de fin
conexion(A,B) :-
  desde(A,B).

conexion(A,B) :-
  desde(A,X),
  conexion(X,B).

% Menu
