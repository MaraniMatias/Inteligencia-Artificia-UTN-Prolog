% Ejercicio 1
% Ingresar una lista de elementos y mostrarla por pantalla.
% Ingresar elementos de auno y termina con [].
lista([1,2,3]).

read_list([H|T]) :-
  read(H),
  H \= [],
  read_list(T).
read_list([]).

inicio :-
  writeln('Ingrese los elementos de una lista: '),
  read_list(Lista),
  write(Lista).

% Ejercicio 2
% Ingresar una lista de elementos y mostrar su cabeza y su cola.
separarHaedTail([H|T]) :-
  write('Cabeza: '), writeln(H),
  write('Cola: '), write(T).

inicio2 :-
  writeln('Ingrese los elementos de una lista: '),
  read_list(Lista),
  separarHaedTail(Lista).

% Ejercicio 3
% Ingresar una lista de elementos y mostrar su primer elemento.
firstElement([H|_]) :-
  write('Cabeza: '), writeln(H).

inicio3 :-
  writeln('Ingrese los elementos de una lista: '),
  read_list(Lista),
  separarHadTail(Lista).

% Ejercicio 4
% Ingresar una lista de elementos y mostrar sus dos primeros elementos.
twoFirstElement([H|[T|_]]) :-
  write('Primer elemento: '), writeln(H),
  write('Segundo elemento: '), writeln(T).

inicio4 :-
  writeln('Ingrese los elementos de una lista: '),
  read_list(Lista),
  twoFirstElement(Lista).

% Ejercicio 5
% Ingresar una lista de elementos y mostrar su último elemento.
lastElement([L]) :-
  write('Ultimo elemento: '), writeln(L).
lastElement([_|L]) :-
  lastElement(L).

inicio5 :-
  writeln('Ingrese los elementos de una lista: '),
  read_list(Lista),
  lastElement(Lista).

% Ejercicio 6
% Ingresar una lista de números enteros y
% calcular la diferencia entre el primero y el último de ellos.
firstElement_save([H|_], First) :-
  First is H.

lastElement_save([L], List) :-
  List is L.
lastElement_save([_|L], List) :-
  lastElement_save(L, List).

inicio6 :-
  writeln('Ingrese los elementos de una lista: '),
  read_list(Lista),
  firstElement_save(Lista, First),
  lastElement_save(Lista, Last),
  Rest is Last - First,
  format('~f - ~f = ~f',[Last, First, Rest]).

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

