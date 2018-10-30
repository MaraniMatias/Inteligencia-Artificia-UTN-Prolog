:- protocola('log_sistema_experto.log').
:- dynamic alergia/4.
:- dynamic sintoma/2.
:- dynamic sintomas_alergia/1.
:- dynamic sintoma_confirmado/2.
verision('v2.03').

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
rest_all :-
  retractall(sintomas_alergia(_)),
  retractall(sintoma_confirmado(_, _)),
  open_db.

/**********************************************************************************/
% Creo hechos para guardar los síntomas elegidos
assert_sintoma_confirmado([]).
assert_sintoma_confirmado([IDSintoma|T]) :-
  assert_sintoma_confirmado(si, IDSintoma),
  assert_sintoma_confirmado(T).
assert_sintoma_confirmado(Tiene, IDSintoma) :-
  % retractall(sintoma(IDSintoma, _)),
  assertz(sintoma_confirmado(Tiene, IDSintoma)).

% Creo hechos para guardar la alergia candidata,
% si es la primera le envió el mensaje pensando en ....
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
% Leer texto escrito en consola de forma normal, no necesita '.' soló con enter.
% TODO limpiar palabras como: tengo, me duele ...
read_to_string(String, WordList) :-
  read_line_to_codes(user_input, Cs),
  atom_codes(String, Cs),
  atomic_list_concat(_, ' ', String),
  string_lower(String, S2),
  % TODO remplazar acentos por vocal sin acentos,también hacer esto en síntomas :D
  % FIXME split_string(S2, ' ', ',', WordList).
  % FIXME picor de ojos, lo separa mal
  split_string(S2, ' ,', ',', WordList).

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

% En caso de que la persona ingrese algo distinto a no_tine y tiene
% le avisamos que esperamos un si o un no
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

% En caso de no tener pregunta previas, armo la pregunta.
asking_for_sintomas(IDSintoma, NomSintoma) :-
  % writeln([IDSintoma,NomSintoma]),
  not(sintoma_confirmado(si, IDSintoma)),
  not(sintoma_confirmado(no, IDSintoma)),
  format('Tienes ~w?~n', [NomSintoma]),
  read_to_string(String, _),
  resolve_answer(String, IDSintoma).
% En caso de haber preguntado.
asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(si, IDSintoma).
asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(no, IDSintoma),
  fail.

% preguntar por cada síntoma no preguntado.
asking_for_sintomas([]).
asking_for_sintomas([sintoma_peso(IDSintoma, _)|ListSintomas]) :-
  % writeln(['->',IDSintoma, NomSintoma, ListSintomas]),
  sintoma(IDSintoma, NomSintoma),
  asking_for_sintomas(IDSintoma, NomSintoma),
  asking_for_sintomas(ListSintomas).

% Para preguntar, no tiene existir 'sintoma_confirmado' con no
ask_for_alergia([sintoma_peso(IDSintoma, _)|ListSintomas]) :-
  not(sintoma_confirmado(no, IDSintoma)),
  ask_for_alergia(ListSintomas).
ask_for_alergia([]).

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
% Toda la magia pasa acá :)
abracadabra([]) :-
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, NomAlergia, ListSintomas, _),
  check(ListSintomas),
  format('Esos síntomas se corresponde con ~w~n', [NomAlergia]).
abracadabra([]) :-
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, NomAlergia, _, _),
  format('Algunos de esos síntomas se corresponde con ~w
  seria mejor hacer unos estudios personalmente.', [NomAlergia]).
abracadabra([]) :-
  writeln('No se que decirte esos síntomas no corresponde con NINGUNA alergias.').
% Bueno, en realidad acá :D
abracadabra([alergia_priority(IDAlergia, _)|T]) :-
  alergia(IDAlergia, _, ListSintomas, _),
  % Para preguntar, no tiene existir 'sintoma_confirmado' con no
  ask_for_alergia(ListSintomas),
  sort_sintomas(ListSintomas, ListSintomas2),
  asking_for_sintomas(ListSintomas2),
  update_sintomas_alergia(IDAlergia, T),
  abracadabra(T).
abracadabra([_|T]) :-
  abracadabra(T).

/**********************************************************************************/
% Muestra las dos o la primera alergia que se me viene ala mente
show_alergia([]).
show_alergia([alergia_priority(IDAlergia, _), alergia_priority(IDAlergia2, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  alergia(IDAlergia2, NomAlergia2, _, _),
  format('Estoy pensando que puede ser ~w o ~w~n', [NomAlergia, NomAlergia2]).
show_alergia([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  format('Estoy pensando que puede ser ~w~n', [NomAlergia]).

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
% Hechos que representan conocer un síntoma, digamos que responde ala pregunta,
% ¿Podes decirme los síntomas que tenes?
conoce_sintomas('Si').
conoce_sintomas('si').
conoce_sintomas('si puedo').
conoce_sintomas('si conozco').
conoce_sintomas('conozco').
conoce_sintomas('puedo nombrarlos').
conoce_sintomas('puedo decírtelos').

% Preguntas afirmativa o negativas.
answer_yes_or_no(si).
answer_yes_or_no('SI').
answer_yes_or_no('Si').
answer_yes_or_no('creo').
answer_yes_or_no(no).
answer_yes_or_no('NO').
answer_yes_or_no('No').
answer_yes_or_no('no se').

% Para evitar que la persona conteste algo que no entendamos.
answer_yes_or_no(S, WL) :-
  read_to_string(S, WL),
  answer_yes_or_no(S).
answer_yes_or_no(S, WL) :-
  writeln('No estoy seguro de entenderte, podrás decir si o no.'),
  answer_yes_or_no(S, WL).

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

% Inicio de alargiaSam
alergiaSam :-
  writeln('Buen día!, Soy Alergia-Sam'),
  writeln('Estaré ayudándote a descubrir tus alergias.'),
  writeln('Conoces algún síntoma? O necesitas ayuda para describirlos?'),
  read_to_string(String, WordList),
  String \= 'Salir',
  answer_control_ask(String, WordList, Rta),
  % writeln(Rta),
  % Rta -> Si o No
  % Rta -> [...]
  % Rta -> []
  alergiaSam(Rta),
  format('~nHu! Mira que hora es!!, me tengo que ir.~nAdios, que tengas un gran día.~n~n').

% Contesto Con síntomas
alergiaSam(ListSintomas) :-
  % Crea los hechos que indican los síntomas confirmados, los que el paciente tiene.
  assert_sintoma_confirmado(ListSintomas),
  find_alergias(ListSintomas, ListAlergias),
  % writeln(ListAlergias),
  sort_by_priorities(ListAlergias, ListSintomas, ListAlergiasPriorites),
  % writeln(ListAlergiasPriorites),
  show_alergia(ListAlergiasPriorites),
  writeln('Te haré unas preguntas para averiguar de que alergia se trata.'),
  writeln('Algún familiar con antecedente de alergia?'),
  answer_yes_or_no(_, _),
  writeln('Bien.'),
  abracadabra(ListAlergiasPriorites).

% Contesto NO
alergiaSam(noConoceSintoma) :-
  writeln('Bien, ningún problema.'),
  find_all_alergias(ListAlergias),
  sort_by_priorities(ListAlergias, ListAlergiasPriorites),
  writeln('Te haré unas preguntas.'),
  writeln('Algún familiar con antecedente de alergia?'),
  answer_yes_or_no(_, _),
  writeln('Bien.'),
  abracadabra(ListAlergiasPriorites).

% Contesto SI
alergiaSam(siConoceSintoma) :-
  writeln('Cuéntame que síntomas tienes.'),
  read_to_string(_, WordList),
  % Buscar síntomas en nuestra DB
  search_sintomas(WordList, ListSintomas),
  alergiaSam(ListSintomas).

inicio :- start.
start :-
  verision(V),
  format('VERSION ~w~n', [V]),
  rest_all,
  alergiaSam.
% :- start.
