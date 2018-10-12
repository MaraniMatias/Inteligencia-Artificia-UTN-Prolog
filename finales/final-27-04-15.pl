/*
lote(codLote, superficie, [dni], zona).
persona(dni, apellido, nombre).
lineaCredito(codLinea, descripcion, superficieDesde, SuperficieHasta, monto,[cuotas])

Una persona puede tener mas de un lote.
Cada linea de crédito puede pagarse en u numero distinto de cuotas 12, 24, 36 (Forma de financiación)
1 Ingresando un dni, devolver para cada lote la linea de crédito y el monto.
2 Ingresando un código de lote, devolver la linea de crédito y
    la máxima cantidad de cuotas de financiación.
*/

abrirDB_lotes :-
  retractall(lote(_, _, _, _)),
  consult('./DB_final-27-04-15_lote.pl').
abrirDB_lineaCredito :-
  retractall(lineaCredito(_, _, _, _, _, _)),
  consult('./DB_final-27-04-15_lineaCredito.pl').
abrirDB_personas :-
  retractall(persona(_, _, _)),
  consult('./DB_final-27-04-15_personas.pl').
abrirDB :-
  abrirDB_lotes,
  abrirDB_personas,
  abrirDB_lineaCredito.
?- abrirDB.
guardarDB :-
  tell('./DB_final-27-04-15.pl'),
  listing(lote),
  listing(persona),
  listing(lineaCredito),
  told.

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

punto_1(DNI) :-
  lote(IDLote, Superficie, Personas, Zona),
  retract(lote(IDLote, _, _, _)),
  pertenece(DNI, Personas),
  format('
    Linea De Credito para el lote: ~w
    Sup: ~w
    En Zona: ~w
  ~n', [IDLote, Superficie, Zona]),
  get_linea_credito(Superficie),
  punto_1(DNI).
punto_1(DNI) :-
  lote(_, _, _, _),
  punto_1(DNI).
punto_1(_) :-
  abrirDB.

get_linea_credito(Superficie) :-
  lineaCredito(CodLC, DesLC, SupMin, SupMax, MontoLC, _),
  retract(lineaCredito(CodLC, _, _, _, _, _)),
  SupMin < Superficie,
  SupMax > Superficie,
  writeln(['Cretito', CodLC, 'Des', DesLC, 'Monto', MontoLC]),
  get_linea_credito(Superficie).
get_linea_credito(Superficie) :-
  lineaCredito(_, _, _, _, _, _),
  get_linea_credito(Superficie).
get_linea_credito(_) :-
  abrirDB_lineaCredito.

punto_2(CodLote) :-
  lote(CodLote, Superficie, _ ,_),
  mejor_financiacion(Superficie, 0, Rta),
  writeln(Rta).

max_list([], Max, Max).
max_list([H|T], Max, Rta) :-
  H > Max,
  max_list(T, H, Rta).
max_list([_|T], Max, Rta) :-
  max_list(T, Max, Rta).

mejor_financiacion(Superficie, Max, Rta) :-
  lineaCredito(CodLC, _, SupMin, SupMax, _, Cuotas),
  retract(lineaCredito(CodLC, _, _, _, _, _)),
  SupMin < Superficie,
  SupMax > Superficie,
  max_list(Cuotas, Max, MaxNuevo),
  mejor_financiacion(Superficie, MaxNuevo, Rta).
mejor_financiacion(Superficie, Max, Rta) :-
  lineaCredito(_, _, _, _, _, _),
  mejor_financiacion(Superficie, Max, Rta).
mejor_financiacion(_, Max, Max) :-
  abrirDB_lineaCredito.

