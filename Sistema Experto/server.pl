% pack_install(arouter).
:- ['sistema_experto.pl'].
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

resp_json(Message) :-
  hendle_generic,
  json_write_dict(current_output, point{message:Message}).
/******************************************************************/
:- route_get(/, handle_hello('AlergiaSam')).

handle_hello(Name) :-
  hendle_generic,
  json_write_dict(current_output, point{x:1,y:2,name:Name}).

/******************************************************************/
:- route_get(start, handle_start).
handle_start :- 
  resp_json([
  'hola, soy alergiaSam', 
  'Estaré ayudándote a descubrir tus alergias.',
  'Conoces algún síntoma? O necesitas ayuda para describirlos?'
  ]).

/******************************************************************/
:- route_get(send/Message, handle_send(Message)).
handle_send(Message) :-  resp_json(Message).

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
