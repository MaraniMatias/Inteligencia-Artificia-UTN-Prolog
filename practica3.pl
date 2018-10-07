% 1. Ingresar una cadena de texto y obtener el primer carácter de la misma.
ej_1 :-
  write('Ingrese una cadena: '),
  read(Cadena),
  sub_atom(Cadena, 0, 1, _, C),
  write('Cadena resultante: '),
  write(C).

% 2. Ingresar una cadena de texto y obtener el último carácter de la misma.
ej_2 :-
  write('Ingrese cadena: '),
  read(Cadena),
  atom_length(Cadena, A),
  R is A - 1,
  sub_atom(Cadena, R, 1, _, C),
  write(C).

% 3. Ingresar una cadena de texto e informar cuántos caracteres tiene.
% En primer lugar haciendo uso del predicado atom_length/2 y en una
% segunda instancia sin hacer uso de dicho predicado.
ej_3 :-
  read(C),
  longitud(C, Long),
  write(Long).

longitud('', 0).
longitud(C, Long) :-
  sub_atom(C, 0, 1, R, _),
  sub_atom(C, 1, R, _, C1),
  longitud(C1, L1),
  Long is L1 + 1.

% TODO
% 4. Transformar una cadena en una lista de caracteres.

% 5. Transformar una cadena de texto en una lista de palabras, tomando
% como divisor el espacio
ej_5 :-
  read(C),
  transformar(C, Lista),
  writeln(Lista).

transformar(C, [H|T]) :-
  sub_atom(C, PosEspacio, _, _, ' '),
  sub_atom(C, 0, PosEspacio, _, H),
  P is PosEspacio + 1,
  sub_atom(C, P, _, 0, C1),
  transformar(C1, T).
transformar(P, [P]).

% TODO:XXX
% 6. Hacer un programa que transforme un número entero a binario.
% TODO:XXX
% 7. Hacer un reconocedor de palabras de la forma a n b n .

% 8. Ingresar una cadena y un carácter, luego informar la cantidad de veces
% que aparece dicho carácter en la cadena.
ej_8 :-
  read(C),
  read(L),
  contar(C, L, Cont),
  write(Cont).

contar('', _, 0).
contar(C, L, Cont) :-
  sub_atom(C, 0, 1, R, L),
  sub_atom(C, 1, R, _, C1),
  contar(C1, L, Cont1),
  Cont is Cont1 + 1.
contar(C, L, Cont) :-
  sub_atom(C, 0, 1, R, _),
  sub_atom(C, 1, R, _, C1),
  contar(C1, L, Cont).

% 9. Ingresar una cadena, contar e informar el número de veces que aparece
% cada una de las vocales (a, e, i, o, u) y la cantidad de veces que
% aparece cualquier consonante.
es_vocal('a').
es_vocal('e').
es_vocal('i').
es_vocal('o').
es_vocal('u').

ej_9 :-
  write('Cadena: '), read(C),
  contar_vocales(C, Count),
  format('~nCantidad de caracteres ~w', [Count]).

contar_vocales('', 0).
contar_vocales(Cadena, Count) :-
  sub_atom(Cadena, 0, 1, R, Chart),
  sub_atom(Cadena, 1, R, _, SubCadena),
  es_vocal(Chart),
  contar_vocales(SubCadena, C),
  Count is C + 1.
contar_vocales(Cadena, Count) :-
  sub_atom(Cadena, 0, 1, R, _),
  sub_atom(Cadena, 1, R, _, SubCadena),
  contar_vocales(SubCadena, Count).

% TODO
% 10. Dada una cadena extraer las vocales y las consonantes,
% devolverlas en dos listas
