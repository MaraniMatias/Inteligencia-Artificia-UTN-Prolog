% data([],label)
:- ['./database_par.pl'].
% :- ['./database_impar.pl'].
% :- ['./database_mayor_5.pl'].
:- dynamic(weight/2).

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

weight(w1, []).
perception(X, Rta) :-
  weight(w1, W),
  W \= [],
  produc_dot(X, W, Mrta),
  step(Mrta, Rta),
  weight(b1, B1),
  Rta is Rta + B1.
perception(X, Rta) :-
  retract(weight(w1, _)),
  length_list(X, LenX),
  random_list(LenX, W1),
  asserta(weight(w1, W1)), % weight
  B1 is 0, % random(B1),
  asserta(weight(b1, B1)), % weight synaptic
  perception(X, Rta).


adjust_weights(W, Err, Rta) :-
  adjust_weights(W, Err, Rta, Rta).

adjust_weights([], _, NewW, NewW).
adjust_weights([Hw|Tw], Err, NewW, Rta) :-
  % restar Error por cada W
  H is Hw - Err,
  adjust_weights(Tw, Err, [H|NewW], Rta),
  writeln(Rta),
  writeln(Err).

adjust_weights(GetW, Err) :-
  L_rate is 1,
  weight(GetW, W),
  adjust_weights(W, Err, NewW),
  retract(weight(GetW, _)),
  asserta(weight(GetW, NewW)).

epoch(0) :-
  write('Epoch summary'),
  write('Weight: '),
  weight(w1,W1),
  writeln(W1),
  write('Weight synaptic: '),
  weight(b1,B1),
  writeln(B1),
  writeln('Error :'),
  error(e1,E1),
  writeln(E1).
epoch(Epoch) :-
  Epoch \= 0,
  data(X, Label),
  perception(X, Prediction),
  Err is Prediction - Label,
  adjust_weights(w1, Err),
  Epoch is Epoch - 1.

