%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% alergia(ID, 'Nombre Humano', [SintomaPaso,...], prioridad).
% sintoma_pesos(sintomaID, Peso)
% sintoma(ID, '')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sintomas para testear 12,13,17

% FIXME: Dedonde salio ?
% alergia(plantas, [estornudo, tos, ampollas, granos], [60, 20, 15, 5]).


% Alergia al polen
% Conjuntivitis, picor de ojos, sensación de arenilla en los ojos
% Estornudos, Congestión nasal y picor, Irritabilidad, Tos, asma,
% Dolor de cabeza, Fatiga, Pitidos en el pecho
alergia(00, 'Alergia al polen', [
  sintoma_peso(01, 10),
  sintoma_peso(02, 10),
  sintoma_peso(03, 10),
  sintoma_peso(04, 10),
  sintoma_peso(05, 10),
  sintoma_peso(06, 10),
  sintoma_peso(07, 10),
  sintoma_peso(08, 10),
  sintoma_peso(09, 10),
  sintoma_peso(10, 10)
], 90).

% Alergia acaros:
% rinitis alérgica, secreción nasal, picor nasal, estornudos,
% problemas respiratorios, picor de ojos, enrojecimiento de ojos,
% lagrimeo, picazón de la piel
alergia(01, 'Alergia los acaros', [
  sintoma_peso(02, 20),
  sintoma_peso(05, 10),
  sintoma_peso(08, 5),
  sintoma_peso(12, 5),
  sintoma_peso(13, 5),
  sintoma_peso(14, 5),
  sintoma_peso(15, 20),
  sintoma_peso(16, 20),
  sintoma_peso(17, 5),
  sintoma_peso(18, 5)
], 100).

% Rinitis alergica
% congestion,secreción nasal,estornudos
% Lagrimeo, enrojecimiento y picor de ojos.
alergia(03, 'Rinitis alergica', [
  sintoma_peso(05, 15),
  sintoma_peso(08, 20),
  sintoma_peso(12, 5),
  sintoma_peso(13, 30),
  sintoma_peso(17, 15),
  sintoma_peso(18, 15)
], 0).

% Alergia a la humedad
% rinitis alérgica
% congestión y secreción nasal
% asma, tos, silbidos
% escozor y enrojecimiento en nariz, garganta y ojos
alergia(04, 'Alergia a la humedad', [
  sintoma_peso(01, 25),
  sintoma_peso(11, 5),
  sintoma_peso(16, 10),
  sintoma_peso(17, 10),
  sintoma_peso(19, 20),
  sintoma_peso(20, 10),
  sintoma_peso(21, 10),
  sintoma_peso(22, 5),
  sintoma_peso(23, 5)
], 0).


/*
alergia gatos
congestión nasal, secreción nasal, pérdida olfativa, problemas respiratorios
fatiga
escozor, lagrimeo y enrojecimiento de ojos

alergia perros
congestión nasal, secreción nasal, estornudos y silbidos.
Lagrimeo, enrojecimiento y picor de ojos.

alergia al sol
Erupciones
Eccemas
Urticaria
Enrojecimiento
Inflamación
Picor
Ampollas
Descamación

conjuntivitis alérgica
Enrojecimiento de los ojos, Picor o sensación de ardor.
Inflamación de la conjuntiva o mucosa conjuntival.
Incremento del lagrimeo o secreción acuosa.
Mayor sensibilidad a la luz.

alergia a picaduras:
respiración sibilante, asma, tos
opresión de garganta
dolor de estómago
vómitos
diarrea
urticaria
inflamación
*/

