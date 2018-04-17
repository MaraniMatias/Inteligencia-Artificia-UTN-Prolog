% definir para poder agregar hechos
:- dynamic(hombre/1).
:- dynamic(mujer/1).
:- dynamic(padres/3).

% assert(hombre(matias)).
hombre(cesar).

mujer(noemi).
mujer(romina).

% asserta(padres(matias,cesar,noemi)).
padres(romina,cesar,noemi).

% retract(padres(romina,cesar,noemi)).
% retractall(hombre(_)).
