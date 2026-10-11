% ==========================================================
% 1. DOMINIO
% Definimos el tablero con filas y columnas de 1 a 8
% ==========================================================
fila(1..8).
columna(1..8).

% ==========================================================
% 2. GENERATE (Generar el espacio de búsqueda)
% En cada fila debe haber EXACTAMENTE una reina
% ==========================================================
1 { reina(F, C) : columna(C) } 1 :- fila(F).

% ==========================================================
% 3. CHECK (Restricciones de Integridad)
% ==========================================================

% a) Dos reinas no pueden estar en la misma columna
:- reina(F1, C), reina(F2, C), F1 != F2.

% b) Dos reinas no pueden estar en la misma diagonal principal (|F1 - F2| == |C1 - C2|)
:- reina(F1, C1), reina(F2, C2), F1 < F2, F1 - F2 == C1 - C2.

% c) Dos reinas no pueden estar en la misma diagonal secundaria
:- reina(F1, C1), reina(F2, C2), F1 < F2, F1 - F2 == C2 - C1.

% ==========================================================
% 4. SHOW (Formato de salida)
% ==========================================================
#show reina/2.