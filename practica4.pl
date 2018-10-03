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
  guardar,
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

% 3. Desarrollar un programa que permita definir los hábitos de:
%      • alimentación (comida, cantidad)
%      • bebida (bebida, cantidad)
%      • reproducción (época de reproducción, período de gestación)
%      • horas de sueño
%
% de un conjunto de animales de un Zoo.
% Dicha información se guardará en una base de datos.
% El programa, deberá permitir:

% alimentacion(comida, cantidad)
% bebida(bebida, cantidad)
% reproduccion(epoca,gestacion)
% horas_sueno(horas)
:- dynamic(animal/2).

guardarAnimalesDB :-
  tell('./animales-db.pl'),
  listing(animal),
  told.

abrirAnimalesDB :-
  retractall(animal(_, _)),
  consult('./animales-db.pl').

% a. Ingresar el nombre de un animal e informar de todos sus hábitos.
datos_animal(Animal) :-
  animal(Animal, Functor),
  writeln(Functor),
  retract(animal(Animal, Functor)),
  datos_animal(Animal).
datos_animal(_) :-
  abrirAnimalesDB.

% FIXME
% b. Ingresar un hábito e informar todos los animales que lo tienen.
datos_habito(Habito) :-
  animal(Animal, Habito),
  retractall(animal(Animal, _)),
  writeln(Animal),
  datos_habito(Habito).
datos_habito(_) :-
  abrirAnimalesDB.

% FIXME
% c) Listar los animales que tenga almenos dos habitos de alimentacion distintos
list_animlaes_habitos() :-
  animal(Animal, alimentacion(_, _)),
  list_animlaes_habitos(Animal).
list_animlaes_habitos(Animal) :-
  animal(Animal, alimentacion(_, _)),
  retract(animal(Animal, alimentacion(_, _))),
  writeln(Animal),
  list_animlaes_habitos(Animal).
list_animlaes_habitos(_) :-
  abrirAnimalesDB.

% d) Dado un animal cuantos habitos de reproducion tiene
datos_reproduccion(Animal, Count) :-
  animal(Animal, reproduccion(Epoca, Periodo)),
  retract(animal(Animal, reproduccion(_, _))),
  writeln([Animal,Epoca,Periodo]),
  datos_reproduccion(Animal, C),
  Count is C + 1.
datos_reproduccion(_, 0) :-
  abrirAnimalesDB.


