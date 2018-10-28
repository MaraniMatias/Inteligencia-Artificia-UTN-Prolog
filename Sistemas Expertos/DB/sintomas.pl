% TODO: scar los acentos :D
% sintoma(ID, '')

% Polen
sintoma(01, 'asma').
sintoma(02, 'picor nasal').
sintoma(03, 'conjuntivitis').
sintoma(04, 'dolor de cabeza').
sintoma(05, 'estornudos').
sintoma(06, 'fatiga').
sintoma(07, 'irritabilidad').
sintoma(08, 'picor de ojos').
sintoma(08, 'picor en los ojos').
sintoma(08, 'picazón de ojos').
% sintoma(09, 'pitidos en el pecho').
sintoma(09, 'goteo nasal').
sintoma(10, 'sensación de arenilla en los ojos').
sintoma(11, 'congestión nasal').

% Ácaros
% 08 - picor de ojos
% 05 - estornudos
% 02 - picor nasal
% XX - rinitis alérgica
sintoma(12, 'enrojecimiento de ojos').
sintoma(12, 'enrojecimiento de los ojos').
sintoma(13, 'lagrimeo').
sintoma(14, 'picazón de la piel').
sintoma(14, 'picazón de piel').
% sintoma(15, 'problemas respiratorios').
sintoma(17, 'secreción nasal').

% Rinitis alérgica
% 01 - asma
% 04 - dolor de cabeza
% 06 - fatiga
% 02 - picazon nasal
% 05 - estornudos
% 08 - picor de ojos
% 11 - congestión nasal
% 12 - enrojecimiento de ojos
% 13 - lagrimeo
% 17 - secreción nasal
% sintoma(18, 'congestion').

% Alergia a la humedad
% FIXME garganta y ojos
% 01 - asma
% 11 - congestión nasal
% XX - rinitis alérgica
% 17 - secreción nasal
sintoma(19, 'tos').
% sintoma(20, 'silbidos').
sintoma(21, 'sequedad nasal').
sintoma(22, 'enrojecimiento en nariz').
% sintoma(23, 'garganta').

% Alergia animales
% 05 - estornudos
% 06 - fatiga
% 11 - congestión nasal
% 12 - enrojecimiento de ojos
% 13 - lagrimeo
% 15 - problemas respiratorios
% 17 - secreción nasal
sintoma(24, 'pérdida olfativa').
% sintoma(25, 'escozor').

% Alergia al sol
sintoma(26, 'erupciones').
sintoma(27, 'eccemas').
sintoma(28, 'urticaria').
sintoma(29, 'inflamación').
sintoma(30, 'presencia de ronchas').
sintoma(31, 'picor').
sintoma(32, 'ampollas').
sintoma(33, 'descamación').

% Conjuntivitis alérgica
% 12 - enrojecimiento de los ojos,
% 31 - picor,
sintoma(34, 'inflamación de la conjuntiva').
sintoma(35, 'mucosa conjuntiva').
sintoma(36, 'incremento del lagrimeo').
sintoma(37, 'mayor sensibilidad a la luz').

% Alergia a picaduras
% opresión de garganta
% 01 - asma,
% 19 - tos
% 28 - urticaria
% 29 - inflamación
sintoma(38, 'respiración sibilante').
sintoma(39, 'dolor de estómago').
sintoma(40, 'vómitos').
sintoma(41, 'diarrea').
