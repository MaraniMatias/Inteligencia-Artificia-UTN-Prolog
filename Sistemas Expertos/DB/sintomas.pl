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
sintoma(08, 'picazón de ojos').
sintoma(09, 'pitidos en el pecho').
sintoma(10, 'sensación de arenilla en los ojos').
sintoma(11, 'congestión nasal').

% Acaros
% 08 - picor de ojos
% 05 - estornudos
% 02 - picor nasal
% XX - rinitis alérgica
sintoma(12, 'enrojecimiento de ojos').
sintoma(13, 'lagrimeo').
sintoma(14, 'picazón de la piel').
sintoma(14, 'picazón de piel').
sintoma(15, 'problemas respiratorios').
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
sintoma(19, 'tos').
sintoma(20, 'silbidos').
sintoma(21, 'escozor en nariz').
sintoma(22, 'enrojecimiento en nariz').
sintoma(23, 'garganta').
