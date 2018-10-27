% TODO: algo mas parecido a eli
:- protocola('log_sistema_experto.log').
:- dynamic alergia/3.
:- dynamic sintoma/2.
:- dynamic sintomas_alergia/1.
:- dynamic sintoma_confirmado/2.

/**********************************************************************************/
open_db_alergia :-
  retractall(alergia(_, _, _)),
  consult('./DB/alergias.pl').
open_db_sintomas :-
  retractall(sintoma(_, _)),
  consult('./DB/sintomas.pl').
open_db :-
  open_db_alergia,
  open_db_sintomas.
/**********************************************************************************/

assert_sintoma_confirmado([]).
assert_sintoma_confirmado([IDSintoma|T]) :-
  assert_sintoma_confirmado(si, IDSintoma),
  assert_sintoma_confirmado(T).
assert_sintoma_confirmado(Tiene, IDSintoma) :-
  assertz(sintoma_confirmado(Tiene, IDSintoma)).

updata_sintomas_alergia(IDAlergia) :-
  sintomas_alergia(_),
  asserta(sintomas_alergia(IDAlergia)).
updata_sintomas_alergia(IDAlergia) :-
  retractall(sintomas_alergia(IDAlergia)),
  asserta(sintomas_alergia(IDAlergia)),
  alergia(IDAlergia, NomAlergia),
  format('Estoy pensando que puede ser ~w~n', [NomAlergia]).
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
  % FIXME picor de ojos, lo separa mal
  split_string(S2, ' ,', ',', WordList).

/**********************************************************************************/
find_sintoma_by_word(Word, ID) :-
  sintoma(ID, Sintoma),
  retract(sintoma(ID, Sintoma)),
  string_to_atom(Word, Atom),
  sub_atom(Sintoma, _, _, _, Atom).
  % write([ID,Sintoma]), write('--') ,writeln(Word).

search_sintomas([], []).
search_sintomas([Word|T], [ID| Sintomas]) :-
  open_db_sintomas,
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
  open_db_alergia.

/**********************************************************************************/
% La idea obtener un valor para cada alergia, que tenga mejor proiridad de ser la
% correcta.

max_sintoma_peso(List, Max) :-
  max_sintoma_peso(List, 0, Max).
max_sintoma_peso([], Max, Max).
max_sintoma_peso([sintoma_peso(_, H)|T], Value, Max) :-
  H > Value,
  max_sintoma_peso(T, H, Max).
max_sintoma_peso([_|T], Value, Max) :-
  max_sintoma_peso(T, Value, Max).

% Lista de pesos de los sintomas para los ID de sintomas ingresados
filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun) :-
  filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun, ListSintomaPeso).
filter([ID|T], [sintoma_peso(ID, Peso)|_], [sintoma_peso(ID, Peso)|T2], AuxList) :-
  filter(T, AuxList, T2, AuxList).
filter(List, [_|T], ListSintomaPesoComun, AuxList) :-
  filter(List, T, ListSintomaPesoComun, AuxList).
filter([], _, [], _).

make_priority([sintoma_peso(_, Peso)|T], Max, Value) :-
  V is Peso rdiv Max,
  make_priority(T, Max, V1),
  Value is V1 + V.
make_priority([], _, 0).

% Por cada sintoma encontrado dividirlo el peso por el mayor peso y despues sumar los resultados
get_priority(IDAlergia, ListSintomas, Value) :-
  alergia(IDAlergia, _, ListSintomaPeso),
  filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun),
  max_sintoma_peso(ListSintomaPesoComun, Max),
  make_priority(ListSintomaPesoComun, Max, Value).

get_list_priority([], _, []).
get_list_priority([ID|T], ListSintomas, [alergia_priority(ID,Priorites)|T1]) :-
  get_priority(ID, ListSintomas, Priorites),
  get_list_priority(T, ListSintomas, T1).

sort_by_priorities(ListAlergias, ListSintomas, ListAlergiasNew) :-
  get_list_priority(ListAlergias, ListSintomas, ListAlergiasPriority),
  sort_by_priorities_aux(ListAlergiasPriority, [], ListAlergiasNew).

sort_by_priorities_aux([], Acc, Acc).
sort_by_priorities_aux([H|T], Acc, Sorted) :-
    pivoting(H, T, L1, L2),
    sort_by_priorities_aux(L1, Acc, Sorted1),
    sort_by_priorities_aux(L2, [H|Sorted1], Sorted).

pivoting(_, [], [], []).
pivoting(alergia_priority(ID1, H), [alergia_priority(ID2, X)|T], [alergia_priority(ID2, X)|L], G) :-
  X =< H,
  pivoting(alergia_priority(ID1, H), T, L, G).
pivoting(alergia_priority(ID1, H), [alergia_priority(ID2, X)|T], L, [alergia_priority(ID2, X)|G]) :-
  X > H,
  pivoting(alergia_priority(ID1, H), T, L, G).

/**********************************************************************************/
% Preguntar por cada sintoma que tiene la enfermedad que no fueron se sabe si la
% persona los tiene

tiene('si'          , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('poco'        , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('algo'        , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('puede'       , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('puede ser'   , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('creo'        , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('bastante'    , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).

no_tiene('no'       , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('no creo'  , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('nada'     , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).

resolve_answer(Rta, IDSintoma) :-
  tiene(Rta, IDSintoma).
resolve_answer(Rta, IDSintoma) :-
  no_tiene(Rta, IDSintoma),
  fail.

% En caso de no tener pregunta previas
asking_for_sintomas(IDSintoma, NomSintoma) :-
  not(sintoma_confirmado(si, IDSintoma)),
  not(sintoma_confirmado(no, IDSintoma)),
  format('Tienes ~w ?~n', [NomSintoma]), % TODO tratar de que sea más personal
  read(Rta),
  string_lower(Rta, String),
  resolve_answer(String, IDSintoma).
% En caso de haberlo preguntado
asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(si, IDSintoma).
asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(no, IDSintoma),
  fail.

% preguntar por cada sintoma no preguntado
asking_for_sintomas([]).
asking_for_sintomas([sintoma_peso(IDSintoma, _)|ListSintomas]) :-
  sintoma(IDSintoma, NomSintoma),
  asking_for_sintomas(IDSintoma, NomSintoma),
  asking_for_sintomas(ListSintomas).

abracadabra([]) :-
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, NomAlergia, _),
  format('Esos sintomas se corresponde con ~w~n', [NomAlergia]).
abracadabra([]) :-
  writeln('No se que decirte esos sintomas no corresponde con niguna alergias.').
abracadabra([alergia_priority(IDAlergia, _)|T]) :-
  alergia(IDAlergia, _, ListSintomas),
  asking_for_sintomas(ListSintomas),
  updata_sintomas_alergia(IDAlergia),
  abracadabra(T).
abracadabra([_|T]) :-
  abracadabra(T).

/**********************************************************************************/
show_alergia([]).
show_alergia([IDAlergia|T]) :-
  alergia(IDAlergia, NomAlergia, _),
  format('Esos sintomas pertenece a ~w~n', [NomAlergia]),
  show_alergia(T).

/**********************************************************************************/
alergiaSam :-
  % open_db,
  % TODO preguntar primero si podes describir los sintomas
  writeln('Contame que sintomas tenes, (Separados por coma)'),
  read_to_string(_, WordList), % TODO limpiar palabras como: tengo, me duele ...
  writeln(WordList),
  search_sintomas(WordList, ListSintomas), % Buscar sintomas en nuesta DB
  % writeln(ListSintomas),
  assert_sintoma_confirmado(ListSintomas), % Crea los hechos que indican los sintomas fonfirmados
  find_alergias(ListSintomas, ListAlergias),
  writeln(ListAlergias),
  sort_by_priorities(ListAlergias, ListSintomas, ListAlergiasPriorites),
  writeln(ListAlergiasPriorites),
  show_alergia(ListAlergiasPriorites),
  writeln('Vamos a tratar de averiguar de que alergia se trata'),
  abracadabra(ListAlergiasPriorites)
  .

inicio :- start.
start :-
  open_db,
  retractall(tiene_sintoma(_)),
  retractall(no_tiene_sintoma(_)),
  writeln('VERSION v0 BASTANTE TONTA :P'),
  writeln('Buen día!, Soy Alergia-Sam'),
  writeln('Estaré ayudándote a descubrir tus alergias.'),
  % writeln('Empezamos? S/n'),
  % read(OPC),
  % OPC \= 'n', OPC \= 'N',
  alergiaSam.

start :-
  writeln('Ups, que mal!'),
  writeln('Nos veremos la próxima!').
% :- start.
