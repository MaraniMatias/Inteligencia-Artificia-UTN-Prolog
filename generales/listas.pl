% Usos de Listas en Prolog
plantas([manzana, naranja, limon, espinaca, gardenia, alfalfa,pino]).

lista([1,2,3]).

%?-lista([H|T]).
%?-lista([H,J|T]).

% Si queremos hallar la longitud de una lista.
% La longitud de una lista vacia es 0.
% La longitud de cualquier lista es la longitud de la cola + 1.

longitud([],0).
longitud([_|T],N):-longitud(T,N0), N is N0 + 1.
%

% Si queremos determinar si un elemento pertenece a una lista.
% El elemento pertenece a la lista si coincide con la cabeza de la lista.
% El elemento pertenece a la lista si se encuentra en la cola de la lista.

pertenece(X,[X|_]) :- !.
pertenece(X,[_|R]):- pertenece(X,R).

%?- pertenece(b,[a,b,c]).
%?- pertenece(b,[a,[b,c]]).
%?- pertenece([b,c],[a,[b,c]]).
