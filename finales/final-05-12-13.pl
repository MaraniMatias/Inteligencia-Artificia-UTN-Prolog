/*
cantante(nombre_cantante,pais_origen)
album(nombre_album,nombre_cantante,[lista_temas]),fecha_edicion,copias_vendidas)
(El formato del campo fecha es dd/mm/aaaa)
1) Ingrese un album y una lista [] de temas y a partir de esto devolver una lista
  con aquellos temas de la lista original que correspondan al album ingresado.
2) Informar cuantos albumes fueron lanzados en un determinado año (dato de entrada)
  por cantantes de origen sueco.
3) Ingresar un cantante y devolver una lista con todos los albumes que haya
  lanzado a lo largo de su carrera y cuya cantidad de copias supere el millon.
*/

abrirDB :-
  retractall(album(_, _, _, _)),
  consult('./DB_final-05-12-13.pl').
% ?- abrir.

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

items_en_lista([H|T], Lista, [H|T1]) :-
  pertenece(H, Lista),
  items_en_lista(T, Lista, T1).
items_en_lista([_|T], Lista, Lista1) :-
  items_en_lista(T, Lista, Lista1).
items_en_lista([], _, []).

punto_1(Album, LsitTemas, TemasCompartidos) :-
  album(Album, _, TemasAlbum, _, _),
  items_en_lista(LsitTemas, TemasAlbum, TemasCompartidos).

punto_2(Anio, CantAlbum) :-
  album(_, Cantante, _, Fecha, _),
  retract(album(_, _, _, _, _)),
  sub_atom(Fecha, _, 4, 0, Anio),
  cantante(Cantante, sueco),
  punto_2(Anio, Cant),
  CantAlbum is Cant + 1.
punto_2(Anio, Cant) :-
  album(_, _, _, _, _),
  punto_2(Anio, Cant).
punto_2(_, 0) :-
  abrirDB.

punto_3(Cantante, [Album|T]) :-
  album(Album, Cantante, _, _, Ventas),
  retract(album(_, _, _, _, _)),
  Ventas > 100000,
  punto_3(Cantante, T).
punto_3(Cantante, T) :-
  album(_, _, _, _, _),
  punto_3(Cantante, T).
punto_3(_, []) :-
  abrirDB.




