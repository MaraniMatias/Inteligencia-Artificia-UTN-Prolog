:- dynamic animal/2.

% alimentacion(comida, cantidad)
% bebida(bebida, cantidad)
% reproduccion(epoca,gestacion)
% horas_sueno(horas)

animal(leon, alimentacion(pato, 4)).
animal(leon, bebida(agua, 4)).
animal(leon, reproduccion(invierno, 9)).
animal(leon, horas_sueno(9)).

animal(hormiga, alimentacion(pato, 0.02)).
animal(hormiga, alimentacion(gato, 0.02)).
animal(hormiga, bebida(agua, 0.1)).
animal(hormiga, reproduccion(verano, 1)).
animal(hormiga, horas_sueno(2)).

animal(gato, bebida(agua, 4)).
animal(caracol, bebida(agua, 0.1)).
