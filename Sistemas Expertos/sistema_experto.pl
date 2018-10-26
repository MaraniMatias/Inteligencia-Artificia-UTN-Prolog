% TODO: algo mas parecido a eli
:- dynamic alergia/3.
:- dynamic sintoma/2.

/**********************************************************************************/
abrir_db_alergia :-
  retractall(alergia(_, _, _)),
  consult('./DB/alergias.pl').
abrir_db_sintomas :-
  retractall(sintoma(_, _)),
  consult('./DB/sintomas.pl').
abrir_db :-
  abrir_db_alergia,
  abrir_db_sintomas.
/**********************************************************************************/

pertenece(Ele, [Ele|_]).
pertenece(Ele, [_|T]) :-
  pertenece(Ele, T).

/**********************************************************************************/
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

/**********************************************************************************/
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

/**********************************************************************************/

pertenece_sintoma_peso(ID, [sintoma_peso(ID, _)|_]).
pertenece_sintoma_peso(ID, [_|T]) :-
  pertenece_sintoma_peso(ID, T).

find_sintomas_in_list([], _).
find_sintomas_in_list([ID|T], ListSintomaPeso) :-
  pertenece_sintoma_peso(ID, ListSintomaPeso),
  find_sintomas_in_list(T, ListSintomaPeso).

% ListSintomas, ListAlergias
% TODO ordenar por prioridad, alergia que tenga mayor chanse de ser la
% correcta segun los sintomas
find_alergias([], _) :- fail.
find_alergias(ListIDSintoma, [ID|Alergias]) :-
  alergia(ID, _, ListSintomaPeso),
  retract(alergia(ID, _, _)),
  find_sintomas_in_list(ListIDSintoma, ListSintomaPeso),
  find_alergias(ListIDSintoma, Alergias).
find_alergias(ListIDSintoma, Alergias) :-
  alergia(_, _, _),
  find_alergias(ListIDSintoma, Alergias).
find_alergias(_, []) :-
  abrir_db_alergia.

/**********************************************************************************/
% La idea obtener un valor para cada alergia, que tenga mejor proiridad de ser

max_sintoma_peso([], Max, Max).
max_sintoma_peso([sintoma_peso(_,H)|T], Value, Max) :-
  H >  Value,
  max_sintoma_peso(T, H, Max).
max_sintoma_peso([_|T], Value, Max) :-
  max_sintoma_peso(T, Value, Max).

% Lista de sintoma pesos para los ID de sintomas
filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun):-
  filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun, ListSintomaPeso).
filter([ID|T], [sintoma_peso(ID, Peso)|_], [sintoma_peso(ID, Peso)|T2], AuxList) :-
  filter(T, AuxList, T2, AuxList).
filter(List, , [_|T], ListSintomaPesoComun, AuxList) :-
  filter(List, , T, ListSintomaPesoComun, AuxList).
filter([], _, [], _).

% Por cada sintoma encontrado dividirlo el peso por el mayor peso y despues sumar los resultados
get_priority(IDAlergia, ListSintomas, Value) :-
  alergia(IDAlergia, _, ListSintomaPeso),
  filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun),





sort_by_priorities() :-



/**********************************************************************************/

alergiaSam :-
  % abrir_db,
  % TODO preguntar primero si podes describir los sintomas
  writeln('Contame que sintomas tenes, (Separados por coma)'),
  read_to_string(_, WordList), % TODO limpiar palabras como: tengo, me duele ...
  writeln(WordList),
  % Buscar sintomas en nuesta DB
  search_sintomas(WordList, ListSintomas), writeln(ListSintomas),
  find_alergias(ListSintomas, ListAlergias), writeln(ListAlergias)
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
