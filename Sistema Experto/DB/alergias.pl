%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% alergia(ID, 'Nombre Humano', [SintomaPaso,...], PesoGeneral).
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
  sintoma_peso(03, 11),
  sintoma_peso(04, 3),
  sintoma_peso(05, 12),
  sintoma_peso(06, 3),
  sintoma_peso(07, 6),
  sintoma_peso(08, 10),
  sintoma_peso(09, 12),
  sintoma_peso(10, 3),
  sintoma_peso(11, 10)
], 0.95).

% Alergia ácaros:
% rinitis alérgica, secreción nasal, picor nasal, estornudos,
% problemas respiratorios, picor de ojos, enrojecimiento de ojos,
% lagrimeo, picazón de la piel
alergia(01, 'Alergia los ácaros', [
  sintoma_peso(01, 10),
  sintoma_peso(02, 15),
  sintoma_peso(05, 15),
  sintoma_peso(08, 10),
  sintoma_peso(11, 10),
  sintoma_peso(12, 5),
  sintoma_peso(13, 5),
  sintoma_peso(14, 25),
  sintoma_peso(17, 5)
], 0.90).

% Rinitis alérgica
% congestion,secreción nasal,estornudos
% Lagrimeo, enrojecimiento y picor de ojos.
alergia(03, 'Rinitis alérgica', [
  sintoma_peso(01, 10),
  sintoma_peso(02, 10),
  sintoma_peso(04, 5),
  sintoma_peso(05, 20),
  sintoma_peso(08, 5),
  sintoma_peso(11, 15),
  sintoma_peso(12, 5),
  sintoma_peso(13, 5),
  sintoma_peso(17, 30)
], 0).

% Alergia a la humedad
% rinitis alérgica
% congestión y secreción nasal
% asma, tos, silbidos
% escozor y enrojecimiento en nariz, garganta y ojos
alergia(04, 'Alergia a la humedad', [
  sintoma_peso(01, 25),
  sintoma_peso(02, 5),
  sintoma_peso(05, 15),
  sintoma_peso(11, 10),
  sintoma_peso(17, 6),
  sintoma_peso(19, 23),
  sintoma_peso(21, 6),
  sintoma_peso(22, 6)
], 0).

% alergia animales
% congestión nasal, secreción nasal, pérdida olfativa,
% problemas respiratorios, fatiga, escozor, lagrimeo,
% enrojecimiento de ojos
alergia(06, 'Alergia animales', [
  sintoma_peso(05, 25),
  sintoma_peso(06, 5),
  sintoma_peso(11, 20),
  sintoma_peso(12, 15),
  sintoma_peso(13, 10),
  sintoma_peso(15, 5),
  sintoma_peso(17, 10),
  sintoma_peso(21, 5),
  sintoma_peso(24, 5)
], 0.70).

% Alergia al sol
% Erupciones, Eccemas, Urticaria, Enrojecimiento
% Inflamación, Picor, Ampollas, Descamación
alergia(08, 'Alergia al sol', [
  sintoma_peso(28, 30),
  sintoma_peso(29, 20),
  sintoma_peso(14, 30),
  sintoma_peso(32, 10),
  sintoma_peso(33, 10)
], 0).

% Conjuntivitis alérgica
% Enrojecimiento de los ojos, Picor o sensación de ardor.
% Inflamación de la conjuntiva o mucosa conjuntival.
% Incremento del lagrimeo o secreción acuosa.
% Mayor sensibilidad a la luz.
alergia(09, 'Conjuntivitis alérgica', [
  sintoma_peso(08, 30),
  sintoma_peso(12, 30),
  % sintoma_peso(34, 10),
  sintoma_peso(13, 20),
  sintoma_peso(37, 10)
], 0).

% Alergia a picaduras
% asma
% dificultad para respirar
% dolor de estómago
% vómitos
% diarrea
% inflamación
% roncha en la piel
alergia(10, 'Alergia a picaduras', [
  sintoma_peso(01, 10),
  sintoma_peso(28, 10),
  sintoma_peso(29, 5),
  sintoma_peso(38, 5),
  sintoma_peso(39, 25),
  sintoma_peso(40, 25),
  sintoma_peso(41, 20)
], 0.60).
