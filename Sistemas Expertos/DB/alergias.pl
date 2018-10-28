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
], 95).

% Alergia ácaros:
% rinitis alérgica, secreción nasal, picor nasal, estornudos,
% problemas respiratorios, picor de ojos, enrojecimiento de ojos,
% lagrimeo, picazón de la piel
alergia(01, 'Alergia los ácaros', [
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
], 90).

% Rinitis alérgica
% congestion,secreción nasal,estornudos
% Lagrimeo, enrojecimiento y picor de ojos.
alergia(03, 'Rinitis alérgica', [
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

% alergia gatos
% congestión nasal, secreción nasal, pérdida olfativa,
% problemas respiratorios, fatiga, escozor, lagrimeo,
% enrojecimiento de ojos
alergia(06, 'Alergia gatos', [
  sintoma_peso(06, 10),
  sintoma_peso(11, 10),
  sintoma_peso(12, 10),
  sintoma_peso(13, 10),
  sintoma_peso(15, 10),
  sintoma_peso(17, 10),
  sintoma_peso(24, 10),
  sintoma_peso(25, 20)
], 70).

% Alergia perros
% congestión nasal, secreción nasal, estornudos, silbidos, lagrimeo,
% enrojecimiento de ojos, picor de ojos,
alergia(07, 'Alergia perros', [
  sintoma_peso(05, 20),
  sintoma_peso(08, 10),
  sintoma_peso(11, 10),
  sintoma_peso(12, 10),
  sintoma_peso(13, 20),
  sintoma_peso(17, 10),
  sintoma_peso(20, 20)
], 70).

% Alergia al sol
% Erupciones, Eccemas, Urticaria, Enrojecimiento
% Inflamación, Picor, Ampollas, Descamación
alergia(08, 'Alergia al sol', [
  sintoma_peso(26, 20),
  sintoma_peso(27, 10),
  sintoma_peso(28, 10),
  sintoma_peso(29, 10),
  sintoma_peso(30, 20),
  sintoma_peso(31, 10),
  sintoma_peso(32, 20)
  sintoma_peso(33, 10)
], 0).

% Conjuntivitis alérgica
% Enrojecimiento de los ojos, Picor o sensación de ardor.
% Inflamación de la conjuntiva o mucosa conjuntival.
% Incremento del lagrimeo o secreción acuosa.
% Mayor sensibilidad a la luz.
alergia(09, 'Conjuntivitis alérgica', [
  sintoma_peso(12, 20),
  sintoma_peso(31, 10),
  sintoma_peso(34, 20),
  sintoma_peso(35, 20),
  sintoma_peso(36, 20),
  sintoma_peso(37, 10)
], 0).

% Alergia a picaduras
% respiración sibilante, asma, tos
% opresión de garganta
% dolor de estómago
% vómitos
% diarrea
% urticaria
% inflamación
alergia(10, 'Alergia a picaduras', [
  sintoma_peso(01, 20),
  sintoma_peso(19, 20),
  sintoma_peso(28, 20),
  sintoma_peso(29, 10),
  sintoma_peso(37, 20),
  sintoma_peso(38, 10),
  sintoma_peso(39, 20),
  sintoma_peso(40, 20)
], 60).

