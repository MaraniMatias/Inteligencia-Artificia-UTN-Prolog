% pack_install(arouter).
:- ['sistema_experto.pl'].
:- dynamic list_alergias_priorites/1.
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/json)).
:- use_module(library(arouter)).

/******************************************************************/
rest_all :-
  retractall(list_alergias_priorites(_)),
  retractall(sintomas_alergia(_)),
  retractall(sintoma_confirmado(_, _)),
  open_db_alergia,
  open_db_sintomas.

/******************************************************************/
hendle_generic :-
  cors_enable,
  verision(V),
  format('Content-Type: application/json~n'),
  format('Server: nginx/1.10.3~n'),
  format('Version: ~w~n', [V]),
  format('Access-Control-Allow-Origin: *~n~n').

resp_json(Message, Next, Meta) :-
  hendle_generic,
  json_write_dict(current_output, point{message:Message, next:Next, meta:Meta}).
resp_json(Message, Next) :-
  hendle_generic,
  json_write_dict(current_output, point{message:Message, next:Next}).
resp_json(Message) :-
  hendle_generic,
  json_write_dict(current_output, point{message:Message}).
resp_yes_or_no(Next) :-
  resp_json([
    'Esperaba "Si" o "No"'
  ], Next).
/******************************************************************/
:- route_get(/, handle_hello('AlergiaSam')).

handle_hello(Name) :-
  hendle_generic,
  verision(V),
  json_write_dict(current_output, point{name:Name,verision:V}).

/******************************************************************/
:- route_get(send/start, handle_start).
:- route_get(send/start/_, handle_start).
handle_start :-
  rest_all,
  resp_json([
  'hola, soy alergiaSam',
  'Estaré ayudándote a descubrir tus alergias.',
  % 'Conoces algún síntoma? O necesitas ayuda para describirlos?'
  'Conoces algún síntoma?'
  ], answer_control_ask).

/******************************************************************/
:- route_get(send/answer_control_ask/Message, handle_answer_control_ask(Message)).

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

handle_answer_control_ask(String) :-
  yes_or_no(String),
  split_string(String, ' ,', ',', WordList),
  answer_control_ask(String, WordList, Rta),
  server_alergiaSam(Rta).
handle_answer_control_ask(_) :-
  resp_yes_or_no(no_conoce_sintoma).
  % resp_json(['Adios, que tengas un buen dia.']).

/******************************************************************/
% Contesto NO
server_alergiaSam(noConoceSintoma) :-
  resp_json([
    'Bien, ningún problema.',
    'Te haré unas preguntas.',
    'Algún familiar con antecedentes?'
  ], no_conoce_sintoma).
% Contesto SI
server_alergiaSam(siConoceSintoma) :-
  resp_json(['Cuéntame que síntomas tienes.'], si_conoce_sintoma).

:- route_get(send/no_conoce_sintoma/Message, handle_no_conoce_sintoma(Message)).
:- route_get(send/si_conoce_sintoma/Message, handle_si_conoce_sintoma(Message)).

/******************************************************************/
% Contesto NO
handle_no_conoce_sintoma(String) :-
  yes_or_no(String),
  find_all_alergias(ListAlergias),
  sort_by_priorities(ListAlergias, ListAlergiasPriorites),
  asserta(list_alergias_priorites(ListAlergiasPriorites)),
  server_abracadabra.
handle_no_conoce_sintoma(_) :-
  resp_yes_or_no(no_conoce_sintoma).

/******************************************************************/
% Contesto SI
handle_si_conoce_sintoma(String) :-
  split_string(String, ' ,', ',', WordList),
  % Buscar síntomas en nuestra DB
  search_sintomas(WordList, ListSintomas),
  % Crea los hechos que indican los síntomas confirmados
  assert_sintoma_confirmado(ListSintomas),
  find_alergias(ListSintomas, ListAlergias),
  % writeln(ListAlergias),
  sort_by_priorities(ListAlergias, ListSintomas, ListAlergiasPriorites),
  % writeln(ListAlergiasPriorites),
  retractall(list_alergias_priorites(_)),
  asserta(list_alergias_priorites(ListAlergiasPriorites)),
  server_show_alergia(ListAlergiasPriorites).

server_show_alergia([]).
server_show_alergia([alergia_priority(IDAlergia, _), alergia_priority(IDAlergia2, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  alergia(IDAlergia2, NomAlergia2, _, _),
  resp_json([
    'Lo más probable que sea ~w o ~w',
    'Te haré unas preguntas para averiguar de que alergia se trata.',
    'Algún familiar con antecedentes?'
  ], abracadabra, point{replace: [NomAlergia, NomAlergia2]}).
server_show_alergia([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  resp_json([
    'Estoy pensando que puede ser ~w',
    'Te haré unas preguntas para averiguar de que alergia se trata.',
    'Algún familiar con antecedentes?'
  ], abracadabra, point{replace: [NomAlergia]}).

/******************************************************************/
:- route_get(send/abracadabra/Msg, handle_abracadabra(Msg)).

handle_abracadabra(Msg) :-
  yes_or_no(Msg),
  server_abracadabra.
handle_abracadabra(_) :-
  resp_yes_or_no(abracadabra).

/******************************************************************/
server_abracadabra :-
  list_alergias_priorites(ListAlergiasPriorites),
  server_abracadabra_aux(ListAlergiasPriorites).

server_abracadabra_aux([]) :-
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, NomAlergia, _, _),
  resp_json([
    'Esos síntomas se corresponde con ~w'
  ], end, point{replace: [NomAlergia]}).
server_abracadabra_aux([]) :-
  resp_json([
    'No se que decirte esos síntomas no corresponde con ninguna alergias.'
  ], end).
server_abracadabra_aux([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, _, ListSintomas, _),
  server_asking_for_sintomas(ListSintomas).

/******************************************************************/
% preguntar por cada síntoma no preguntado
server_asking_for_sintomas([]) :-
  open_db_sintomas,
  list_alergias_priorites([alergia_priority(IDAlergia, _)|T]),
  retractall(sintomas_alergia(_)),
  asserta(sintomas_alergia(IDAlergia)),
  retract(list_alergias_priorites(_)),
  asserta(list_alergias_priorites(T)),
  % resp_json(['lineas 171'], start).
  server_abracadabra.
server_asking_for_sintomas([sintoma_peso(IDSintoma, _)|_]) :-
  sintoma(IDSintoma, _),
  server_asking_for_sintomas(IDSintoma).
server_asking_for_sintomas([_|ListSintomas]) :-
  server_asking_for_sintomas(ListSintomas).

% En caso de no tener pregunta previas
server_asking_for_sintomas(IDSintoma) :-
  not(sintoma_confirmado(si, IDSintoma)),
  not(sintoma_confirmado(no, IDSintoma)),
  sintoma(IDSintoma, NomSintoma),
  retractall(sintoma(IDSintoma, _)),
  resp_json(['Tienes ~w?'], server_resolve_answer, point{
    replace: [NomSintoma],
    nomSintoma: NomSintoma,
    idSintoma: IDSintoma
  }).

% En caso de haberlo preguntado
server_asking_for_sintomas(IDSintoma) :-
  sintoma_confirmado(si, IDSintoma),
  retractall(sintoma(IDSintoma, _)),
  server_abracadabra.
server_asking_for_sintomas(IDSintoma) :-
  sintoma_confirmado(no, IDSintoma),
  server_abracadabra.

:- route_get(send/server_resolve_answer/ID/Msg, handle_server_resolve_answer(Msg, ID)).

handle_server_resolve_answer(Msg, IDSintoma) :-
  tiene(Msg, IDSintoma),
  retractall(sintoma(IDSintoma, _)),
  server_abracadabra.
handle_server_resolve_answer(Msg, IDSintoma) :-
  no_tiene(Msg, IDSintoma),
  retractall(sintoma(IDSintoma, _)),
  list_alergias_priorites([_|T]),
  retractall(sintomas_alergia(_)),
  retractall(list_alergias_priorites(_)),
  asserta(list_alergias_priorites(T)),
  % open_db_sintomas,
  server_abracadabra.

handle_server_resolve_answer(_, IDSintoma) :-
  resp_json(['Podrias contestar si o no, gracias'],
  server_resolve_answer, point{
    idSintoma: IDSintoma
  }).

/******************************************************************/
:- route_get(send/end/_, handle_end).

handle_end :-
  resp_json([
    'Hu! mira que hora es!!, me tengo que ir.',
    'Adios, que tengas un buen dia.'
  ], start).

/******************************************************************/
:- http_server(route, [port(8008)]).
