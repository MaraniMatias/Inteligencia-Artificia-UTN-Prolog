:- dynamic asistencia/4.
:- dynamic ejercicio/6.
:- dynamic nivel/4.
:- dynamic socio/4.

% Socio(dni, apellido, sexo, edad)
socio(d1, matias, m, 26).
socio(d2, romina, f, 25).
socio(d3, pablo, m, 12).
socio(d4, noemi, f, 17).
socio(d5, gabi, f, 45).
socio(d6, oscar, m, 72).
socio(d7, juan, m, 52).
socio(d8, ayumi, f, 27).
% Ejercicio(cod, descripcion, cod.nivel, sexo_recomendado, edad_desde, edad_hasta)
ejercicio(e0, eje_0, 1, f, 12, 35).
ejercicio(e1, eje_1, 2, m, 12, 55).
ejercicio(e2, eje_2, 2, m, 12, 45).
ejercicio(e3, eje_3, 3, _, 22, 35).
ejercicio(e4, eje_4, 3, f, 12, 45).
ejercicio(e5, eje_5, 3, m, 12, 45).
ejercicio(e6, eje_6, 4, _, 12, 25).
ejercicio(e7, eje_7, 3, m, 22, 45).
% Asistencia(fecha, dni, min_entreno, [cod_ejercicios realizados])
asistencia('24-12-2018', d1, 120, [e0, e1, e3]).
asistencia('25-11-2018', d1, 124, [e6, e5, e2]).
asistencia('25-11-2018', d2, 124, [e2, e1]).
% Nivel(cod_nivel, descripcion, cant_hora_desde, cant_hora_hasta)
nivel(n0, lvl_0, 0, 128).
nivel(n1, lvl_1, 128, 256).
nivel(n2, lvl_2, 256, 512).
nivel(n3, lvl_3, 512, 1024).
nivel(n4, lvl_4, 2048, 4096).
nivel(n5, lvl_5, 4096, 8192).
nivel(n6, lvl_6, 8192, 16384).

