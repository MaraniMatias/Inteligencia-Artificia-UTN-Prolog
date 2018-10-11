/*
Socio(dni, apellido, sexo, edad)
Ejercicio(cod, descripcion, cod.nivel, sexo_recomendado, edad_desde, edad_hasta)
Asistencia(fecha, dni, min_entreno, [cod_ejercicios realizados])
Nivel(cod_nivel, descripcion, cant_hora_desde, cant_hora_hasta)
A tener en cuenta:
Nivel:
  inicial (de 0 hs a 72 hs)
  medio (de tanto a tanto)
  avanzado (de tanto a tanto)
  extremo (de tanto a tanto)
1. Ingresar un dni de un socio e informar:
  a. El nivel en el que se encuentra (teniendo en cuenta la asistencia)
  b. Los ejercicios que recomienda realizar de acuerdo a su nivel, sexo y edad.

2. Ingresar una fecha y un cod ejercicio e informar los socios que lo realizaron en esa fecha.
*/
abrirDB :-
  retractall(asistencia(_, _, _, _)),
  retractall(ejercicio(_, _, _, _, _, _)),
  retractall(nivel(_, _, _, _)),
  retractall(socio(_, _, _, _)),
  consult('./DB_final-25-02-16.pl').
?- abrirDB.
guardarDB :-
  tell('./DB_final-25-02-16.pl'),
  listing(asistencia),
  listing(ejercicio),
  listing(nivel),
  listing(socio),
  told.

% 1.a
nivel_socio(DNI) :-
  socio(DNI, Nombre, _, _),
  get_nivel_socio(DNI, Nivel),
  writeln(['Socio:',Nombre,'Nivel:', Nivel]).
nivel_socio(_) :-
  writeln('No encoramos persona con ese DNI :(').

get_nivel_socio(DNI, Nivel) :-
  get_nivel_socio(DNI, 0, Nivel).
get_nivel_socio(DNI, Nivel, Rta) :-
  asistencia(_, DNI, _, Ejercicios),
  retract(asistencia(_, DNI, _, Ejercicios)),
  get_nivel_ejercicios(Ejercicios, Nivel, NivelE),
  NivelE >= Nivel,
  get_nivel_socio(DNI, NivelE, Rta).
get_nivel_socio(DNI, Nivel, Rta) :-
  asistencia(_, _, _, _),
  get_nivel_socio(DNI, Nivel, Rta).
get_nivel_socio(_, Nivel, Nivel) :-
  abrirDB.

get_nivel_ejercicios([CodE|T], Nivel, Rta) :-
  ejercicio(CodE, _, NivelE, _, _, _),
  NivelE >= Nivel,
  get_nivel_ejercicios(T, NivelE, Rta).
get_nivel_ejercicios([_|T], Nivel, Rta) :-
  get_nivel_ejercicios(T, Nivel, Rta).
get_nivel_ejercicios([], Nivel, Nivel).

% 1.b
recomendar_eje(Nivel, Sexo, Edad) :-
  ejercicio(Cod, Des, Nivel, Sexo, EdadMin, EdadMax),
  retract(ejercicio(Cod, _, _, _, _, _)),
  EdadMin =< Edad,
  EdadMax >= Edad,
  writeln(['Cod:',Cod,'Des:',Des]),
  recomendar_eje(Nivel, Sexo, Edad).
recomendar_eje(Nivel, Sexo, Edad) :-
  ejercicio(Cod, _, Nivel, Sexo, _, _),
  recomendar_eje(Nivel, Sexo, Edad).
recomendar_eje(_, _, _) :-
  abrirDB.
