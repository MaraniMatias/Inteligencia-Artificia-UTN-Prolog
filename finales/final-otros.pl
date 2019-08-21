%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Mesa julio 2010
% Empleado( Cod, Nom, Ape )
% Trabajo( Cod, Descripcion, Precio )
% ABM empleados y trabajos de los empleados
% Determinar para cada empleado el total trabajado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

julio2010:- dynamic(codigo/1), dynamic(empleado/3), dynamic(trabajo/3), consult('c:/empleados.txt'), menu.
menu:- write('Ingrese una Opcion'),nl,
write(' 1 - Nuevo Empleado'),nl,
write(' 2 - Agregar Trabajo'),nl,
write(' 3 - lista importes por empleado'),nl,
write(' 4 - Lista Todo'),nl,
write(' 5 - Salir'),nl,
read(X),opcion(X).

opcion(1):- write('Nombre:' ),read(N),
write('Apellido: '),read(A),
codigo(Nro), Cod is Nro+1, retract(codigo(Nro)),assert(codigo(Cod)),
assert(empleado(Cod,N,A)),
menu.
opcion(2):- write('cod Empleado: '), read(N),
write('Trabajo: '), read(T),
write('Precio: '), read(P),
assert(trabajo(N,T,P)),
menu.
opcion(3):- guardar, write('Listado de Sueldo Total'), nl, listaSueldo.
opcion(4):- nl, write('Listado de empleados'), nl,listaEmpleado.
opcion(5):- guardar.

listaSueldo:- nl, empleado(X,N,A),
write('codigo: '), write(X),
write('Nombre: '), write(N),
write(' Apellido: '), write(A),
write(' Sueldo: '), totalsueldo(X,T),
write(T), nl, fail.
listaSueldo:- retractall(trabajo), consult('c:/empleados.txt'), nl, menu.

totalsueldo(X,T):-sueldo(X,T).
sueldo(X,T):- trabajo(X,D,P), retract(trabajo(X,D,P)), sueldo(X,T1), T is T1 + P.
sueldo(_,0).

listaEmpleado:- empleado(X,N,A), write('codigo: '), write(X),
write(' Nombre: '), write(N),
write(' Apellido: '),write(A), nl, fail.
listaEmpleado:- nl, menu.

guardar:- tell('c:/empleados.txt'),
listing(codigo),
listing(empleado),
listing(trabajo),
told.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final A
% 1 ingreser dos cadenas y mostrar la unión en una lista.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio:-write('ingrese cadena 1:'),read(A),
write('ingrese Cadena 2:'),read(B),
intercepcion(A,B,L),
write('Lista Comun:'), write(L).
intercepcion(A,B,[H|T]):-
atom_length(A,NA),
atom_length(B,NB),
NA > 0, NB > 0,
sub_atom(A,0,1,NA1,H),
sub_atom(A,1,NA1,_,A1),
esta(H,B), intercepcion(A1,B,T).
intercepcion(A,B,T):-
atom_length(A,NA),
atom_length(B,NB),
NA > 0, NB > 0,
sub_atom(A,0,1,NA1,_),
sub_atom(A,1,NA1,_,A1),
intercepcion(A1,B,T).

intercepcion(_,_,[]).

esta(H,B):-atom_length(B,NB), NB > 0,
sub_atom(B,0,1,_,H).
esta(H,B):-atom_length(B,NB), NB > 0,
NB1 is NB-1,
% sub_atom(B,0,1,NB1,_), COMENTADA
sub_atom(B,1,NB1,_,B1),
esta(H,B1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% inicio A
% 2 Recetas de Cocinas.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio:- dynamic(cod/1), dynamic(receta/2), dynamic(ingrediente/3),consult('c:/recetas1.txt'), menu.

menu:- nl, write('1 Alta de Receta'),
nl, write('2 Baja de Receta'),
nl, write('3 Alta de Ingrediente'),
nl, write('4 Baja de Ingrediente'),
nl, write('5 Consulta todo'),
nl, write('6 Consuta Dos Ingrediente'),
nl, write('7 Salir'),
nl, nl, write('Ingrese una opcion: '), read(A), opcion(A).

opcion(1):- nl, write('Ingrese Nuevo Nombre Receta: '), read(N),
cod(Nro), Cod is Nro + 1, retract(cod(Nro)),assert(cod(Cod)),
assert(receta(Cod,N)), menu.
opcion(2):- nl, write('Ingrese Codigo de Receta a eliminar: '), read(C),
retract(receta(C,_)),menu.
opcion(3):- nl, write('Ingrese Codigo de Receta: '), read(C),
write('Ingrese Nuevo Ingrediente: '), read(I),
write('Cantidad Ingrediente: '), read(N),
assert(ingrediente(C,I,N)),menu.
opcion(4):- nl, write('Codigo de Receta:'), read(C),
write('Nombre Ingrediente a Eliminar: '), read(I),
retract(ingrediente(C, I,_)),menu.
opcion(5):- nl, write(' Lista de Recetas '), listarecetas.
opcion(6):- nl, write(' ingrediente 1: '), read(I1),
write(' Ingrediente 2: '), read(I2),
nl, write('Lista de ingredientes ' ),
listaingr(I1, I2).
opcion(_):- tell('c:/recetas1.txt'),
listing(cod),
listing(receta),
listing(ingrediente),
told.

listarecetas:- receta(C, N), nl, write('Cod: '), write(C),
write(' - '), write(N),fail.
listarecetas:- nl, menu.

listaingr(I1,I2):- ingrediente(C, I1,_), ingrediente(C, I2,_),
receta(C, N), write(C), write(' - '), write(N), fail.
listaingr(_,_):- nl, menu.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Agosto 2010
% 1) Agregar lista de palabras agudas y graves.
% 2) Agregar a una BD las palabras de la lista, separando las en agudas termina en n, s o vocal y graves, todas las demas.
% 3) Mostras cantidas de Agudas terminadas en n, cant en s y cant en o.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ago2010:- dynamic(aguda/2), dynamic(grave/2),consult('c:/palabras.txt'), nl,
write('lista de palabras: '), leer(T),
agregarpalabras(T),terminacion('n',C1),
terminacion('s',C2), terminacion('o',C3),
nl, write('terminadas en N: '), write( C1 ),
nl, write('terminadas en S: '), write( C2 ),
nl, write('terminadas en o: '), write( C3 ).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).

agregarpalabras([]).
agregarpalabras([H|T]):- atom_length(H,C), C1 is C-1, sub_atom(H, C1, 1, _, 'n'),
assert(aguda(H,'n')), agregarpalabras(T).
agregarpalabras([H|T]):- atom_length(H,C), C1 is C-1, sub_atom(H, C1, 1, _, 's'),
assert(aguda(H,'s')), agregarpalabras(T).
agregarpalabras([H|T]):- atom_length(H,C), C1 is C-1, sub_atom(H, C1, 1, _, 'a'),
assert(aguda(H,'a')), agregarpalabras(T).
agregarpalabras([H|T]):- atom_length(H,C), C1 is C-1, sub_atom(H, C1, 1, _, 'e'),
assert(aguda(H,'e')), agregarpalabras(T).
agregarpalabras([H|T]):- atom_length(H,C), C1 is C-1, sub_atom(H, C1, 1, _, 'i'),
assert(aguda(H,'i')), agregarpalabras(T).
agregarpalabras([H|T]):- atom_length(H,C), C1 is C-1, sub_atom(H, C1, 1, _, 'o'),
assert(aguda(H,'o')), agregarpalabras(T).
agregarpalabras([H|T]):- atom_length(H,C), C1 is C-1, sub_atom(H, C1, 1, _, 'u'),
assert(aguda(H,'u')), agregarpalabras(T).

terminacion(X,Cant):- aguda(P,X), retract(aguda(P,X)), terminacion(X,Cant1), Cant is Cant1 + 1.
terminacion(_,0).

litarAgudas:- aguda(P,V), nl, write(P), write(V), fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Mesa Mayo 2008 ejercicio 2.
% Ingresar una Lista de enteros y luego devolver otra lista donde:
% el 1º es 2º-1º, el 2º es 3º-2º y asi sucesivamente.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio:-write('Ingrese lista de numeros: '), leer( L ) , listaDif( L, LR ),
write('lista Diferencias:'), write(LR).

listaDif( [],[]).
listaDif( [H1|L],LR ):- dif(H1, L, LR), ascii('a').

dif(_,[],[]).
dif( H1, [H2|L], [H|LR] ):- H is H2-H1, dif(H2, L, LR).

leer([H|T]):-read(H), H \= [], leer(T).
leer([]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Mesa Mayo 2008 ejercicio 1.
% Ingresar una cadena y devolver las suma de sus carasteres en ascii.
% funcion atom_char(C,N) me da el ascii de la variable C.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio:- write('Ingrese Cadena: '), read(A) , sumaletra( A, N ),
write('La suma ascii de los caracteres de la cadena es: '), write(N).

sumaletra(A,0):- atom_length(A,0).
sumaletra(A,N):- sub_atom(A,0,1,Cant,C), atom_char(C,N1),
sub_atom(A,1,Cant,_,A1), sumaletra(A1,N2),
N is N1 + N2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Mesa Marzo 2008 ejercicio 1.
% Ingresar lista y si ultimo caracter es par poner todos los lugares
% pares de la lista en Cero. Si es impar poner lugeres impares en cero.
% Devolver lista resultante
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio :- write( 'ingrese una lista:' ), leer(L1), ultimo(L1,U),
modiParImpar(L1,U,L2), write( 'Lista modificada: ' ),
write(L2).

modiParImpar([],_,[]).
modiParImpar(L1,U,L2) :- R is U mod 2, R = 0, agregaCont(L1,L2).% Si es Par
modiParImpar(L1,_,L2) :- agregaCero(L1,L2).% Si es Impar

agregaCero([],[]).
agregaCero([_|L1],[0|L2]):-agregaCont(L1,L2).

agregaCont([],[]).
agregaCont([H|L1],[H|L2]):-agregaCero(L1,L2).

leer([H|T]):-read(H), H \= [], leer(T).
leer([]).

ultimo([_|T],U):- ultimo(T,U).
ultimo([U|[]],U).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Mesa Marzo 2008 ejercicio 2.
% Ingresar número N y devolver la suma hasta 0. 
% Eje. N= 4 devolver 4+3+2+1+0 = 10.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio:- write('Ingrese un Número:'), read(A),suma_hasta(A,S), write(S).

suma_hasta(0,0).
suma_hasta(A,S):-A1 is A - 1, suma_hasta( A1,S1 ), S is S1 + A.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Mesa 09/10/2008.
% Ingresar una cadena e Identificar Digtongos/Hiatos.
% Ejemplo Digtongo: puerto, Hiato: aeroplano.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio :- write('ingrese una palabra:'),read(A),tipo(A).

tipo(A) :- atom_length(A,N), N>0, sub_atom(A,0,1,N1,C),
sub_atom(A,1,N1,_,A1), digtongo(C,A1).
tipo(A) :- atom_length(A,N), N>0, sub_atom(A,0,1,N1,C),
sub_atom(A,1,N1,_,A1), hiato(C,A1).
tipo(_) :- write('No es Digtongo/Hiato').

digtongo(C,A) :- atom_length(A,N), N>0, sub_atom(A,0,1,_,C1),
esAbierta(C), esCerrada(C1), write('Es Digtongo').
digtongo(C,A) :- atom_length(A,N), N>0, sub_atom(A,0,1,_,C1),
esCerrada(C), esCerrada(C1), C \= C1, write('Es Digtongo').
digtongo(C,A) :- atom_length(A,N), N>0, sub_atom(A,0,1,_,C1),
esCerrada(C), esAbierta(C1), write('Es Digtongo').
digtongo(_,A) :- atom_length(A,N), N>0, sub_atom(A,0,1,N1,C1),
sub_atom(A,1,N1,_,A1), digtongo(C1,A1).

hiato(C,A) :- atom_length(A,N), N>0, sub_atom(A,0,1,_,C1),
esAbierta(C), esAbierta(C1), write( 'Es Hiato' ).
hiato(_,A) :- atom_length(A,N), N>0, sub_atom(A,0,1,N1,C1),
sub_atom(A,1,N1,_,A1), hiato(C1,A1).

esAbierta('a').
esAbierta('e').
esAbierta('o').
esCerrada('i').
esCerrada('u').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Julia Ejercicio 1.
% Ingresar dos listas. Si son del mismo tamaño comparar similitud
% = 100% 'Identicas'
% >= 75% 'Muy Parecidas'
% >= 25% 'Parecidas'
% >= 0% 'Poco Parecidas'
% = 0% 'Nada Parecidas'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio :- write('lista 1:'), leer(L1), write('lista 2:'), leer(L2),
comparaLis(L1,L2).

comparaLis(L1,L2) :- cant(L1,C), cant(L2,C), similitud(L1,L2,N),
Valor is N/C, clasifica(Valor).
comparaLis(_,_) :- write('Listas de distintas Longitudes').

cant([],0).
cant([_|T],N):- cant(T,N1), N is N1 + 1.

similitud([],[],0).
similitud([H|T1],[H|T2],N):- similitud(T1,T2,N1), N is N1 + 1.
similitud([_|T1],[_|T2],N):- similitud(T1,T2,N).


clasifica(N):- N = 1, write('Identicas') .
clasifica(N):- N>=(0.75), write('Muy Parecidas') .
clasifica(N):- N>=(0.25), write('Parecidas') .
clasifica(N):- N>= 0, write('Poco Parecidas') .
clasifica(N):- N = 0, write('Nada Parecidas') .

leer([H|T]):-read(H), H\=[], leer(T).
leer([]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Final Julia Ejercicio 2.
% Ingresar 1 lista y un elemento.
% Borrar de la lista posiciones donde aparesca elemento
% Y decir cuantas veces esta repetido.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inicio :- write('lista 1:'), leer(L1), write('elemento:'), read(A),
limpiezaLista(L1,L2,A,N), write('Lista Limpia:'), write(L2),
nl, write('Esta Repetido: '), write(N), write('veces').

leer([H|T]):-read(H), H\=[], leer(T).
leer([]).

limpiezaLista([H|T1],T2,H,N):-limpiezaLista(T1,T2,H,N1), N is N1 + 1.
limpiezaLista([H|T1],[H|T2],C,N):-limpiezaLista(T1,T2,C,N).
limpiezaLista([],[],_,0).


