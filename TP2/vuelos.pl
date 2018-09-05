% Importar hechos :D
?- ['./vuelos.txt']. % vuelo(origen, destino, tiempo)

% Inicio del programa
inicio :-
  writeln('Ingrese la ciudad de origen: '),
  read(CiudadOrigen),
  writeln('Ingrese la ciudad de destino: '),
  read(CiudadDestino),
  writeln('Desea itinerario con la menor cantidad de transbordos posibles? [s/n]'),
  read(Opcion),
  operacion(CiudadOrigen,CiudadDestino,Opcion).

% Opciones disponibles
operacion(CiudadOrigen,CiudadDestino,Opcion) :-
  Opcion='s',
  calculaRutaAnch(CiudadOrigen,CiudadDestino).
operacion(CiudadOrigen,CiudadDestino,Opcion) :-
  Opcion='n',
  calculaRutaProf(CiudadOrigen,CiudadDestino).

operacion(_,_,_) :-
  writeln('Opcion no disponible'), !,
  inicio.

% Generar el próximo estado
sucesor(A,B) :-
  vuelo(A,B,_).
sucesor(A,B) :-
  vuelo(B,A,_).

% Utilidades
pertenece(X,[X|_]).
pertenece(X,[_|T]) :-
  pertenece(X,T).

concatenar([],[],[]).
concatenar([H1|T1],L2,[H1|T3]) :-
  concatenar(T1,L2,T3).
concatenar([],[H2|T2],[H2|T3]) :-
  concatenar([],T2,T3).

write_list([]). % Solo para que de true
write_list([Head|Tail]) :-
  write(Head), nl,
  write_list(Tail).

% Busqueda en profundidad
% -----------------------
calculaRutaProf(Inicio, Meta) :-
  buscaRutaProf(Inicio, Meta, [Inicio], Sol),
  reverse(Sol, Sol2),
  write_list(Sol2).
% Si el estado actual es la meta, devolver la ruta recorrida como solución
buscaRutaProf(Estado, Meta, Ruta, Sol) :-
  (Estado = Meta),
  reverse(Ruta, Sol),
  calculaDistancia(Sol, 0).
% Generar un sucesor del estado actual. Si no fue visitado agregarlo a la ruta
buscaRutaProf(Estado, Meta, Ruta, Sol) :-
  sucesor(Estado,NuevoEstado),
  not(pertenece(NuevoEstado, Ruta)),
  buscaRutaProf(NuevoEstado, Meta, [NuevoEstado|Ruta], Sol).

calculaDistancia([_],Suma) :-
  format('El tiempo de vuelo es: ~0f min~n', [Suma]).
calculaDistancia([H|[H2|T]],Suma) :-
  vuelo(H,H2,Dist),
  SumaParcial is Suma + Dist,
  calculaDistancia([H2|T],SumaParcial).
calculaDistancia([H|[H2|T]],Suma) :-
  vuelo(H2,H,Dist),
  SumaParcial is Suma + Dist,
  calculaDistancia([H2|T],SumaParcial).

% Busqueda en anchura
% -------------------
calculaRutaAnch(Inicio, Meta) :-
  buscaRuta([[Inicio]], Meta, Sol),
  reverse(Sol, Sol2),
  write_list(Sol2).
% Si el estado actual es la meta, devuelvo toda la ruta hacia el mismo
buscaRuta([[Estado|Ruta]|_], Estado, [Estado|Ruta]).
% Generar las rutas sucesoras y agregarlas a Lista-Nodos, descartando la primera
buscaRuta([PrimerRuta|OtrasRutas], Meta, Sol) :-
  expandir(PrimerRuta, NuevasRutas),
  concatenar(OtrasRutas, NuevasRutas, NuevaListaNodos),
  buscaRuta(NuevaListaNodos, Meta, Sol).

% generamos las rutas sucesoras
expandir([Estado|Ruta], NuevasRutas):-
  findall([NuevoEstado, Estado|Ruta], (
    sucesor(Estado, NuevoEstado),
    not(pertenece(NuevoEstado, [Estado|Ruta])
  )),
  NuevasRutas).
% si no hay rutas sucesoras
expandir(_,[]).
