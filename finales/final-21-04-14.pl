/*
Se tienen hechos definidos como
  película (nombre, genero, [directores], [actores], fecha_estreno, pais_estreno).
Formato de fecha: dd/mm/aaaa
1) Ingresar el nombre de un actor. Mostrar la lista [] de películas en las que actuó.
2) Mostrar una lista [] de las películas que tienen 2 directores o más.
3) Ingresar un año y un país, y decir cuantas películas se estrenaron en ese país y en ese año.
*/

abrirDB :-
  retractall(pelicula(_, _, _, _, _, _)),
  consult('./DB_final-21-04-14.pl').
?- abrirDB.
guardarDB :-
  tell('./DB_final-11-02-16.pl'),
  listing(pelicula),
  told.

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

contar([_|T], C) :-
  contar(T, C1),
  C is C1 + 1.
contar([], 0).

list_peliculas(Actor, [pelicula(N, G, D, A, F, P)|T]) :-
  pelicula(N, G, D, A, F, P),
  retract(pelicula(N, G, D, A, F, P)),
  pertenece(Actor, A),
  list_peliculas(Actor, T).
list_peliculas(Actor, Pelis) :-
  pelicula(_, _, _, _, _, _),
  list_peliculas(Actor, Pelis).
list_peliculas(_, []) :-
  abrirDB.

punto_2([pelicula(N, G, D, A, F, P)|T]) :-
  pelicula(N, G, D, A, F, P),
  retract(pelicula(N, G, D, A, F, P)),
  contar(D, CountD),
  CountD >= 2,
  punto_2(T).
punto_2(Pelis) :-
  pelicula(_, _, _, _, _, _),
  punto_2(Pelis).
punto_2([]) :-
  abrirDB.

punto_3(Anio, Pais, CountPelis) :-
  pelicula(_, _, _, _, F, Pais),
  retract(pelicula(_, _, _, _, F, Pais)),
  sub_atom(F, _ , 4, 0, Anio),
  punto_3(Anio, Pais, CP1),
  CountPelis is CP1 + 1.
punto_3(Anio, Pais, CountPelis) :-
  pelicula(_, _, _, _, _, Pais),
  punto_3(Anio, Pais, CountPelis).
punto_3(_, _, 0) :-
  abrirDB.

