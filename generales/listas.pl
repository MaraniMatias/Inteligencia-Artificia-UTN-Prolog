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


% Si queremos eliminar un elemento de la lista.
% Si X es la cabeza de la lista, la cola T es la lista sin X
% Si X no es la cabeza de la lista, conservamos la cabeza de la lista
%     como parte de la respuesta y continuamos eliminando X de la cola T.
elimina(X,[X|T],T).
elimina(X,[H|T],[H|T1]):- elimina(X,T,T1).

%?- elimina(1,[1,2,3,4],R).
%?- elimina(1,R,[2,3]).


% Si queremos concatenar dos listas lista.
% Concatenar una lista vacia con L es L.
% Concatenar X|L1 con L2 es poner el primer
% elemento de la primera lista (X) más la
% concatenación del resto de la lista (L1) con L2

concatenar([],L,L).
concatenar([X|L1],L2,[X|L3]):-concatenar(L1,L2,L3).

%?- concatenar([1,2],[3,4],R).


% Si queremos calcular la inversa de una lista.
% La inversa de una lista vacia es una lista vacia.
% La inversa de H|T es la inversa de T concatenada con H.

inversa([],[]).
inversa([H|T],L):-  inversa(T,R),  concatenar(R,[H],L).

%?- inversa([a,b,c,d],[d,c,b,a]).

% Utilizando un parametro acumulador.

inver(L1,L2):-inver(L1,L2,[]).

inver([],L,L).
inver([H|T],L,S):-inver(T,L,[H|S]).

%?- inver([a,b,c,d],[d,c,b,a]).

