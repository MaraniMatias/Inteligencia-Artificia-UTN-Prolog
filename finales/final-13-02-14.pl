/*
Dada una BD con los siguientes hechos:
niño(nombre,edad,[vacunas_aplicadas]).
vacuna(vacuna,[enfermedades_que_combate]).
vacuna_aplicacion(edadDesde,edadHasta,[vacunas_a_aplicar]).

1) Ingresar un niño y en base a su edad indicar en una lista las vacunas que le faltan aplicar.
2) Ingresar un niño y una enfermedad.
    Para esa enfermedad, indicar una lista de las vacunas que la contrarrestan.
    Además, informar si el niño tiene puesta alguna de esas vacunas o le falta
    la aplicación de alguna dosis.
3)  Ingresar una vacuna e indicar la cantidad de niños que la tienen puesta.
*/

punto_1(Ninio) :-
  ninio(Nombre, Edad, Aplicadas),
  vacuna_aplicacion(EdadD, EdadH, Vacunas),
  retract(vacuna_aplicacion(_, _, _)),
  EdadD =< Edad,
  EdadH >= Edad,
  vacunas_que_faltan(Vacunas, Aplicadas, Faltantes),
  writeln(Faltantes).
punto_1(Ninio) :-
  vacuna_aplicacion(_, _, _),
  punto_1(Ninio).
punto_1(_) :-
  abrirDB.

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

vacunas_que_faltan([H|T], Vacunas, [H|T1]) :-
  not(pertenece(H, Vacunas)),
  vacunas_que_faltan(T, Vacunas, T1).
vacunas_que_faltan([_|T], Vacunas, Faltantes) :-
  vacunas_que_faltan(T, Vacunas, Faltantes).
vacunas_que_faltan(_, _, []).

punto_2(Nombre, Enfermedad) :-
  ninio(Nombre, _, Aplicadas),
  informar_vacunas_para(Enfermedad, ListaVacunas),
  vacunas_que_faltan(ListaVacunas, Aplicadas, Faltantes),
  vacunas_que_tiene(ListaVacun, Aplicadas, List),
  writeln(['Faltantes', Faltantes]),
  writeln(['Aplicadas', List]).

informar_vacunas_para(Enfermedad, [Vacuna|ListaVacun]) :-
  vacuna(Vacuna, EnfermedadesCombate),
  retract(vacuna(_, _)),
  pertenece(Enfermedad, EnfermedadesCombate),
  informar_vacunas_para(Enfermedad, ListaVacun).
informar_vacunas_para(Enfermedad, ListaVacun) :-
  vacuna(_, _),
  informar_vacunas_para(Enfermedad, ListaVacun).
informar_vacunas_para(Enfermedad, []) :-
  abrirDB.

vacunas_que_tiene([H|T], Aplicadas, [H|T1]) :-
  pertenece(H, Aplicadas),
  vacunas_que_tiene(T, Aplicadas, T1).
vacunas_que_tiene([_|T], Aplicadas, Lsit) :-
  vacunas_que_tiene(T, Aplicadas, List).
vacunas_que_tiene([], _, []).

punto_3(Vacuna) :-
  ninio(Nombre, _, Aplicadas),
  retract(ninio(_, _, _)),
  pertenece(Vacuna, Aplicadas),
  writeln(Nombre),
  punto_3(Vacuna).
punto_3(Vacuna) :-
  ninio(_, _, _),
  punto_3(Vacuna).
punto_3(_) :-
  abrirDB.
