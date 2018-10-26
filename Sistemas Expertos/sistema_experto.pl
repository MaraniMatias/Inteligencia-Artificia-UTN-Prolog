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

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

read_to_string(String, WordList) :-
  read_line_to_codes(user_input, Cs),
  atom_codes(String, Cs),
  % atomic_list_concat(AtomList, ' ', String),
  atomic_list_concat(_, ' ', String),
  string_lower(String, S2),
  % TODO remplazar asentos por vocal sin acentos
  % tambien hacer esto en sintomas :D
  % FIXME split_string(S2, ' ', ',', WordList).
  split_string(S2, ' ,', ',', WordList).

find_sintoma_by_word(Word, ID) :-
  sintoma(ID, Sintoma),
  retract(sintoma(ID, Sintoma)),
  string_to_atom(Word, Atom),
  sub_atom(Sintoma, _, _, _, Atom),
  write([ID,Sintoma]), write('--') ,writeln(Word).

search_sintomas([], []).
search_sintomas([Word|T], [ID| Sintomas]) :-
  abrir_db_sintomas,
  Word \= '', Word \= "",
  find_sintoma_by_word(Word, ID),
  search_sintomas(T, Sintomas).
search_sintomas([_|T], Sintomas) :-
  search_sintomas(T, Sintomas).

alergiaSam :-
  % abrir_db,
  % TODO preguntar primero si podes describir los sintomas
  writeln('Contame que sintomas tenes, (Separados por coma)'),
  read_to_string(_, WordList), % TODO limpiar palabras como: tengo, me duele ...
  writeln(WordList),
  % Buscar sintomas en nuesta DB
  search_sintomas(WordList, ListSintomas), writeln(ListSintomas)
  .

inicio :-
  abrir_db,
  writeln('VERSION v0 BASTANTE TONTA :P'),
  writeln('Buen día!, Soy Alergia-Sam'),
  writeln('Estaré ayudándote para poder descubrir tus alergias.'),
  % writeln('Empezamos? S/n'),
  % read(OPC),
  % OPC \= 'n', OPC \= 'N',
  alergiaSam.

inicio :-
  writeln('Ups, que mal!'),
  writeln('Nos veremos la próxima!').
% :- inicio.
