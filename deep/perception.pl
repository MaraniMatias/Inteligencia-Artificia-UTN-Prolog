% data([],label)
:- ['./database_par.pl'].
% :- ['./database_impar.pl'].
% :- ['./database_mayor_5.pl'].
:- dynamic(weight/2).
:- dynamic(error/2).
weight(w1, []).
weight(b1, 0).
error(e1, 0).

%
updata_err(E, Val) :-
  retract(error(E, _)),
  asserta(error(E, Val)).
updata_weight(W, Val) :-
  retract(weight(W, _)),
  asserta(weight(W, Val)).

% Re-set weight values
clenaer() :-
  updata_weight(w1, []),
  updata_weight(b1, 0),
  updata_err(e1, 0).

% Random List
random_list(0, []).
random_list(C, Rta) :-
  C > 0,
  C1 is C-1,
  random(H),
  Rta = [H|T],
  random_list(C1, T).

% Longitud de una lista
length_list([], 0).
length_list([_|T], Length) :-
  length_list(T, S1),
  Length is S1 + 1.

% Producto punto para dos vectores
produc_dot([], [], 0).
produc_dot([H1|T1], [H2|T2], Rta) :-
 produc_dot(T1, T2, Rta1),
 Rta is Rta1 + H1 * H2.

% Funcion de activacion
% https://en.wikipedia.org/wiki/Activation_function
% Step
step(X,1) :-
  X >= 0.
step(_,0). % 0 or -1

perception(X, Rta) :-
  weight(w1, W),
  W \= [],
  weight(b1, B1),
  produc_dot(X, W, Mrta),
  MB1 is Mrta + B1,
  step(MB1, Rta).
perception(X, Rta) :-
  length_list(X, LenX),
  random_list(LenX, W1),
  updata_weight(w1, W1), % weight
  random(B1),
  updata_weight(b1, B1), % weight synaptic
  perception(X, Rta).

adjust_weights(GetW, Err) :-
  weight(GetW, W),
  adjust_weights(W, Err, [], NewW),
  updata_weight(GetW, NewW),
  weight(b1, B1),
  NewB is B1 + Err,
  updata_weight(b1, NewB).

adjust_weights([], _, Rta, Rta).
adjust_weights([Hw|Tw], Err, T, Rta) :-
  H is Hw + Err,
  adjust_weights(Tw, Err, [H|T], Rta).

epoch(0) :-
  writeln('Epoch summary'),
  weight(w1, W1),
  write('Weight: '), writeln(W1),
  weight(b1, B1),
  write('Weight synaptic: '), writeln(B1),
  error(e1, E1),
  write('Error : '), writeln(E1),
  clenaer().

epoch(Epoch) :-
  Epoch \= 0,
  data(X, Label),
  perception(X, Prediction),
  Err is Label - Prediction,
  adjust_weights(w1, Err),
  NextEpoch is Epoch - 1,
  updata_err(e1, Err),
  epoch(NextEpoch).
