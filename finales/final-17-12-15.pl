/*
La base de hechos estaba formada por:
cancion(IdCaGncion,Nombre,Artista,Duración,Genero)
invitados(Nombre, [IdCanciones que gusta])
1- Listar las canciones que le gusta a más del 80% de los invitados.
2- Listar las canciones de género "vals" que duren más de 15 minutos.
*/

abrirDB_invitados :-
  retractall(invitado(_, _)),
  consult('./DB_final-17-12-15_invitados.pl').
?- abrirDB_invitados.
abrirDB_canciones:-
  retractall(cancion(_, _, _, _, _)),
  consult('./DB_final-17-12-15_cancion.pl').
?- abrirDB_canciones.

contar_invitados(Rta) :-
  invitado(_, _),
  retract(invitado(_, _)),
  contar_invitados(Cant),
  Rta is Cant + 1.
contar_invitados(0) :-
  abrirDB_invitados.

pertenece([Ele|_], Ele).
pertenece([_|T], Ele) :-
  pertenece(T, Ele).

cuantos_favoritos(IDcancion, CantFavorito) :-
  invitado(_, Favoritos),
  retract(invitado(_, _)),
  pertenece(Favoritos, IDcancion),
  cuantos_favoritos(IDcancion, Algo),
  CantFavorito is Algo + 1.
cuantos_favoritos(IDcancion, CantFavorito) :-
  invitado(_, _),
  cuantos_favoritos(IDcancion, CantFavorito).
cuantos_favoritos(_, 0) :-
  abrirDB_invitados.

listar_favoritos() :-
  cancion(IDcancion, Nombre, _, _, _),
  cuantos_favoritos(IDcancion, CantFavorito),
  contar_invitados(CantInvitados),
  retract(cancion(IDcancion, _, _, _, _)),
  Porc is CantFavorito * 100 rdiv CantInvitados,
  informar(Porc, IDcancion, Nombre),
  listar_favoritos().
listar_favoritos() :-
  abrirDB_invitados,
  abrirDB_canciones.
informar(Porc, ID, Nombre) :-
  Porc >= 80, % Porc > 79.999
  writeln([ID, Nombre]).
informar(_, _, _).

lista_vals_XL() :-
  cancion(ID, Nombre, _, Duracion, vals),
  retract(cancion(_, _, _, _, vals)),
  Duracion > 150,
  writeln([ID, Nombre]),
  lista_vals_XL().
lista_vals_XL() :-
  cancion(ID, Nombre, _, Duracion, vals),
  lista_vals_XL.
lista_vals_XL():-
  abrirDB_canciones.

