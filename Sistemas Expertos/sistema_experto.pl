% TODO: algo mas parecido a eli
:- dynamic alergia/3.
:- dynamic sintoma/2.

abrir_db_alergia :-
  retractall(alergia(_, _, _)),
  consult('./DB/alergias.pl').
abrir_db_sintomas :-
  retractall(sintoma(_, _)),
  consult('./DB/sintomas.pl').
abrir_db :-
  abrir_db_alergia,
  abrir_db_sintomas.
:- abrir_db. % DB lista para usarce

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

% split_word(Input, WordsList) :-
%   split_string(Input, ' ', ',', WordsList).
read_to_string(String, WordList) :-
  read_line_to_codes(user_input, Cs),
  atom_codes(String, Cs),
  atomic_list_concat(AtomList, ' ', String),
  split_string(String, ' ', ',', WordList).

alergiaSam :-
  % abrir_db,
  writeln('Contame que sintomas tenes'),
  read_to_string(String, WordList),
  % TODO limpiar palabras como: tengo, me duele ...
  writeln(String),
  writeln(WordList).

inicio :-
  writeln('Buen día!, Soy Alergia-Sam'),
  writeln('Estaré ayudándote para poder descubrir tus alergias.'),
  % writeln('Empezamos? S/n'),
  % read(OPC),
  % OPC \= 'n', OPC \= 'N',
  alergiaSam.

inicio :-
  writeln('Ups, que mal!'),
  writeln('Nos veremos la próxima!').
:- inicio.
