/*
Dada la siguiente base de datos de hechos compuesta por hechos de la forma:

medicamentos(nombre,droga,presentación,laboratorio,[síntomas que contrarresta]).
composición(nombreMedicamento,componente,cantidad).

1) Ingresar una lista [] de síntomas que presenta un paciente e informar a través
  de una nueva lista [] los nombres de los medicamentos que contrarrestan al menos
  el 80% de los síntomas del paciente.
2) Ingresar dos componentes y sus respectivas cantidades e informar a
  través de una lista [] los nombres de los medicamentos que contienen dichos componentes
  y en la cantidad indicada.
*/
:- dynamic medicamento/5.
:- dynamic composicion/3.

read_list([H|T]) :-
  read(H),
  H \= [],
  read_list(T),
  !. % ! Elimina backtracking en el menu
read_list([]).

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

contar([], 0).
contar([H|T], C) :-
  contar(T, C1),
  C is C1 + 1.

abrirDB_medicamentos :-
  retractall(medicamento(_, _, _, _, _)),
  consult('./DB_final-29-08-13_medicamentos.pl').
:- abrirDB_medicamentos.
abrirDB_composicion :-
  retractall(composicion(_, _, _)),
  consult('./DB_final-29-08-13_composicion.pl').
:- abrirDB_composicion.

ele_comun([H|T], Lista ,[H|T1], Count) :-
  pertenece(H, Lista),
  ele_comun(T, Lista, T1, C1),
  Count is C1 + 1.
ele_comun([_|T], Lista , L1, Count) :-
  ele_comun(T, Lista ,  L1, Count).
ele_comun([], _,[], 0).


punto_1(ListSintomas, [Nombre|LM]) :-
  medicamento(Nombre, _, _, _, SintomasContraresta),
  retract(medicamento(_, _, _, _, _)),
  ele_comun(ListSintomas, SintomasContraresta, _, CountSintomasComunes),
  contar(ListSintomas, CountSintomas),
  Porc is CountSintomasComunes * 100 rdiv CountSintomas,
  Porc >= 80,
  punto_1(ListSintomas, LM).
punto_1(ListSintomas, ListMedicamentos) :-
  medicamento(_, _, _, _, _),
  punto_1(ListSintomas, ListMedicamentos).
punto_1(_, _) :-
  abrirDB_medicamentos.

punto_2(ListMedicamentos) :-
  write('Componente 1: '), read(C1),
  write('Cantidad: '), read(C1_cant),
  write('Componente 2: '), read(C2),
  write('Cantidad: '), read(C2_cant),
  buscar_componente(C1, C1_cant, ListMediC1),
  buscar_componente(C2, C2_cant, ListMediC2),
  ele_comun(ListMediC1, ListMediC2, ListMedicamentos).

buscar_medicamento(Compo, Cant, [Medicamento|T]) :-
  composicion(Medicamento, Compo, Cant),
  retract(composicion(Medicamento, Compo, Cant)),
  buscar_medicamento(Compo, Cant, T).
buscar_medicamento(_, _, []) :-
  abrirDB_composicion.
