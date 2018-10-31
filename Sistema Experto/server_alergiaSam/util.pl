:- writeln('server_util load').
/******************************************************************/
open_db_alergia :-
  retractall(alergia(_, _, _, _)),
  consult('../DB/alergias.pl').
open_db_sintomas :-
  retractall(sintoma(_, _)),
  consult('../DB/sintomas.pl').
rest_all :-
  retractall(list_alergias_priorites(_)),
  retractall(sintomas_alergia(_)),
  retractall(sintoma_confirmado(_, _)),
  open_db_alergia,
  open_db_sintomas.

/******************************************************************/
% Creo hechos para guardar los síntomas elegidos
assert_sintoma_confirmado([]).
assert_sintoma_confirmado([IDSintoma|T]) :-
  assert_sintoma_confirmado(si, IDSintoma),
  assert_sintoma_confirmado(T).
assert_sintoma_confirmado(Tiene, IDSintoma) :-
  retractall(sintoma(IDSintoma, _)),
  assertz(sintoma_confirmado(Tiene, IDSintoma)).

/******************************************************************/
% Cuando le preguntas a algún si conoce algo, puede decir si, no o empresa a describirlo
% por eso para la pregunta ¿Podes decirme los síntomas? Tenemos que ver si contesto, si, no o
% con algunos síntomas.
answer_control_ask(String, _, siConoceSintoma) :-
  conoce_sintomas(String).
answer_control_ask(_, WordList, ListSintomas) :-
  % Buscar síntomas en nuestra DB
  search_sintomas(WordList, ListSintomas),
  ListSintomas \= [].
answer_control_ask(_, _, noConoceSintoma).

/******************************************************************/
yes_or_no(si).
yes_or_no('SI').
yes_or_no('Si').
yes_or_no('creo').
yes_or_no(no).
yes_or_no('NO').
yes_or_no('No').
yes_or_no('no se').
yes_or_no(X) :-
  atom_string(X, S),
  yes_or_no(S).

/******************************************************************/
% Hechos que representan conocer un síntoma, digamos que responde ala pregunta,
% ¿Podes decirme los síntomas que tenes?
conoce_sintomas('Si').
conoce_sintomas('si').
conoce_sintomas('si puedo').
conoce_sintomas('si conozco').
conoce_sintomas('conozco').
conoce_sintomas('puedo nombrarlos').
conoce_sintomas('puedo decírtelos').

/**********************************************************************************/
% Busca los síntomas que contenga la palabra Word
find_sintoma_by_word(Word, ID) :-
  sintoma(ID, Sintoma),
  retract(sintoma(ID, Sintoma)),
  string_to_atom(Word, Atom),
  sub_atom(Sintoma, 0, _, 0, Atom).
  % write([ID,Sintoma]), write('--') ,writeln(Word).

% Por cada palabra ingresada, una lista de palabras
% Busca síntomas en DB y creamos una lista de síntomas
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
% un pertenece 'especial' :D
pertenece_sintoma_peso(ID, [sintoma_peso(ID, _)|_]).
pertenece_sintoma_peso(ID, [_|T]) :-
  pertenece_sintoma_peso(ID, T).

% Busco que un síntoma este en una lista de pesos (IDSintoma, Peso)
find_sintomas_in_list([], _).
find_sintomas_in_list([ID|T], ListSintomaPeso) :-
  pertenece_sintoma_peso(ID, ListSintomaPeso),
  find_sintomas_in_list(T, ListSintomaPeso).

% Los argumento se corresponde a ListSintomas, ListAlergias
find_alergias([], _) :- fail. % No hay alergia para esos síntomas :(
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
% La idea obtener un valor para cada alergia, que tenga mejor prioridad de ser la
% correcta.
% Para esto uso solo los síntomas de la alergia que indico el paciente, con esos síntomas
% que son comunes entre al a alergia y en el paciente, se normalizan es decir cuento
% influye un síntoma de la alergia a la alergia en si. Si quieran se lo explico con un papel.

% El mayor peso de los síntomas de esa alergia.
max_sintoma_peso([sintoma_peso(_, H)|T], Max) :-
  max_sintoma_peso(T, H, Max).
max_sintoma_peso([], Max, Max).
max_sintoma_peso([sintoma_peso(_, H)|T], Value, Max) :-
  H > Value,
  max_sintoma_peso(T, H, Max).
max_sintoma_peso([sintoma_peso(_, H)|T], Value, Max) :-
  H =< Value,
  max_sintoma_peso(T, Value, Max).

% Obtengo una lista de síntoma_peso con solo los síntomas de la alergia e indicados
% por el paciente.
filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun) :-
  filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun, ListSintomaPeso).
filter([ID|T], [sintoma_peso(ID, Peso)|_], [sintoma_peso(ID, Peso)|T2], AuxList) :-
  filter(T, AuxList, T2, AuxList).
filter(List, [_|T], ListSintomaPesoComun, AuxList) :-
  filter(List, T, ListSintomaPesoComun, AuxList).
filter([], _, [], _).

% Calculo para crear la prioridad.
make_priority([sintoma_peso(_, Peso)|T], Max, Value) :-
  V is Peso rdiv Max,
  make_priority(T, Max, V1),
  Value is V1 + V.
make_priority([], _, 0).

% Por cada síntoma encontrado dividir el peso por el mayor peso (del síntoma en común)
% y después sumar los resultados.
get_priority(IDAlergia, ListSintomas, Value) :-
  alergia(IDAlergia, _, ListSintomaPeso, _),
  filter(ListSintomas, ListSintomaPeso, ListSintomaPesoComun),
  max_sintoma_peso(ListSintomaPesoComun, Max),
  make_priority(ListSintomaPesoComun, Max, Value).

% Arma la lista de prioridades por alergia.
get_list_priority([], _, []).
get_list_priority([ID|T], ListSintomas, [alergia_priority(ID, Priorites)|T1]) :-
  get_priority(ID, ListSintomas, Priorites),
  get_list_priority(T, ListSintomas, T1).

% Ordena de mayor a menor, en este caso según la prioridad.
sort_by_priorities(ListAlergias, ListSintomas, ListAlergiasNew) :-
  get_list_priority(ListAlergias, ListSintomas, ListAlergiasPriority),
  sort_by_priorities_aux(ListAlergiasPriority, [], ListAlergiasNew).

% Ordena una lista de mayor a menor.
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
% Cuando el paciente no reconoce síntomas, buscar todas la alergias y las ordenamos
% según la más populares.
sort_by_priorities(ListAlergias, ListAlergiasPriorites) :-
  sort_by_priorities_aux(ListAlergias, [], ListAlergiasPriorites).

% Obtener todas las alergias de la DB
find_all_alergias([alergia_priority(ID, Priority)|Alergias]) :-
  alergia(ID, _, _, Priority),
  retract(alergia(ID, _, _, _)),
  find_all_alergias(Alergias).
find_all_alergias([]) :-
    open_db_alergia.

/**********************************************************************************/
% Para preguntar, no tiene existir 'sintoma_confirmado' con no
ask_for_alergia([sintoma_peso(IDSintoma, _)|ListSintomas]) :-
  not(sintoma_confirmado(no, IDSintoma)),
  %TODO Validar que la alergia tenga todos los síntomas a los que dijiste si
  %TODO Por cada síntoma verificar que este en los de la alergia
  %TODO Creo que es más fácil desde check
  ask_for_alergia(ListSintomas).
ask_for_alergia([]).
/**********************************************************************************/
% Ordenar síntomas según el peso que le corresponda en la alergia
sort_sintomas(ListSintomas, ListSintomas2) :-
  sort_sintomas_aux(ListSintomas, [], ListSintomas2).

% Ordena una lista de mayor a menor.
sort_sintomas_aux([], Acc, Acc).
sort_sintomas_aux([H|T], Acc, Sorted) :-
  pivoting_simtomas(H, T, L1, L2),
  sort_sintomas_aux(L1, Acc, Sorted1),
  sort_sintomas_aux(L2, [H|Sorted1], Sorted).

% No es necesario crear otra regla, Pivoting.
pivoting_simtomas(_, [], [], []).
pivoting_simtomas(sintoma_peso(ID1, H), [sintoma_peso(ID2, X)|T], [sintoma_peso(ID2, X)|L], G) :-
  X =< H,
  pivoting_simtomas(sintoma_peso(ID1, H), T, L, G).
pivoting_simtomas(sintoma_peso(ID1, H), [sintoma_peso(ID2, X)|T], L, [sintoma_peso(ID2, X)|G]) :-
  X > H,
  pivoting_simtomas(sintoma_peso(ID1, H), T, L, G).

/**********************************************************************************/
% Preguntar por cada síntoma que tiene la alergia que no fueron preguntados.

% Como no restringimos entre si o no, tenemos una lista de hechos equivalentes.
tiene('s'               , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('si'              , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('poco'            , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('apenas'          , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('algo'            , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('puede'           , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('puede ser'       , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('creo'            , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('creo que si'     , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('bastante'        , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).
tiene('todo el tiempo'  , IDSintoma) :- assert_sintoma_confirmado(si, IDSintoma).

no_tiene('n'        , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('no'       , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('no creo'  , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
no_tiene('nada'     , IDSintoma) :- assert_sintoma_confirmado(no, IDSintoma).
/**********************************************************************************/
% preguntar por cada síntoma no preguntado
asking_for_sintomas([]) :-
  list_alergias_priorites([alergia_priority(IDAlergia, _)|T]),
  retractall(sintomas_alergia(_)),
  asserta(sintomas_alergia(IDAlergia)),
  retract(list_alergias_priorites(_)),
  asserta(list_alergias_priorites(T)),
  % resp_json(['lineas 171'], start).
  abracadabra.
asking_for_sintomas([sintoma_peso(IDSintoma, _)|_]) :-
  sintoma(IDSintoma, _),
  asking_for_sintomas(IDSintoma).
asking_for_sintomas([_|ListSintomas]) :-
  asking_for_sintomas(ListSintomas).

% En caso de no tener pregunta previas
asking_for_sintomas(IDSintoma) :-
  not(sintoma_confirmado(si, IDSintoma)),
  not(sintoma_confirmado(no, IDSintoma)),
  sintoma(IDSintoma, NomSintoma),
  retractall(sintoma(IDSintoma, _)),
  resp_json(['Tienes ~w?'], resolve_answer, point{
    replace: [NomSintoma],
    nomSintoma: NomSintoma,
    idSintoma: IDSintoma
  }).

% En caso de haberlo preguntado
asking_for_sintomas(IDSintoma) :-
  sintoma_confirmado(si, IDSintoma),
  retractall(sintoma(IDSintoma, _)),
  abracadabra.
asking_for_sintomas(IDSintoma) :-
  sintoma_confirmado(no, IDSintoma),
  abracadabra.

/**********************************************************************************/
% Antes de dar como confirmación checkeo los síntomas importantes
check([]).
check([sintoma_peso(IDSintoma, _)|ListSintomas]) :-
  sintoma_confirmado(si, IDSintoma),
  check(ListSintomas).
check([sintoma_peso(IDSintoma, Peso)|ListSintomas]) :-
  sintoma_confirmado(no, IDSintoma),
  Peso < 10,
  check(ListSintomas).

/**********************************************************************************/
