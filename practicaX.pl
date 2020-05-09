/*
Elabora un programa en prolog donde al ingresar una cadena de la
extensión que se desee me cuente las vocales que esta contenga,
se delimitará la cadena con el caracter especial "<",
un vez finalizado, me deberá de indicar
el número de letras (A),
el número de vocales (B)
y se deberá calcular lo siguiente:

Calcular si A es un número perfecto.
Calcular si B es primo.

Mostrar todo el resultado

Te aconsejo revisar apuntes anteriores para lograr dicho programa.

Entrada:
Manuel Alejandro Mex Mena<

Salida:
L= 10
A= 25
B= 10

A no es perfecto y B no es primo
*/

% Vocales
es_vocal('a').
es_vocal('e').
es_vocal('i').
es_vocal('o').
es_vocal('u').
es_vocal('A').
es_vocal('E').
es_vocal('I').
es_vocal('O').
es_vocal('U').

no_es_vocal(Letter) :-
    member(Letter, ['q','w','r','t','y','p','s','d','f','g','h','j','k','l','ñ','z','x','c','v','b','n','m','Q','W','R','T','Y','P','S','D','F','G','H','J','K','L','Ñ','Z','X','C','V','B','N',',','M']).

% Para terminar recucividad e iniciar contador
contar_vocales_letras('<', 0, 0, 0).
% Contar si es vocal
contar_vocales_letras(Cadena, CountV, CountL, Resto) :-
  sub_atom(Cadena, 0, 1, R, Chart),
  sub_atom(Cadena, 1, R, _, SubCadena),
  es_vocal(Chart),
  contar_vocales_letras(SubCadena, C, CountL, Resto),
  CountV is C + 1.
% Contar si No es vocal
contar_vocales_letras(Cadena, CountV, CountL, Resto) :-
  sub_atom(Cadena, 0, 1, R, Chart),
  sub_atom(Cadena, 1, R, _, SubCadena),
  no_es_vocal(Chart),
  contar_vocales_letras(SubCadena, CountV, C, Resto),
  CountL is C + 1.
% Otro caracter y continuar recurcividad
contar_vocales_letras(Cadena, CountV, CountL, Resto) :-
  sub_atom(Cadena, 0, 1, R, _),
  sub_atom(Cadena, 1, R, _, SubCadena),
  contar_vocales_letras(SubCadena, CountV, CountL, C),
  Resto is C + 1.

% Es perfecto si, es un entero positivo que es igual a la suma de sus divisores propios positivos.
% Así, 6 es un número perfecto porque sus divisores propios son 1, 2 y 3; y 6 = 1 + 2 + 3.
% Los siguientes números perfectos son 28, 496 y 8128.

suma_element_list([], 0).
suma_element_list([H|T], Suma) :-
  H \= [],
  suma_element_list(T, S1),
  number(H),
  Suma is H + S1.

get_divisores(Num, Divisores) :-
  get_divisores(Num, Num, Divisores).

get_divisores(_, 1, []).
get_divisores(Num, Aux, [Div|T]) :-
  Num > 0,
  Div is Aux - 1,
  Div > 0,
  0 is mod(Num, Div),
  get_divisores(Num, Div, T).
get_divisores(Num, Aux, T) :-
  Num > 0,
  A is Aux - 1,
  A > 0,
  get_divisores(Num, A, T).

es_perfecto(Num) :-
  get_divisores(Num, Divisores),
  % write(Divisores),
  suma_element_list(Divisores, Suma),
  es_perfecto(Num, Suma).
es_perfecto(Suma, Suma) :- write("Es perfecto").
es_perfecto(_, _) :- write("No es perfecto").

% un número primo es un número natural mayor que 1
% que tiene únicamente dos divisores distintos: él mismo y el 1.

es_primo(Num) :-
  % 0 is mod(Num,Num),
  get_divisores(Num, Divisores),
  es_primo(Num, Divisores).
es_primo(_, [1]) :- writeln("Es primo").
es_primo(_, _) :- writeln("No es primo").

program :-
  % write('Cadena: '), read(C), % terminar con <
  % contar_vocales_letras(C, CountVocales, CountNVocales, Resto),
  contar_vocales_letras('Manuel Alejandro Mex Mena<', CountVocales, CountNVocales, Resto),
  CountLetras is CountVocales + CountNVocales,
  Caracteres is  CountLetras + Resto,
  format('~nCaracteres (A): ~w~nNo Vocales: ~w~nVocales: ~w~nLetras: ~w~n~n', [Caracteres, CountNVocales, CountVocales, CountLetras]),
  write('A '),
  es_perfecto(Caracteres), nl,
  write('B '),
  es_primo(CountVocales).
:- program.

