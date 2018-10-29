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
    'Estoy pensando en dos opciones', NomAlergia, NomAlergia2,
    'Te haré unas preguntas para averiguar de que alergia se trata.',
    'Algún familiar con antecedentes?'
  ], abracadabra).
server_show_alergia([alergia_priority(IDAlergia, _)|_]) :-
  alergia(IDAlergia, NomAlergia, _, _),
  resp_json([
    'Estoy pensando que puede ser', NomAlergia,
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
  % resp_json(ListAlergiasPriorites, abracadabra).
  resp_json([
    'PErfe'
  ], find_sintomas_in_list).




/******************************************************************/
:- http_server(route, [port(8008)]).

/*
server(Port) :-
  http_server(http_dispatch, [port(Port)]).
:- server(8008).

:- http_handler(/, say_hi, []).

say_hi(_Request) :-
        format('Content-type: text/plain~n~n'),
        format('Hello ~w~n', [_Request]).
reply(Request) :-
  http_parameters(Request,
    [ title(Title),
      name(Name),
      age(Age)
    ],
    [attribute_declarations(param)]).

param(title, [optional(true)]).
param(name,  [length >= 2 ]).
param(age,   [integer]).
*/
/*
:- dynamic(known/2).
open_notify_url('http://api.open-notify.org/iss-now.json').
%! iss_data(-Data) is det.
%  get JSON ISS location data from open notify api and read in as dict
iss_data(Data) :-
    open_notify_url(URL),
    setup_call_cleanup(
        http_open(URL, In, [request_header('Accept'='application/json')]),
        json_read_dict(In, Data),
        close(In)
    ).

%! cached_iss_data(-Data) is det.
%  get cached data, else make a fresh request, useful during development.
cached_iss_data(Data) :-
    known(data, Data) ;
    iss_data(Data),
    assert(known(data, Data)).

%! iss_location(+Data, -Lat, -Long) is det.
%  extract the latitude and longitude from the data.
iss_location(Data, Lat, Long) :-
    Position = Data.get(iss_position),
    Lat = Position.get(latitude),
    Long = Position.get(longitude).
*/
