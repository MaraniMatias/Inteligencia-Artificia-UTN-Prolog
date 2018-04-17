what_grade(5) :-
  write('Go to kindergarten').

what_grade(6) :-
  write('Go to kindergarten').

what_grade(Other) :-
  Grade is Other - 5,
  format('Go to grade ~w',[Grade]).


customer(tom, smith, 20.56).
customer(sally, smith, 20.56).

get_cust_bal(FName,LName) :-
  customer(FName,LName,Bal),
  write(FName), tab(1),
  format('~w owes us $~2f ~n',[LName, Bal]).

parent(osbaldo,dominga).
parent(cesar,delfina).
% Da false, pormas que exita parent
related(X, Y) :-
  parent(X, Y).
% Slucion
related(X, Y) :-
  parent(X, Z),
  related(Z, Y).


say_hi :-
  write('What is your name?'),
  read(X),
  write('Hi '),
  write(X).

far_char :-
  write('What is your fav char?'),
  get(X),
  format('The Ascii value ~w is ', [X]),
  put(X), nl.

write_to_file(File, Text) :-
  open(File, write, Stream),
  write(Stream, Text), nl,
  close(Stream).

read_to_file(File) :-
  open(File, read, Stream),
  get_char(String, Char1),
  process_stream(Char1, Stream),
  close(Stream).

process_stream(end_of_file, _) :- !.

process_stream(Char, Stream) :-
  write(Char),
  get_char(Stream, Char2),
  process_stream(Char2, Stream).


count_to_10(10) :- write(10), nl.

count_to_10(X) :-
  write(X), nl,
  Y is X + 1,
  count_to_10(Y).

% usar ; para ver los valores
count_down(Low, High) :-
  between(Low, High, X),
  Z is High - X,
  write(Z), nl.

count_up(Low, High) :-
  between(Low, High, X),
  Z is X + Low,
  write(Z), nl.

/*
guess_num :- loop(start).

loop(15) :- write('You guessed it').

loop(X) :-
  X \= 15,
  write('Guess Number '),
  read(Guess),
  write(Guess),
  write(' is not the number'), nl,
  loop(Guess).
*/

% En consola
% length([1,2,3],X).
% write([albert|[bart,lisa]).
% [H|T] = [a, b, c].
%
% List1 = [1,2,3].
% member(a, List1).
%
% usar ;
% menber(X, [1,2,3,4]).
%
% reverse([1,2,3], X).
% append([1,2,3,4], [5,6], X).

write_list([]).

write_list([Head|Tail]) :-
  write(Head), nl,
  write_list(Tail).


% Consola
%
% ?- save_string('a', X).
% X = [64].
%
% ?- (X, [64]).
% X = 'a'.
%

join_strins(Str1, Str2, Str3) :-
  name(Str1, StrList1),
  name(Str2, StrList2),
  append(StrList1, StrList2, StrList3),
  name(Str3, StrList3).
% ?- join_string('Hello', 'World', X).
% X = 'Hello World'.
