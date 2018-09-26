% VARIANTES
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.a) Listar los animales que tenga almenos dos habitos de alimentacion distintos
% 3.b) Dado un animal cuantos habitos de reproducion tiene
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Hacer un programa que permita definir las cuentas a pagar del mes (luz, agua, alquiler,
% teléfono, cable, supermercado, etc.) de un grupo de personas.
% A su vez, deberá permitir ingresar el nombre de una de ellas e informar de todos sus gastos.
% calcular gasto mensual promedio por persona

:- dynamic(cuenta/4).
% cuenta(matias,luz,mes,2000).

guardar :-
  tell('./cuentas-db.pl'),
  listing(cuenta),
  told.

abrir :-
  retractall(cuenta(_,_,_,_)),
  consult('./cuentas-db.pl').

% Listar cuentas a pagar por una persona
opcion(1) :-
  writeln('Nombre:'),
  read(Persona),
  writeln('Servicio:'),
  read(Servicio),
  writeln('Mes (num):'),
  read(Mes),
  writeln('Monto:'),
  read(Monto),
  assertz(cuenta(Persona,Mes,Servicio,Monto)).

opcion(2) :-
  writeln('Nombre:'),
  read(Persona),
  writeln('Mes (num):'),
  read(Mes),
  pago_mensual(Persona,Mes,S,_),
  writeln(S).

opcion(3) :-
  writeln('Nombre:'),
  read(Persona),
  writeln('Mes (num):'),
  read(Mes),
  pago_mensual(Persona,Mes,S,C),
  P is S/C,
  writeln(P).

opcion(4) :-
  guardar.

menu :-
  abrir,
  format('~t<-oO MENU Oo->~t~72|~n~n'),
  writeln('Ingrese los elementos de una lista y para terminar [].'),
  format('Opciones:
    0  Salir y Guardar.
    1  Agregar cuenta
    2  Listar cuentas a pagar en un mes por una persona.
    3  Listar gasto mensul promedio para una persona.
    4  Guardar.
  '),
  read(OPC),
  format('Opcion elegida: [~w] ~n', [OPC]),
  OPC \= 0,
  opcion(OPC), nl,
  menu.

menu :-
  writeln('adios'),
  guardar.
  halt.

pago_mensual(Nombre,Mes,S,C) :-
  retract(cuenta(Nombre,Mes,_,I)),
  pago_mensual(Nombre,Mes,SP,CP),
  S is SP + I,
  C is CP + 1.
pago_mensual(_,_,0,0).


% 2. Hacer un programa que defina una Base de datos de personas de la
% siguiente forma:
% personas(codigo,nombre,edad).
% El programa debe permitir ingresar un código y verificar si el mismo está
% definido en la BBDD. De estarlo deberá informar a quién corresponde, de lo
% contrario deberá solicitar ingresar un nombre y registrar entonces la persona en la BBDD.
% a. Dada una edad devolver una lista con los nombres que tenga una edad mayor ala dada

% persona(cod,mombre,edad).
:- dynamic(persona/3).

lista_x_edad(E) :-
  lista_x_edad(E,Rta),
  write(Rta).

lista_x_edad(E,[H|T]) :-
  persona(_,H,EP),
  EP > E,
  retract(persona(_,H,EP)),
  lista_x_edad(E,T).

lista_x_edad(_,[]).

abrir_db_personas :-
  writeln('Abrir DB...'),
  retractall(persona(_,_,_)),
  consult('./personas-db.pl').

buscar(Cod) :-
  abrir_db_personas,
  persona(Cod,Nombre,_),
  writeln(Nombre).
buscar(Cod) :-
  writeln('No esta'),
  writeln('Nombre:'),
  read(Nombre),
  writeln('Edad:'),
  read(Edad),
  assertz(persona(Cod,Nombre,Edad)),
  tell('./personas-db.pl'),
  listing(persona),
  told.


