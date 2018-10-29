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
hendle_generic :-
  cors_enable,
  format('Content-Type: application/json~n'),
  format('Server: nginx/1.10.3~n'),
  format('Version: 0.1.0~n'),
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
resp_answer_yes_or_no(Next) :-
  resp_json([
    'Esperaba "Si" o "No"'
  ], Next).
/******************************************************************/
:- route_get(/, handle_hello('AlergiaSam')).

handle_hello(Name) :-
  hendle_generic,
  json_write_dict(current_output, point{x:1,y:2,name:Name}).

:- route_get(send/Message, handle_send(Message)).
handle_send(Message) :-  resp_json(Message).

/******************************************************************/
:- route_get(send/start, handle_start).
handle_start :-
  retractall(list_alergias_priorites(_)),
  open_db,
  resp_json([
  'hola, soy alergiaSam',
  'Estaré ayudándote a descubrir tus alergias.',
  % 'Conoces algún síntoma? O necesitas ayuda para describirlos?'
  'Conoces algún síntoma?'
  ], answer_control_ask).

/******************************************************************/
:- route_get(send/answer_control_ask/Message, handle_answer_control_ask(Message)).
handle_answer_control_ask(String) :-
  split_string(String, ' ,', ',', WordList),
  answer_control_ask(String, WordList, Rta),
  server_alergiaSam(Rta).
  % resp_json(['Adios, que tengas un buen dia.']).

/******************************************************************/
% Contesto NO
server_alergiaSam(noConoceSintoma) :-
  resp_json([
    'Bien, ningún problema.',
    'Te haré unas preguntas.',
    'Comenzamos ?'
  ], no_conoce_sintoma ).

:- route_get(send/no_conoce_sintoma/Message, handle_no_conoce_sintoma(Message)).

answer_yes('si').
answer_yes('Si').
answer_yes('SI').
answer_yes('Dale').

handle_no_conoce_sintoma(String) :-
  answer_yes(String),
  find_all_alergias(ListAlergias),
  sort_by_priorities(ListAlergias, ListAlergiasPriorites),
  asserta(list_alergias_priorites(ListAlergiasPriorites)),
  server_abracadabra.

handle_no_conoce_sintoma(_) :-
  resp_json([
    'Esperaba un "SI"'
  ], no_conoce_sintoma ).

/******************************************************************/
% Contesto SI
server_alergiaSam(siConoceSintoma) :-
  resp_json(['Cuéntame que síntomas tienes.'], si_conoce_sintoma).

:- route_get(send/si_conoce_sintoma/Message, handle_si_conoce_sintoma(Message)).
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
  asserta(list_alergias_priorites(ListAlergiasPriorites)),
  server_show_alergia(ListAlergiasPriorites).

server_show_alergia([]).
server_show_alergia([alergia_priority(IDAlergia, _), alergia_priority(IDAlergia2, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  alergia(IDAlergia2, NomAlergia2, _, _),
  resp_json([
    'Estoy pensando en dos opciones...', NomAlergia, NomAlergia2,
    'Te haré unas preguntas para averiguar de que alergia se trata.',
    'Algún familiar con antecedentes?'
  ], abracadabra).
server_show_alergia([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  resp_json([
    'Estoy pensando que puede ser...', NomAlergia,
    'Te haré unas preguntas para averiguar de que alergia se trata.',
    'Algún familiar con antecedentes?'
  ], abracadabra).

/******************************************************************/
:- route_get(send/abracadabra/Msg, handle_abracadabra(Msg)).

handle_abracadabra(Msg) :-
  answer_yes_or_no(Msg),
  server_abracadabra.
handle_abracadabra(_) :-
  resp_answer_yes_or_no(abracadabra).

/******************************************************************/
server_abracadabra :-
  list_alergias_priorites(ListAlergiasPriorites),
  server_abracadabra_aux(ListAlergiasPriorites).

server_abracadabra_aux([]) :-
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, NomAlergia, _, _),
  resp_json([
    'Esos síntomas se corresponde con...',
    NomAlergia
  ], start).
server_abracadabra_aux([]) :-
  resp_json([
    'No se que decirte esos síntomas no corresponde con ninguna alergias.'
  ], start).
server_abracadabra_aux([alergia_priority(IDAlergia, _)|T]) :-
  alergia(IDAlergia, _, ListSintomas, _),
  server_asking_for_sintomas(ListSintomas).
  % update_sintomas_alergia(IDAlergia, T), % TODO ver respuetas line 35
  % server_abracadabra_aux(T).
% server_abracadabra_aux([_|T]) :-
  % server_abracadabra_aux(T).
% TODO Ojo con las alergias???

/******************************************************************/
% preguntar por cada síntoma no preguntado
server_asking_for_sintomas([]).
server_asking_for_sintomas([sintoma_peso(IDSintoma, _)|ListSintomas]) :-
  sintoma(IDSintoma, NomSintoma),
  server_asking_for_sintomas(IDSintoma, NomSintoma). % TODO en construcion
  % server_asking_for_sintomas(ListSintomas).
server_asking_for_sintomas([_|ListSintomas]) :-
  server_asking_for_sintomas(ListSintomas).

% En caso de no tener pregunta previas
server_asking_for_sintomas(IDSintoma, NomSintoma) :-
  not(sintoma_confirmado(si, IDSintoma)),
  not(sintoma_confirmado(no, IDSintoma)),
  retractall(sintoma(IDSintoma, _)),
  resp_json(['Tienes ~w?'], server_resolve_answer, point{
    nomSintoma: NomSintoma,
    idSintoma: IDSintoma
  }).
  %read_to_string(String, _),
  %resolve_answer(String, IDSintoma). % TODO

% En caso de haberlo preguntado
server_asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(si, IDSintoma).
server_asking_for_sintomas(IDSintoma, _) :-
  sintoma_confirmado(no, IDSintoma),
  fail.

:- route_get(send/server_resolve_answer/ID/Msg, handle_server_resolve_answer(Msg,ID)).

handle_server_resolve_answer(Msg, IDSintoma) :-
  % atom_string(MsgA, Msg),
  % atom_string(IDA, IDSintoma),
  % answer_yes_or_no(Msg),
  tiene(Rta, IDSintoma),
  server_abracadabra.
  %resp_json(['si',Msg, IDSintoma]).
handle_server_resolve_answer(Msg, IDSintoma) :-
  % atom_string(MsgA, Msg),
  % atom_string(IDA, IDSintoma),
  % answer_yes_or_no(Msg),
  no_tiene(Rta, IDSintoma),
  server_abracadabra.
  % resp_json(['No',Msg, IDSintoma]).


/******************************************************************/
:- http_server(route, [port(8008)]).
