/*
empleado(nombre_empleado, profesion, ciudad)
trabaja(nombre_empleado, nombre_empresa, sueldo)
empresa(nombre_empresa, ciudad)
1-  Devolver una lista [] con los nombres de todos los empleados que trabajan en
    la misma ciudad que la que viven.
2-  Mostrar los nombres de los empleados que no trabajan en Microsoft.
3-  Mostrar la tupla "Nombre Empleado - Nombre Empresa", para aquellos empleados
    que ganan más que cualquier empleado de Microsoft.
4-  Calcular el sueldo promedio de los empleados de una determinada empresa (ingresarla),
    que ganan más que el que más gana en Microsoft.
*/
abrirDB_empleado :-
  retractall(empleado(_, _)),
  consult('./DB_final-27-02-14_empleado.pl').
abrirDB_empresa :-
  retractall(empresa(_, _)),
  consult('./DB_final-27-02-14_empresa.pl').
abrirDB_trabaja :-
  retractall(trabaja(_, _, _)),
  consult('./DB_final-27-02-14_trabaja.pl').
:- abrirDB_empleado.
:- abrirDB_empresa.
:- abrirDB_trabaja.

punto_1([Nombre|T]) :-
  empleado(Nombre, _, Ciudad),
  retract(empleado(Nombre, _, Ciudad)),
  empresa(Empresa, Ciudad),
  trabaja(Nombre, Empresa, _),
  punto_1(T).
punto_1(List) :-
  empleado(_, _, _),
  punto_1(List).
punto_1([]) :-
  abrirDB_empleado.

punto_2([Nombre|T]) :-
  empleado(Nombre, _, _),
  retract(empleado(Nombre, _, _)),
  trabaja(Nombre, Empresa, _),
  Empresa \= 'ms',
  punto_2(T).
punto_2(List) :-
  empleado(_, _, _),
  punto_2(List).
punto_2([]) :-
  abrirDB_empleado.

supera_ms(Salario) :-
  trabaja(Nombre, ms, SalarioMS),
  retract(trabaja(Nombre, ms, _)),
  SalarioMS < Salario.
supera_ms(Salario) :-
  trabaja(_, ms, _),
  supera_ms(Salario).

punto_3() :-
  empleado(Nombre, _, _),
  retract(empleado(Nombre, _, _)),
  trabaja(Nombre, Empresa, Salario),
  abrirDB_trabaja,
  supera_ms(Salario),
  writeln([Nombre,'-',Empresa]),
  punto_3().
punto_3() :-
  empleado(_, _, _),
  punto_3().
punto_3() :-
  abrirDB_trabaja,
  abrirDB_empleado.


