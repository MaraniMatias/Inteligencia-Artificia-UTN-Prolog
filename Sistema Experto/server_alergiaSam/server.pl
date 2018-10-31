% pack_install(arouter).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/json)).
:- use_module(library(arouter)).
:- dynamic alergia/4.
:- dynamic sintoma/2.
:- dynamic sintomas_alergia/1.
:- dynamic sintoma_confirmado/2.
:- dynamic list_alergias_priorites/1.
:- ['util.pl'].
verision('v2.01').

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
  'Conoces algún síntoma?'
  ], answer_control_ask).

/******************************************************************/
:- route_get(send/answer_control_ask/Message, handle_answer_control_ask(Message)).

handle_answer_control_ask(String) :-
  yes_or_no(String),
  split_string(String, ' ,', ',', WordList),
  answer_control_ask(String, WordList, Rta),
  alergiaSam(Rta).
handle_answer_control_ask(_) :-
  resp_yes_or_no(no_conoce_sintoma). % XXX falta ver

/******************************************************************/
% Contesto NO
alergiaSam(noConoceSintoma) :-
  resp_json([
    'Bien, ningún problema.',
    'Te haré unas preguntas.',
    'Algún familiar con antecedente de alergia?'
  ], no_conoce_sintoma).
% Contesto SI
alergiaSam(siConoceSintoma) :-
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
  abracadabra.
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
  show_alergia(ListAlergiasPriorites).

show_alergia([]).
show_alergia([alergia_priority(IDAlergia, _), alergia_priority(IDAlergia2, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  alergia(IDAlergia2, NomAlergia2, _, _),
  resp_json([
    'Lo más probable que sea ~w o ~w',
    'Te haré unas preguntas para averiguar de que alergia se trata.',
    'Algún familiar con antecedente de alergia?'
  ], abracadabra, point{replace: [NomAlergia, NomAlergia2]}).
show_alergia([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  resp_json([
    'Estoy pensando que puede ser ~w',
    'Te haré unas preguntas para averiguar de que alergia se trata.',
    'Algún familiar con antecedente de alergia?'
  ], abracadabra, point{replace: [NomAlergia]}).

/******************************************************************/
:- route_get(send/abracadabra/Msg, handle_abracadabra(Msg)).

handle_abracadabra(Msg) :-
  yes_or_no(Msg),
  abracadabra.
handle_abracadabra(_) :-
  resp_yes_or_no(abracadabra).

/******************************************************************/
abracadabra :-
  list_alergias_priorites(ListAlergiasPriorites),
  abracadabra_aux(ListAlergiasPriorites).

abracadabra_aux([]) :-
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, NomAlergia, ListSintomas, _),
  % check(ListSintomas),
  resp_json([
    'Esos síntomas se corresponde con ~w'
  ], end, point{replace: [NomAlergia]}).
% abracadabra_aux([]) :-
%   sintomas_alergia(IDAlergia),
%   alergia(IDAlergia, NomAlergia, _, _),
%   resp_json([
%     'Algunos de eso síntomas se corresponde con ~w',
%     'Necesitamos hacer unos estudios personalmente.'
%   ], end, point{replace: [NomAlergia]}).
abracadabra_aux([]) :-
  resp_json([
    'No se que decirte esos síntomas no corresponde con ninguna alergias.'
  ], end).
abracadabra_aux([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, _, ListSintomas, _),
  % Para preguntar, no tiene existir 'sintoma_confirmado' con no
  ask_for_alergia(ListSintomas),
  sort_sintomas(ListSintomas, ListSintomas2),
  asking_for_sintomas(ListSintomas2).
/**********************************************************************/

:- route_get(send/resolve_answer/ID/Msg, handle_resolve_answer(Msg, ID)).

handle_resolve_answer(Msg, IDSintoma) :-
  tiene(Msg, IDSintoma),
  retractall(sintoma(IDSintoma, _)),
  abracadabra.
handle_resolve_answer(Msg, IDSintoma) :-
  no_tiene(Msg, IDSintoma),
  retractall(sintoma(IDSintoma, _)),
  % Si la alergia seleccionada tiene el síntoma, descartarla
  sintomas_alergia(IDAlergia),
  alergia(IDAlergia, _, ListSintomas, _),
  pertenece_sintoma_peso(IDSintoma, ListSintomas),
  retractall(sintomas_alergia(_)),

  list_alergias_priorites([_|T]),
  retractall(list_alergias_priorites(_)),
  asserta(list_alergias_priorites(T)),
  abracadabra.
handle_resolve_answer(Msg, IDSintoma) :-
  no_tiene(Msg, IDSintoma),
  retractall(sintoma(IDSintoma, _)),
  list_alergias_priorites([_|T]),
  retractall(list_alergias_priorites(_)),
  asserta(list_alergias_priorites(T)),
  abracadabra.

handle_resolve_answer(_, IDSintoma) :-
  resp_json(['Podrías contestar si o no, gracias'],
  resolve_answer, point{
    idSintoma: IDSintoma
  }).

/******************************************************************/
:- route_get(send/end/_, handle_end).

handle_end :-
  resp_json([
    'Hu! Mira que hora es!!, me tengo que ir.',
    'Adios, que tengas un buen día.'
  ], start).

/******************************************************************/
:- http_server(route, [port(8008)]).
