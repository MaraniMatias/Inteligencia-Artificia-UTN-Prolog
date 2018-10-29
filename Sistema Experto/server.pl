% pack_install(arouter).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/json)).
:- use_module(library(arouter)).

:- route_get(/, handle_hello('AlergiaSam')).
:- route_get(hello/Name, handle_hello(Name)).
handle_hello(Name):-
  cors_enable,
  format('Content-Type: application/json~n'),
  format('Server: nginx/1.10.3~n'),
  format('Access-Control-Allow-Origin: *~n~n'),
  json_write_dict(current_output, point{x:1,y:2,name:Name}).
  % reply_json_dict(point{x:1,y:2,name:Name}, []).

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
