% TODO: algo mas parecido a eli
:- protocola('log_sistema_experto.log').
:- writeln('VERSION v1.1'),
:- dynamic alergia/4.
:- dynamic sintoma/2.
:- dynamic sintomas_alergia/1.
:- dynamic sintoma_confirmado/2.

/**********************************************************************************/
open_db_alergia :-
  retractall(alergia(_, _, _, _)),
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

update_sintomas_alergia(IDAlergia, _) :-
  sintomas_alergia(_),
  retractall(sintomas_alergia(_)),
  asserta(sintomas_alergia(IDAlergia)).
update_sintomas_alergia(IDAlergia, []) :-
  retractall(sintomas_alergia(_)),
  asserta(sintomas_alergia(IDAlergia)).
update_sintomas_alergia(IDAlergia, _) :-
  retractall(sintomas_alergia(_)),
  asserta(sintomas_alergia(IDAlergia)),
  alergia(IDAlergia, NomAlergia, _, _),
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

  search_sintomas([], []) :-
  open_db_sintomas.
search_sintomas([Word|T], [ID| Sintomas]) :-
  open_db_sintomas,
  Word \= '', Word \= "", Word \= "y",
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
find_alergias([], _) :- fail.
find_alergias(ListIDSintoma, [ID|Alergias]) :-
  alergia(ID, _, ListSintomaPeso, _),
  retract(alergia(ID, _, _, _)),
  find_sintomas_in_list(ListIDSintoma, ListSintomaPeso),
  find_alergias(ListIDSintoma, Alergias).
find_alergias(ListIDSintoma, Alergias) :-
  alergia(_, _, _, _),
  find_alergias(ListIDSintoma, Alergias).
find_alergias(_, []) :-
  open_db_alergia.

/**********************************************************************************/
% La idea obtener un valor para cada alergia, que tenga mejor proiridad de ser la
% correcta.

max_sintoma_peso([sintoma_peso(_, H)|T], Max) :-
  max_sintoma_peso(T, H, Max).
max_sintoma_peso([], Max, Max).
max_sintoma_peso([sintoma_peso(_, H)|T], Value, Max) :-
  H > Value,
  max_sintoma_peso(T, H, Max).
max_sintoma_peso([sintoma_peso(_, H)|T], Value, Max) :-
  H =< Value,
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
  alergia(IDAlergia, _, ListSintomaPeso, _),
  filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun),
  max_sintoma_peso(ListSintomaPesoComun, Max),
  make_priority(ListSintomaPesoComun, Max, Value).

get_list_priority([], _, []).
get_list_priority([ID|T], ListSintomas, [alergia_priority(ID, Priorites)|T1]) :-
  get_priority(ID, ListSintomas, Priorites),
  get_list_priority(T, ListSintomas, T1).

sort_by_priorities(ListAlergias, ListSintomas, ListAlergiasNew) :-
  get_list_priority(ListAlergias, ListSintomas, ListAlergiasPriority),
  sort_by_priorities_aux(ListAlergiasPriority, [], ListAlergiasNew).

% Ordena una liasta de mayor a menor
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

tiene('s'           , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('si'          , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('poco'        , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('apenas'      , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('algo'        , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('puede'       , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('puede ser'   , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('creo'        , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('creo que si' , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('bastante'    , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).

no_tiene('n'        , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('no'       , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('no creo'  , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('nada'     , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).

resolve_answer(Rta, IDSintoma) :-
  tiene(Rta, IDSintoma).
resolve_answer(Rta, IDSintoma) :-
  no_tiene(Rta, IDSintoma),
  fail.
resolve_answer(_, IDSintoma) :-
  not(sintoma_confirmado(si, IDSintoma)),
  not(sintoma_confirmado(no, IDSintoma)),
  writeln('Podaras limitarte a constar con si o no, gracias'),
  sintoma(IDSintoma, NomSintoma),
  format('Tienes ~w?~n', [NomSintoma]),
  read_to_string(String, _),
  resolve_answer(String, IDSintoma).

% En caso de no tener pregunta previas
asking_for_sintomas(IDSintoma, NomSintoma) :-
  not(sintoma_confirmado(si, IDSintoma)),
  not(sintoma_confirmado(no, IDSintoma)),
  format('Tienes ~w?~n', [NomSintoma]),
  read_to_string(String, _),
  resolve_answer(String, IDSintoma).
% En caso de haberlo preguntado
asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(si, IDSintoma).
asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(no, IDSintoma),
  fail.

% preguntar por cada síntoma no preguntado
asking_for_sintomas([]).
asking_for_sintomas([sintoma_peso(IDSintoma, _)|ListSintomas]) :-
  % writeln(['->',IDSintoma, NomSintoma, ListSintomas]),
  sintoma(IDSintoma, NomSintoma),
  asking_for_sintomas(IDSintoma, NomSintoma),
  asking_for_sintomas(ListSintomas).

abracadabra([]) :-
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, NomAlergia, _, _),
  format('Esos síntomas se corresponde con ~w~n', [NomAlergia]).
abracadabra([]) :-
  writeln('No se que decirte esos síntomas no corresponde con ninguna alergias.').
abracadabra([alergia_priority(IDAlergia, _)|T]) :-
  alergia(IDAlergia, _, ListSintomas, _),
  asking_for_sintomas(ListSintomas),
  update_sintomas_alergia(IDAlergia, T),
  abracadabra(T).
abracadabra([_|T]) :-
  abracadabra(T).

/**********************************************************************************/
show_alergia([]).
show_alergia([alergia_priority(IDAlergia, _), alergia_priority(IDAlergia2, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  alergia(IDAlergia2, NomAlergia2, _, _),
  format('Estoy pensando que puede ser ~w o ~w~n', [NomAlergia, NomAlergia2]).
  % show_alergia(T).
show_alergia([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  format('Estoy pensando que puede ser ~w~n', [NomAlergia]).
  % show_alergia(T).

/**********************************************************************************/
sort_by_priorities(ListAlergias, ListAlergiasPriorites) :-
  sort_by_priorities_aux(ListAlergias, [], ListAlergiasPriorites).

find_all_alergias([alergia_priority(ID, Priority)|Alergias]) :-
  alergia(ID, _, _, Priority),
  retract(alergia(ID, _, _, _)),
  find_all_alergias(Alergias).
find_all_alergias([]) :-
    open_db_alergia.

/**********************************************************************************/
conoce_sintomas('Si').
conoce_sintomas('si').
conoce_sintomas('si puedo').
conoce_sintomas('si conozco').
conoce_sintomas('conozco').
conoce_sintomas('puedo nombrarlos').
conoce_sintomas('puedo decírtelos').

answer_yer_or_no('SI').
answer_yer_or_no('si').
answer_yer_or_no('creo').
answer_yer_or_no('NO').
answer_yer_or_no('no').
answer_yer_or_no('no se').

answer_yer_or_no(S, WL) :-
  read_to_string(S, WL),
  answer_yer_or_no(S).
answer_yer_or_no(S, WL) :-
  writeln('No estoy seguro de entenderte, podrás decir si o no.'),
  answer_yer_or_no(S, WL).

answer_control_ask(String, _, siConoceSintoma) :-
  conoce_sintomas(String).
answer_control_ask(_, WordList, ListSintomas) :-
  % Buscar síntomas en nuestra DB
  search_sintomas(WordList, ListSintomas),
  ListSintomas \= [].
answer_control_ask(_, _, noConoceSintoma).

%% Preguntamos si conoce los síntomas y pregunta genérica
alergiaSam :-
  writeln('Conoces algún síntoma? O necesitas ayuda para describirlos?'),
  read_to_string(String, WordList),
  answer_control_ask(String, WordList, Rta),
  % writeln(Rta),
  % Rta -> Si o No
  % Rta -> [...]
  % Rta -> []
  alergiaSam(Rta).

% Contesto Con síntomas
alergiaSam(ListSintomas) :-
  % Crea los hechos que indican los síntomas confirmados
  assert_sintoma_confirmado(ListSintomas),
  find_alergias(ListSintomas, ListAlergias),
  % writeln(ListAlergias),
  sort_by_priorities(ListAlergias, ListSintomas, ListAlergiasPriorites),
  % writeln(ListAlergiasPriorites),
  show_alergia(ListAlergiasPriorites),
  writeln('Te haré unas preguntas para averiguar de que alergia se trata.'),
  writeln('Algún familiar con antecedentes?'),
  answer_yer_or_no(_, _),
  writeln('Bien.'),
  abracadabra(ListAlergiasPriorites).

% Contesto NO
alergiaSam(noConoceSintoma) :-
  writeln('Buen, ningún problema.'),
  find_all_alergias(ListAlergias),
  sort_by_priorities(ListAlergias, ListAlergiasPriorites),
  writeln('Te haré unas preguntas.'),
  abracadabra(ListAlergiasPriorites).

% Contesto SI
alergiaSam(siConoceSintoma) :-
  writeln('Cuéntame que síntomas tienes.'),
  read_to_string(_, WordList), % TODO limpiar palabras como: tengo, me duele ...
  % Buscar síntomas en nuestra DB
  search_sintomas(WordList, ListSintomas),
  alergiaSam(ListSintomas).

inicio :- start.
start :-
  open_db,
  retractall(sintomas_alergia(_)),
  retractall(sintoma_confirmado(_, _)),
  writeln('Buen día!, Soy Alergia-Sam'),
  writeln('Estaré ayudándote a descubrir tus alergias.'),
  alergiaSam.

start :-
  writeln('Ups, que mal!'),
  writeln('Nos veremos la próxima!').
% :- start.
