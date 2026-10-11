% ==========================================================
% Problema 8 reinas NP-Completo Mario Moctezuma Mendoza
% Definimos el tablero con filas y columnas de 1 a 8
% ==========================================================
%fila(1..8).
%columna(1..8).
%se comenta fila y columna para probar con python su ejecucion
%los hechos o atomos se comentan para funcionar estilo planeacion
% ==========================================================
% 1.GENERATE (Generar el espacio de búsqueda)
% Para cada fila F, colocar EXACTAMENTE una reina en alguna columna C
% ==========================================================
1 { reina(F, C) : columna(C) } 1 :- fila(F).

% ==========================================================
% 2. CHECK (Restricciones de Integridad)
% ==========================================================

% a) Dos reinas no pueden compartir la misma columna
:- reina(F1, C), reina(F2, C), F1 != F2.

% b) Dos reinas no pueden compartir la diagonal principal (|F1 - F2| == |C1 - C2|)
:- reina(F1, C1), reina(F2, C2), F1 < F2, F1 - F2 == C1 - C2.

% c) Dos reinas no pueden compartir la diagonal secundaria
:- reina(F1, C1), reina(F2, C2), F1 < F2, F1 - F2 == C2 - C1.

% ==========================================================
% 3. SHOW
% ==========================================================
%#show reina/2.