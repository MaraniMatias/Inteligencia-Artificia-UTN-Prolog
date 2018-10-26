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
sintoma(09, 'pitidos en el pecho').
sintoma(10, 'sensación de arenilla en los ojos').
sintoma(11, 'congestión nasal').

% Acaros
% 08 - picor de ojos
% 05 - estornudos
% 02 - picor nasal
sintoma(12, 'enrojecimiento de ojos').
sintoma(13, 'lagrimeo').
sintoma(14, 'picazón de la piel').
sintoma(15, 'problemas respiratorios').
sintoma(16, 'rinitis alérgica').
sintoma(17, 'secreción nasal').

% Rinitis alergica
% 05 - estornudos
% 08 - picor de ojos
% 12 - enrojecimiento de ojos
% 13 - lagrimeo
% 17 - secreción nasal
sintoma(18, 'congestion').

% Alergia a la humedad
% FIXME garganta y ojos
% 01 - asma
% 11 - congestión nasal 
% 16 - rinitis alérgica
% 17 - secreción nasal
sintoma(18, 'tos').
sintoma(19, 'silbidos').
sintoma(20, 'escozor en nariz').
sintoma(21, 'enrojecimiento en nariz').
sintoma(22, 'garganta').
