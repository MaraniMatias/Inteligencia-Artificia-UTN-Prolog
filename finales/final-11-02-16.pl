/*
habitación(numero,descripción,[Lista de Cod. Caract.],precio x dia, estado)
característica(código,descripción)
Una habitación puede contener una cierta cantidad de características como por ejemplo
“WIFI, Heladera, Aire Acondicionado, etc”.
Una habitación pueda pasar por dos estados, “disponible” y “ocupada”.
Una habitación cuyo precio por día es mayor a $1000 se considera una habitación Premium.

1-Un usuario quiere saber las habitaciones disponibles según una
  lista de características que ingresa (Códigos),  donde se debe mostrar
  de cada habitación disponible, Descripción y Precio por día.
  Una habitación puede tener más características que las ingresadas por el usuario.
2-El gerente del hotel quiere regalarles un champan a cada habitación
  Premium que se encuentre ocupada en ese momento. Genere dicho informe.
*/

abrirDB :-
  retractall(habitacion(_, _, _, _, _)),
  retractall(caracteristica(_, _)),
  consult('./DB_final-11-02-16.pl').
?- abrirDB.
guardarDB :-
  tell('./DB_final-11-02-16.pl'),
  listing(habitacion),
  listing(caracteristica),
  told.

pertenece([Ele|_], Ele).
pertenece([_|T], Ele) :-
  pertenece(T, Ele).

% [Cod,Cod,...]
list_habitaciones(Caracteristicas) :-
  habitacion(Cod, Des, CaracteristicasHabitacion, Precio, disponible),
  retract(habitacion(Cod, _, _, _, disponible)),
  buscar_caracteristicas(Caracteristicas, CaracteristicasHabitacion),
  writeln(['Des',Des,'Precio',Precio]),
  list_habitaciones(Caracteristicas).
list_habitaciones(Caracteristicas) :-
  habitacion(_, _, _, _, disponible),
  list_habitaciones(Caracteristicas).
list_habitaciones(_) :-
  abrirDB.

buscar_caracteristicas([H|T], List) :-
  pertenece(List, H),
  buscar_caracteristicas(T, List).
buscar_caracteristicas([], _).

informe :-
  habitacion(Cod, Des, _, Precio, ocupada),
  retract(habitacion(Cod, _, _, _, ocupada)),
  Precio > 100,
  writeln(['Cod',Cod,'Des',Des]),
  informe.
informe :-
  habitacion(_, _, _, _, ocupada),
  informe.
informe :-
  abrirDB.
