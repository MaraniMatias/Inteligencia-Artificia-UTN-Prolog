q :- halt.

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
  writeln('<-oO MENU Oo->'),
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
  '),
  read(OPC),
  format('Opcion elegida: [~w] ~n', [OPC]),
  OPC \= 0,
  operacion(OPC, Lista), nl,
  menu.

menu :-
  writeln('adios').

% Ejercicio 1
% Ingresar una lista de elementos y mostrarla por pantalla.
% Ingresar elementos de auno y termina con [].
lista([1,2,3]).

read_list([H|T]) :-
  read(H),
  H \= [],
  read_list(T),
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
