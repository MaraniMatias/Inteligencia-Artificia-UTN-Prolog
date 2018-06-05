       Inteligencia Artificial
       Ingeniería en Sistemas de Información




                            Práctica 2
                          PROLOG - Listas

Operaciones básicas

1.    Ingresar una lista de elementos y mostrarla por pantalla.
2.    Ingresar una lista de elementos y mostrar su cabeza y su cola.
3.    Ingresar una lista de elementos y mostrar su primer elemento.
4.    Ingresar una lista de elementos y mostrar sus dos primeros elementos.
5.    Ingresar una lista de elementos y mostrar su último elemento.
6.    Ingresar una lista de números enteros y calcular la diferencia entre el
      primero y el último de ellos.
7.    Ingresar una lista de elementos e informar cuántos elementos tiene.
8.    Ingresar una lista de números enteros e informar cuánto da la
      sumatoria de ellos.
9.    Ingresar una lista de números enteros y calcular su promedio. Respetar
      el formato del predicado promedio(L,S,C) donde L es la lista ingresada,
      S la sumatoria y C el contador de los elementos de la lista.
10.   Ingresar una lista y un elemento e informar si ese elemento está en la lista.
11.   Ingresar una lista de enteros e informar cuál es el mayor de todos los números.
12.   Ingresar una lista de enteros e informar cuál es el menor de todos los números.




13.   Ingresar dos listas de elementos, concatenarlas (los elementos deben
      ser asignados de a uno en la lista de salida) y mostrarlas en una
      tercera.
14.   Ingresar una lista y determinar el primer elemento que se repite.
15.   Ingresar una lista y determinar a través de una segunda lista todos los
      elementos que se repiten.
16.   Ingresar una lista y un elemento e informar cuántas veces está ese
      elemento en la lista.

17.   En una base de hechos hay un registro de personas y viajes realizados:
      persona(nombre, [lista ciudades visitó])
      Construir una regla que permita verificar si una persona visitó una
      determinada ciudad (datos de entrada: nombre persona y ciudad).

Sistema de recomendación de amigos

En una nueva red social UTNook, se tiene la siguiente base de hechos
(archivo UTNook.txt):

%usuario(idUsuario, nombre, localidad).
usuario(1,'Miguel Martinez',rosario).
usuario(2,'Pato Rodríguez',funes).
usuario(3,'Marilyn Perez',rosario).
…
…



                                         -1-
    Inteligencia Artificial
    Ingeniería en Sistemas de Información


%intereses(idUsuario, [lista intereses]).
intereses(1,['natacion','mineria de datos','yoga','comida mexicana']).
intereses(2,['frutas organicas','Fast & Furious','yoga','formula 1']).
…
Dos usuarios de UTNook son candidatos a ser amigos cuando tienen al
menos 2 intereses en común.

Construir un programa en PROLOG que permita:

   a. Dados dos usuarios, mostrar una lista con los intereses que tienen en
      común.
   b. Determinar si dos usuarios son candidatos a ser amigos.
   c. Dados dos usuarios, obtener una lista con todos los intereses de
      ambos (unión).
   d. Dada una ciudad, obtener una lista con los usuarios que viven en ella
      (utilizando el predicado findall/3).




                                       -2-
