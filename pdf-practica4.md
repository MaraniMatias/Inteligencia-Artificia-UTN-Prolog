                   Práctica 4
        PROLOG - Base de datos y Functores

1. Hacer un programa que permita definir las cuentas a pagar del mes (luz,
agua, alquiler, teléfono, cable, supermercado, etc.) de un grupo de
personas. A su vez, deberá permitir ingresar el nombre de una de ellas e
informar de todos sus gastos.


2. Hacer un programa que defina una Base de datos de personas de la
siguiente forma:
      personas(codigo,nombre).
El programa debe permitir ingresar un código y verificar si el mismo está
definido en la BBDD. De estarlo deberá informar a quién corresponde, de lo
contrario deberá solicitar ingresar un nombre y registrar entonces la
persona en la BBDD.


3. Desarrollar un programa que permita definir los hábitos de:
      • alimentación (comida, cantidad)
      • bebida (bebida, cantidad)
      • reproducción (época de reproducción, período de gestación)
      • horas de sueño

de un conjunto de animales de un Zoo.
Dicha información se guardará en una base de datos.
El programa, deberá permitir:
a. Ingresar el nombre de un animal e informar de todos sus hábitos.
b. Ingresar un hábito e informar todos los animales que lo tienen.

4. Ampliar el ejercicio 1 a través del uso de functores. Por ejemplo:
   gasto(maria, super(coto,500)).
   gasto(omar, tel(fijo,telecom,150)).
   gasto(maria,tel(movil,personal,100)).

a. Ingresar un gasto (por ej. super) e informar todas las personas que
tienen dicho gasto.
b. Informar las personas que tienen un consumo superior a los $150 en un
cierto gasto (dato de entrada).
c. Calcular gasto promedio para una determinada persona (dato de
entrada).



                                        -1-
    Inteligencia Artificial
    Ingeniería en Sistemas de Información


5. Hacer un programa que permita realizar altas, bajas y consultas a la base
de datos de una librería. De cada libro se registran los siguientes datos:
      • Nro. de libro (auto numérico)
      • Titulo
      • Autor
      • Editorial
      • Precio

La base datos debe guardarse en disco.
Calcular además el precio promedio de los libros de un determinado autor.

6. Hacer un programa que permita registrar en una Base de Datos recetas
de cocina. De cada receta se registran los siguientes datos:
      • Código de receta
      • Nombre de la receta
Y por cada ingrediente que contenga la receta:
      • Nombre del ingrediente
      • Cantidad
A su vez, permitir ingresar dos (2) ingredientes e informar de todas las
recetas (Código y Nombre) que poseen ambos ingredientes.
Por otro lado, para un ingrediente en particular y una cierta cantidad del
mismo, determinar aquellas recetas que llevan ese ingrediente y superan
dicha cantidad.




                                         -2-

