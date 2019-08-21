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

% 4. Transformar una cadena en una lista de caracteres.
ej_4 :-
  write('Ingrese una cadena de caracteres: '),
  read(Cadena),
  convertir(Cadena,Lista),
  write(Lista).

convertir(Cadena,[H|T]) :-
  sub_atom(Cadena,0,1,_,H),
  sub_atom(Cadena,1,_,0,SubCadena),
  convertir(SubCadena,T).
convertir('',[]).

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

% 6. Hacer un programa que transforme un número entero a binario.

ej_6 :-
  write('Ingrese un nro entero: '),
  read(NroEntero),
  NroEntero\=0,
  calcularBin(NroEntero,NroBinarioReves),
  reverse(NroBinarioReves,[],Binario),
  write('El binario es: '),
  write(Binario).

ej_6 :-
  writeln('El binario es: '),
  write(0).

calcularBin(0,[]).
calcularBin(NroEntero,[H1|T1]) :-
  NroEntero\=0,
  Div is NroEntero//2,
  calcularBin(Div,T1),
  H1 is NroEntero mod 2.

reverse([], Zs, Zs).
reverse([X|Xs], Ys, Zs):-
          reverse(Xs, [X|Ys], Zs).

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

% 10. Dada una cadena extraer las vocales y las consonantes,
% devolverlas en dos listas
ej_10 :-
  write('Cadena: '), read(C),
  extraer_vocales_consonantes(C, Vocales, Consonantes),
  format('~nVocales: ~w~nConsonates: ~w', [Vocales, Consonantes]).

extraer_vocales_consonantes('', [], []).
extraer_vocales_consonantes(Cadena, [Vocal|Tv], Consonantes) :-
  sub_atom(Cadena, 0, 1, R, Vocal),
  sub_atom(Cadena, 1, R, _, SubCadena),
  es_vocal(Vocal),
  extraer_vocales_consonantes(SubCadena, Tv, Consonantes).

extraer_vocales_consonantes(Cadena, Vocales, [Consonante|Tc]) :-
  sub_atom(Cadena, 0, 1, R, Consonante),
  sub_atom(Cadena, 1, R, _, SubCadena),
  extraer_vocales_consonantes(SubCadena, Vocales, Tc).

% 11 ingreser dos cadenas y mostrar la unión en una lista.
ej_11():-
  writeln('Cadena 1: '),
  read(C1),
  writeln('Cadena 2: '),
  read(C2),
  join_cadena(C1, C2, C12),
  writeln(C12).

join_cadena(C1, C2, L3) :-
  cadena_to_list(C1, L1),
  cadena_to_list(C2, L2),
  join_list(L1, L2, L3).

cadena_to_list(C, [H|T]) :-
  sub_atom(C, 0, 1, R, H),
  sub_atom(C, 1, R, _, C1),
  cadena_to_list(C1, T).
cadena_to_list('', []).

join_list([], [], []).
join_list([H|T], List, [H|T2]) :-
  join_list(T, List, T2).
join_list([], List, L) :-
  join_list(List, [], L).
