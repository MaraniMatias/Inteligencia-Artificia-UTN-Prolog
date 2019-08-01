/*
1-Ingresar una lista de cadenas y un carácter. 
  Por cada cadena de la lista y el carácter, verificar si ya están en la BD, 
  sino esta registrarlo palabra(cadena,carácter,cantidad).
2-Ingresar un carácter y calcular el promedio de veces que aparece en la BD. 
*/

%MENU PRINCIPAL
:-dynamic palabras/3.

inicio:-cargar,menu(0).

cargar:-consult('C:/palabras.txt').
grabar:-tell('C:/palabras.txt'),listing(palabras),told.

%OPCIONES
menu(0):-write('INGRESE OPCION:'),nl,
write('1- PUNTO 1'),nl,
write('2- PUNTo 2'),nl,
write('3- SALIR'),nl,
read(OP),menu(OP).

menu(1):-punto1,menu(0).
menu(2):-punto2,menu(0).
menu(3).

% PUNTO 1
punto1:-write('INGRESE UNA LISTA DE PALABRAS:'),leer(L),nl,
write('INGRESE CARACTER:'),read(C),nl,
contar(L,C,Cantidad),
buscarBC(L,C,Cantidad).


leer([H|T]):-read(H),atom(H),H\=[],leer(T).
leer([]).

contar([],_,0).
contar([H|T],C,Cantidad):-contar(T,C,Cant),aparece(H,C,Cont), Cantidad is Cant+Cont.
contar([_|T],C,Cantidad):-contar(T,C,Cantidad).

aparece('',_,0).
aparece(H,C,Cont):-sub_atom(H,0,1,RH,SubCad1),SubCad1=C,
sub_atom(H,1,RH,_,SubCad2),aparece(SubCad2,C,C1),Cont is C1+1.
aparece(H,C,Cont):-sub_atom(H,0,1,RH,SubCad1),SubCad1\=C,
sub_atom(H,1,RH,_,SubCad2),aparece(SubCad2,C,Cont).


buscarBC(L,C,Cantidad):-palabras(L,C,Cantidad),write('YA EXISTE'),nl,nl.
buscarBC(L,C,Cantidad):-assert(palabras(L,C,Cantidad)),grabar,write('GRABACION EXITOSA'),nl,nl.


% PUNTO 2
punto2:- cargar, write('INGRESE CARACTER:'),read(C),nl,
calcular(C,Suma,Cantidad),Promedio is Suma/Cantidad,
write('EL PROMEDIO ES:'),write(Promedio),nl,nl.

calcular(C,Suma,Cantidad):-palabras(_,C,Cant),retract(palabras(_,C,Cant)),
calcular(C,S1,C1),Suma is S1+Cant,Cantidad is C1+1.
calcular(_,0,0).

