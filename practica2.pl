% Marte alas 18 consulta
q :- halt.

operacion(13, ListaA) :-
  writeln('Ingrese los elementos de la otra lista y para terminar [].'),
  read_list(ListaB),
  concat_list(ListA, ListB, List),
  writeln('Lista A:'), write_list(ListA),
  writeln('Lista B:'), write_list(ListB),
  writeln('A <> B:'), write_list(List).

operacion(12, Lista) :-
%   min_list(List, Min),
  min_in_list(Lista, Min),
  format('El minimo es: ~w', [Min]).

operacion(11, Lista) :-
%   max_list(List, Max),
  max_in_list(Lista, Max),
  format('El maximo es: ~w', [Max]).

operacion(10, Lista) :-
  writeln('Elemento a buscar:'), read(Ele),
  pertenece(Lista, Ele).

operacion(9, Lista) :-
  avg_list(Lista, S, C),
  format('Suma de los elementos: ~2f ~n Cantidad de elementos: ~2f ~n', [S, C]).

operacion(8, Lista) :-
  suma_element_list(Lista, Suma),
  writeln(Suma).

operacion(7, Lista) :-
  length_list(Lista, Length),
  writeln(Length).

operacion(6, Lista) :-
  firstElement_save(Lista, First),
  lastElement_save(Lista, Last),
  Rest is Last - First,
  format('~f - ~f = ~f',[Last, First, Rest]).

operacion(5, Lista) :-
  lastElement(Lista).

operacion(4, Lista) :-
  twoFirstElement(Lista).

operacion(3, Lista) :-
  firstElement(Lista).

operacion(2, Lista) :-
  separarHaedTail(Lista).

operacion(1, Lista) :-
  write(Lista).

operacion(_, _) :-
  writeln('Opcion invalida').

menu :-
  format('~t<-oO MENU Oo->~t~72|~n~n'),
  writeln('Ingrese los elementos de una lista y para terminar [].'),
  read_list(Lista),
  format('Opciones:
    0  Salir.
    1  Mostrar la lista.
    2  Separa cabeza y cola.
    3  Mostrar primer elemento.
    4  Mostrar los dos primero elementos.
    5  Ultimo elemento.
    6  Diferencia entre el ultimo y el primer elemento de la lista.
    7  Cuántos elementos tiene.
    8  Suma de los lementos de la lista.
    9  Valor promedio de los elemtos de la lista.
    10 Un elemento pertenece ala lista.
    11 Maximo valor.
    12 Minimo valor.
    13 Concatenar lista con otra.
  '),
  read(OPC),
  format('Opcion elegida: [~w] ~n', [OPC]),
  OPC \= 0,
  operacion(OPC, Lista), nl,
  menu.

menu :-
  writeln('adios'),
  halt.

% Ejercicio 1
% Ingresar una lista de elementos y mostrarla por pantalla.
% Ingresar elementos de auno y termina con [].
lista([1,2,3]).

read_list([Head|Tail]) :-
  read(Head),
  Head \= [],
  read_list(Tail),
  !. % ! Elimina backtracking en el menu
read_list([]).

write_list([]). % Solo para que de true
write_list([Head|Tail]) :-
  write(Head), nl,
  write_list(Tail).

% Ejercicio 2
% Ingresar una lista de elementos y mostrar su cabeza y su cola.
separarHaedTail([H|T]) :-
  write('Cabeza: '), writeln(H),
  write('Cola: '), write(T).

% Ejercicio 3
% Ingresar una lista de elementos y mostrar su primer elemento.
firstElement([H|_]) :-
  write('Cabeza: '), writeln(H).

% Ejercicio 4
% Ingresar una lista de elementos y mostrar sus dos primeros elementos.
twoFirstElement([H|[T|_]]) :-
  write('Primer elemento: '), writeln(H),
  write('Segundo elemento: '), writeln(T).

% Ejercicio 5
% Ingresar una lista de elementos y mostrar su último elemento.
lastElement([L]) :-
  write('Ultimo elemento: '), writeln(L).
lastElement([_|L]) :-
  lastElement(L).

% Ejercicio 6
% Ingresar una lista de números enteros y
% calcular la diferencia entre el primero y el último de ellos.
firstElement_save([H|_], First) :-
  First is H.

lastElement_save([L], List) :-
  List is L.
lastElement_save([_|L], List) :-
  lastElement_save(L, List).

% Ejercicio 7
% Ingresar una lista de elementos e informar cuántos elementos tiene.
length_list([], 0).
length_list([_|T], Length) :-
  length_list(T, S1),
  Length is S1 + 1.

% Ejercicio 8
% Ingresar una lista de números enteros e informar cuánto da la sumatoria de ellos.
suma_element_list([], 0).
suma_element_list([H|T], Suma) :-
  H \= [],
  suma_element_list(T, S1),
  number(H),
  Suma is H + S1.

% Ejercicio 9
% Ingresar una lista de números enteros y calcular su promedio. Respetar
% el formato del predicado promedio(L,S,C) donde L es la lista ingresada,
% S la sumatoria y C el contador de los elementos de la lista.
avg_list(L, S, C) :-
  length_list(L, C),
  suma_element_list(L, S),
  Avg is S / C,
  format('El promedio es: ~2f ~n', [Avg]).

avg_list_2([], 0, 0).

avg_list_2([H|T], Suma, Count) :-
  H \= [],
  number(H),
  avg_list_2(T, S, C),
  Count is C + 1,
  Suma is H + S.

avg_list_2(L, Avg) :-
  avg_list_2(L, S, C),
  Avg is S / C.

% Ejercicio 10
% Ingresar una lista y un elemento e informar si ese elemento está en la lista.
pertenece([Ele|_], Ele) :-
  writeln('Elemento pertenece a la lista'),
  !. % Para terminar la ejecucion

pertenece([_|Lista], Ele) :-
  pertenece(Lista, Ele).

pertenece(_, _) :-
  writeln('Elemento NO esta a la lista'),
  !. % Para terminar la ejecucion

% Ejercicio 11
%   Ingresar una lista de enteros e informar cuál es el mayor de todos los números.
%   max_list([1,2,3,5,5], Max)

max_in_list([H|T], Max) :-
  max_in_list(T, H, Max). % Inicio

max_in_list([], Max, Max). % Condicion de cierre

max_in_list([H|T], Value, Max) :-
  H >  Value,
  max_in_list(T, H, Max).

max_in_list([H|T], Value, Max) :-
  H =< Value,
  max_in_list(T, Value, Max).

% Ejercicio 12
%   Ingresar una lista de enteros e informar cuál es el menor de todos los números.
%   min_list([1,2,3,5,5], Max)

min_in_list([H|T], Min) :-
  min_in_list(T, H, Min). % Inicio

min_in_list([], Min, Min). % Condicion de cierre

min_in_list([H|T], Value, Min) :-
  H <  Value,
  min_in_list(T, H, Min).

min_in_list([H|T], Value, Min) :-
  H >= Value,
  min_in_list(T, Value, Min).

% Ejercicio pre-13
invest_list([], ListConcat, ListConcat).

invest_list([H|T], List, ListConcat) :-
  invest_list(T, [H|List], ListConcat).

invest_list([H|T], ListConcat) :- % Start
  invest_list(T, [H], ListConcat).

% Ejercicio 13
%   Ingresar dos listas de elementos, concatenarlas (los elementos deben
%   ser asignados de a uno en la lista de salida) y mostrarlas en una tercera.

concat_list(ListA, ListB, ListConcat) :-
  invest_list(ListA, List),
  concat_list_2(List, ListB, ListConcat).
% ------------------------------------------------------
concat_list_2([], ListConcat, ListConcat).

concat_list_2([H|T], List, ListConcat) :-
  concat_list_2(T, [H|List], ListConcat).
% ------------------------------------------------------
concat_list_1([H|T], [A|B], ListConcat) :-
  concat_list_1(T, B, [H|A], ListConcat).

concat_list_1([], [], ListConcat, ListConcat).

concat_list_1([H|T], [A|B], List, ListConcat) :-
  concat_list_1(T, B, [H,A|List], ListConcat).

concat_list_1([H|T], [], List, ListConcat) :-
  concat_list_1(T, [], [H|List], ListConcat).

concat_list_1([], [A|B], List, ListConcat) :-
  concat_list_1([], B, [A|List], ListConcat).
% ------------------------------------------------------
concat_list_ok([], [], []).
concat_list_ok([H1|T1], L2, [H1|T3]) :-
  concat_list_ok(T1, L2, T3).
concat_list_ok([], [H2|T2], [H2|T3]) :-
  concat_list_ok([], T2, T3).

% Ejercicio 14
%   Ingresar una lista y determinar el primer elemento que se repite.

find_in_list(X, [X|_], X) :- !.
find_in_list(X, [_|R], Ele) :-
  find_in_list(X, R, Ele).

find_in_list([H|T], Ele) :-
  find_in_list(H, T, Ele).

find_in_list([_|T], Ele) :-
  find_in_list(T, Ele).

% Ejercicio 15
%  Ingresar una lista y determinar a través de una segunda lista todos los
%  elementos que se repiten.
find_in_other_list(L1, L2, List) :-
  find_in_other_list(L1, L2, [], List, L1).

find_in_other_list([X|T], [X|B], L, List, AL1) :-
  find_in_other_list(T, [X|B], [X|L], List, AL1).

find_in_other_list([_|T], L2, L, List, AL1) :-
  find_in_other_list(T, L2, L, List, AL1).

find_in_other_list([], [_|B], L, List, AL1) :-
  find_in_other_list(AL1, B, L, List, AL1).

find_in_other_list([], [], List, List, _).
%------------------------------------------
find(Ele, [Ele|_]).
find(Ele, [_|List]) :-
  find(Ele, List).

pertain([], _, []).
pertain([H|T], List, [H|L]) :-
  find(H, List),
  pertain(T, List, L),
  not(find(H, L)).

pertain([_|T], List, L) :-
  pertain(T, List, L).
%------------------------------------------

% Ejercicio 16
%   Ingresar una lista y un elemento e informar cuántas veces está ese elemento en la lista.
count_ele_in_list(Ele, List, Rta) :-
  count_ele_in_list(Ele, List, 0, Rta).

count_ele_in_list(_, [], Count, Count).

count_ele_in_list(Ele, [Ele|T], Count, Rta) :-
  Count2 is Count + 1,
  count_ele_in_list(Ele, T, Count2, Rta).

count_ele_in_list(Ele, [_|T], Count, Rta) :-
  count_ele_in_list(Ele, T, Count, Rta).

% Ejercicio 17
%  En una base de hechos hay un registro de personas y viajes realizados:
%
%  persona(nombre, [lista ciudades visitó])
%
%  Construir una regla que permita verificar si una persona visitó una
%  determinada ciudad (datos de entrada: nombre persona y ciudad).
persona(romina, ['Casilda', 'Rosario']).
persona(matias, ['Casilda', 'Rosario', 'Paris', 'Cordoba']).

% ?- visito(matias, 'Casilda').
visito(Persona, Ciudad) :-
  persona(Persona, Lista),
  find(Ciudad, Lista).

% Ejercicio 18
%  En una nueva red social UTNook, se tiene la siguiente base de hechos (archivo UTNook.txt):
%
%   usuario(idUsuario, nombre, localidad).
%   intereses(idUsuario, [lista intereses]).
% Importar hechos :D
?- ['./UTNook.pl'].

%  Construir un programa en PROLOG que permita:
intereses_de(Usuario, Intereces) :-
  usuario(ID, Usuario, _),
  intereses(ID, Intereces).

%  a. Dados dos usuarios, mostrar una lista con los intereses que tienen en común.
intereces_en_comun(Usuario1, Usuario2, Intereces) :-
  % Buscar intecres de Usuario1
  intereses_de(Usuario1, InterecesUsuario1),
  % Buscar intecres de Usuario2
  intereses_de(Usuario2, InterecesUsuario2),
  find_in_other_list(InterecesUsuario1, InterecesUsuario2, Intereces).

%  b. Determinar si dos usuarios son candidatos a ser amigos.
%  Dos usuarios son candidatos a ser amigos cuando tienen al menos 2 intereses en común.
pueden_ser_amigos(Usuario1, Usuario2) :-
  intereces_en_comun(Usuario1, Usuario2, Intereces),
  length_list(Intereces, Length),
  Length > 2.

%  c. Dados dos usuarios, obtener una lista con todos los intereses de ambos (unión).
intereces_de(Usuario1, Usuario2, Intereces) :-
  % Buscar intecres de Usuario1
  intereses_de(Usuario1, InterecesUsuario1),
  % Buscar intecres de Usuario2
  intereses_de(Usuario2, InterecesUsuario2),
  concat_list_ok(InterecesUsuario1, InterecesUsuario2, Intereces).

%  d. Dada una ciudad, obtener una lista con los usuarios que viven en ella (utilizando el predicado findall/3).

